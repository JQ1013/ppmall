package com.jqlmh.ppmall.cart.service.impl;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.OmsCartItem;
import com.jqlmh.ppmall.bean.PmsSkuInfo;
import com.jqlmh.ppmall.cart.mapper.OmsCartItemMapper;
import com.jqlmh.ppmall.service.CartService;
import com.jqlmh.ppmall.service.SkuService;
import com.jqlmh.ppmall.util.RedisConst;
import com.jqlmh.ppmall.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;
import tk.mybatis.mapper.entity.Example;

import java.math.BigDecimal;
import java.util.*;

/**
 * @author LMH
 * @create 2020-04-22 22:43
 */
@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private OmsCartItemMapper omsCartItemMapper;

	@Autowired
	private RedisUtil redisUtil;


	@Reference
	private SkuService skuService;

	/**
	 * 从db中查出购物车当前订单数据
	 *
	 * @param memberId
	 * @param skuId
	 * @return
	 */
	@Override
	public OmsCartItem getCartCheckedByMemberIdAndSkuId(String memberId, String skuId) {
		Example example = new Example(OmsCartItem.class);
		example.createCriteria().andEqualTo("memberId", memberId).andEqualTo("productSkuId", skuId);
		return omsCartItemMapper.selectOneByExample(example);
	}


	/**
	 * 保存新增的订单信息,需要有用户id:memberId
	 *
	 * @param omsCartItem
	 */
	@Override
	public void savaCart(OmsCartItem omsCartItem) {
		if (StringUtils.isNotBlank(omsCartItem.getMemberId())) {
			omsCartItemMapper.insertSelective(omsCartItem);
		}
	}

	/**
	 * db中已经有该订单信息,执行字段更新操作
	 *
	 * @param omsCartItemFromDb
	 */
	@Override
	public void updateCart(OmsCartItem omsCartItemFromDb) {
		omsCartItemMapper.updateByPrimaryKeySelective(omsCartItemFromDb);
	}

	/**
	 * 操作数据库后同步redis缓存:根据memberId查询所有sku信息,先删除redis的缓存,在放入redis缓存
	 *
	 * @param memberId
	 */
	@Override
	public void synchronizeCartCache(String memberId) {

		try (Jedis jedis = redisUtil.getJedis()) {
			//从db中查询对应用户的购物车信息
			List<OmsCartItem> omsCartItems = getCartListByMemberIdFromDB(memberId);

			//创建一个map用于存放购物车信息
			Map<String, String> cartMap = new HashMap<>();
			for (OmsCartItem omsCartItem : omsCartItems) {
				omsCartItem.setTotalPrice(omsCartItem.getPrice().multiply(new BigDecimal(omsCartItem.getQuantity())));
				cartMap.put(omsCartItem.getProductSkuId(), JSON.toJSONString(omsCartItem));
			}

			//同步到redis缓存中
			String omsKey = RedisConst.OMSCARTITEM_PREFIX + memberId + RedisConst.OMSCARTITEM_SUFFIX; //member:memberId:cart

			jedis.del(omsKey);
			jedis.hmset(omsKey, cartMap);
		} catch (Exception e) {
			System.out.println("redis发生了错误:" + e.getMessage());
		}

	}


	/**
	 * 根据memberId查询该用户的所有订单信息,先缓存.再db
	 *
	 * @param memberId 用户id
	 * @return 订单信息list
	 */
	@Override
	public List<OmsCartItem> getCartList(String memberId) {

		List<OmsCartItem> omsCartItemList = new ArrayList<>();
		try (Jedis jedis = redisUtil.getJedis()) {
			//一.先从缓存中查
			String omsKey = RedisConst.OMSCARTITEM_PREFIX + memberId + RedisConst.OMSCARTITEM_SUFFIX;

			//查询的json字符串,是一个list
			List<String> OmsJsons = jedis.hvals(omsKey);
			if (OmsJsons != null && !OmsJsons.isEmpty()) {
				//(1)缓存中有数据
				for (String omsJson : OmsJsons) {

					OmsCartItem omsCartItem = JSON.parseObject(omsJson, OmsCartItem.class);

					omsCartItemList.add(omsCartItem);
				}

			} else {
				//(2)缓存中没有数据,查询db
				//1.设置分布式锁
				//分布式锁key
				String lockKey = RedisConst.OMSCARTITEM_PREFIX + memberId + RedisConst.SKULOCK_SUFFIX;
				String token = UUID.randomUUID().toString();
				String IsOk = jedis.set(lockKey, token, "NX", "PX", 10 * 1000); //拿到锁的线程有10秒的过期时间

				//2.如果设置分布式锁返回ok
				if (StringUtils.isNotBlank(IsOk) && IsOk.equalsIgnoreCase("ok")) {
					//2.1设置成功,有权在10秒内访问数据库
					omsCartItemList = getCartListByMemberIdFromDB(memberId);
					if (omsCartItemList != null) {
						//mysql查询结果存入redis
						//创建一个map用于存放购物车信息
						Map<String, String> cartMap = new HashMap<>();
						for (OmsCartItem omsCartItem : omsCartItemList) {
							omsCartItem.setTotalPrice(omsCartItem.getPrice().multiply(new BigDecimal(omsCartItem.getQuantity())));
							cartMap.put(omsCartItem.getProductSkuId(), JSON.toJSONString(omsCartItem));
						}
						//同步到redis缓存中
						jedis.hmset(omsKey, cartMap);
					} else {
						//2.2数据库不存在该sku
						//为了防止缓存穿透,在redis中缓存一个null或者""空字符串,过期时间设置很短3分钟
						jedis.hmset(omsKey, null);
						jedis.expire(omsKey, 60 * 3);

					}

					//2.3在访问mysql之后,将mysql的分部锁释放
					String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
					//jedis.eval("lua");可与用lua脚本，在查询到key的同时删除该key，防止高并发下的意外的发生
					jedis.eval(script, Collections.singletonList(lockKey), Collections.singletonList(token)); //用token确认删除的是自己的sku的锁

				} else {
					//3.如果设置分布式锁返回nil
					// 设置失败,自旋
					return getCartList(memberId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return omsCartItemList;
	}

	/**
	 * 从数据库根据memberId查询所有的oms信息
	 *
	 * @param memberId
	 * @return
	 */
	@Override
	public List<OmsCartItem> getCartListByMemberIdFromDB(String memberId) {
		Example example = new Example(OmsCartItem.class);
		example.createCriteria().andEqualTo("memberId", memberId);
		return omsCartItemMapper.selectByExample(example);
	}


	/**
	 * 修改制定用户、制定skuId的选中状态
	 *
	 * @param skuId
	 * @param isChecked
	 * @param memberId
	 */
	@Override
	public void updateCartIsChecked(String skuId, String isChecked, String memberId) {
		Example example = new Example(OmsCartItem.class);
		example.createCriteria().andEqualTo("memberId", memberId).andEqualTo("productSkuId", skuId);
		omsCartItemMapper.updateByExampleSelective(
				new OmsCartItem().setProductSkuId(skuId).setMemberId(memberId).setIsChecked(isChecked),
				example);

		//缓存同步
		synchronizeCartCache(memberId);
	}


	/**
	 * 检查购物车的商品价格和该sku的页面价格是否一致
	 *
	 * @param productSkuId skuId
	 * @param price        购物车sku价格
	 * @return sameSkuPrice
	 */
	@Override
	public boolean checkPrice(String productSkuId, BigDecimal price) {
		boolean isSameSkuPrice = false;
		//获得购物车sku价格
		PmsSkuInfo skuInfo = skuService.getSkuInfoById(productSkuId);
		if (skuInfo.getPrice().compareTo(price) == 0) {
			//价格一致
			isSameSkuPrice = true;
		}
		return isSameSkuPrice;
	}


	/**
	 * 删除购物车已经提交订单的sku
	 *
	 * @param skuId 购物车对应skuId
	 */
	@Override
	public void deleteCartSku(String skuId) {
		Example example = new Example(OmsCartItem.class);
		example.createCriteria().andEqualTo("productSkuId", skuId);
		omsCartItemMapper.deleteByExample(example);
	}
}
