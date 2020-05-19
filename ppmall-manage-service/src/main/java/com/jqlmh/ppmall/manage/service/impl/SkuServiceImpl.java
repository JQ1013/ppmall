package com.jqlmh.ppmall.manage.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.PmsSkuAttrValue;
import com.jqlmh.ppmall.bean.PmsSkuImage;
import com.jqlmh.ppmall.bean.PmsSkuInfo;
import com.jqlmh.ppmall.bean.PmsSkuSaleAttrValue;
import com.jqlmh.ppmall.manage.mapper.PmsSkuAttrValueMapper;
import com.jqlmh.ppmall.manage.mapper.PmsSkuImageMapper;
import com.jqlmh.ppmall.manage.mapper.PmsSkuInfoMapper;
import com.jqlmh.ppmall.manage.mapper.PmsSkuSaleAttrValueMapper;
import com.jqlmh.ppmall.service.SkuService;
import com.jqlmh.ppmall.util.RedisConst;
import com.jqlmh.ppmall.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;
import tk.mybatis.mapper.entity.Example;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

/**
 * @author LMH
 * @create 2020-04-11 21:08
 */

@Service
public class SkuServiceImpl implements SkuService {


	@Autowired
	private PmsSkuInfoMapper pmsSkuInfoMapper;

	@Autowired
	private PmsSkuImageMapper pmsSkuImageMapper;

	@Autowired
	private PmsSkuAttrValueMapper pmsSkuAttrValueMapper;

	@Autowired
	private PmsSkuSaleAttrValueMapper pmsSkuSaleAttrValueMapper;

	@Autowired
	private RedisUtil redisUtil;

	/**
	 * 保存sku信息
	 *
	 * @param pmsSkuInfo 前端传来的sku信息
	 */
	@Override
	public void saveSkuInfo(PmsSkuInfo pmsSkuInfo) {
		//1.保存sku信息--pms_sku_info
		pmsSkuInfoMapper.insertSelective(pmsSkuInfo);
		System.out.println("sku平台属性信息:" + pmsSkuInfo.getSkuAttrValueList());
		System.out.println("sku销售属性信息" + pmsSkuInfo.getSkuSaleAttrValueList());

		System.out.println("sku图片信息:" + pmsSkuInfo.getSkuDefaultImg());
		//获取skuId
		String skuInfoId = pmsSkuInfo.getId();

		//2.保存sku图片信息---pms_sku_image
		List<PmsSkuImage> pmsSkuImageList = pmsSkuInfo.getSkuImageList();
		for (PmsSkuImage pmsSkuImage : pmsSkuImageList) {
			pmsSkuImage.setSkuId(skuInfoId);
			pmsSkuImageMapper.insertSelective(pmsSkuImage);
		}

		//3.保存平台属性关联---pms_sku_attr_value
		List<PmsSkuAttrValue> pmsSkuAttrValueList = pmsSkuInfo.getSkuAttrValueList();
		for (PmsSkuAttrValue pmsSkuAttrValue : pmsSkuAttrValueList) {
			pmsSkuAttrValue.setSkuId(skuInfoId);
			pmsSkuAttrValueMapper.insert(pmsSkuAttrValue);
		}

		//4.保存销售属性---pms_sku_sale_attr_value
		List<PmsSkuSaleAttrValue> pmsSkuSaleAttrValueList = pmsSkuInfo.getSkuSaleAttrValueList();
		for (PmsSkuSaleAttrValue pmsSkuSaleAttrValue : pmsSkuSaleAttrValueList) {
			pmsSkuSaleAttrValue.setSkuId(skuInfoId);
			pmsSkuSaleAttrValueMapper.insertSelective(pmsSkuSaleAttrValue);
		}

	}

	/**
	 * 根据skuId查询sku信息+图片信息(从数据库)
	 *
	 * @param skuId
	 * @return
	 */
	@Override
	public PmsSkuInfo getSkuByIdFromDB(String skuId) {
		//sku商品对象
		PmsSkuInfo pmsSkuInfo = pmsSkuInfoMapper.selectByPrimaryKey(skuId);

		//sku图片集合
		Example example = new Example(PmsSkuImage.class);
		example.createCriteria().andEqualTo("skuId", skuId);
		List<PmsSkuImage> pmsSkuImageList = pmsSkuImageMapper.selectByExample(example);
		pmsSkuInfo.setSkuImageList(pmsSkuImageList);

		return pmsSkuInfo;
	}


	/**
	 * 根据skuId查询sku信息+图片信息(从redis缓存)
	 *
	 * @param skuId
	 * @param remoteAddr
	 * @return
	 */
	@Override
	public PmsSkuInfo getSkuById(String skuId, String remoteAddr) {
		System.out.println("ip为" + remoteAddr + "的同学" + Thread.currentThread().getName() + "进入的商品详情的需求");

		PmsSkuInfo pmsSkuInfo;

		// 链接缓存
		Jedis jedis = redisUtil.getJedis();
		// 查询缓存
		String skuKey = RedisConst.SKU_PREFIX + skuId + RedisConst.SKUINFO_SUFFIX;
		String skuJson = jedis.get(skuKey);
		//分布式锁key
		String skuLockKey = RedisConst.SKU_PREFIX + skuId + RedisConst.SKULOCK_SUFFIX;

		if (StringUtils.isNotBlank(skuJson)) {
			System.out.println("ip为" + remoteAddr + "的同学" + Thread.currentThread().getName() + "从缓存中获取商品详情");

			pmsSkuInfo = JSON.parseObject(skuJson, PmsSkuInfo.class);
		} else {
			// 如果缓存中没有，查询mysql
			System.out.println("ip为" + remoteAddr + "的同学" + Thread.currentThread().getName() + "发现缓存中没有,申请缓存的分布式锁:" + skuLockKey);

			//设置分布式锁
			//问题一:如果在redis中的锁已经过期,然后锁过期的那个请求又执行完毕,回来删锁,怎么办?
			/*
				也就说,在一个请求A进来的时候,先设置了锁,有10秒的过期时间,然后在这期间,去查询数据库,,但是查询数据库这一过程超过了10秒,在数据还没有放进redis缓存中;
			10秒后,设置的锁已经过期了,另外一个请求B在这个锁过期后就进来,因为数据还没放进缓存中,所以会从数据库查询,设置自己B的锁,这个时候,请求A继续执行删除锁的代码,
			就会jedis.del(skuLockKey);这个删除的锁就会是请求B设置的锁;
				解决:使用一个token来做校验:
				设置锁的时候使用一个随机数作为value,在删除锁之前,先获取这个key对应的value--jedis.get(skuLockKey);
				然后判断通过这个key获取的锁的值,是否等于设置锁的时候的value,确保删除的是同一个请求的锁,而不是别的请求的锁;

			*/
			String token = UUID.randomUUID().toString();
			String IsOk = jedis.set(skuLockKey, token, "NX", "PX", 10 * 1000); //拿到锁的线程有10秒的过期时间
			//如果设置分布式锁返回ok
			if (StringUtils.isNotBlank(IsOk) && IsOk.equalsIgnoreCase("ok")) {
				//设置成功,有权在10秒内访问数据库
				System.out.println("ip为" + remoteAddr + "的同学" + Thread.currentThread().getName() + "有权在10秒的过期时间内访问数据库:" + skuLockKey);
				pmsSkuInfo = getSkuByIdFromDB(skuId);

				if (pmsSkuInfo != null) {
					// mysql查询结果存入redis
					jedis.set(skuKey, JSON.toJSONString(pmsSkuInfo));
				} else {
					//数据库不存在该sku
					//为了防止缓存穿透,在redis中缓存一个null或者""空字符串,过期时间设置很短3分钟
					jedis.setex(skuKey, 60 * 3, JSON.toJSONString(""));
				}

				//在访问mysql之后,将mysql的分部锁释放

				//问题二:如果碰巧在查询redis锁,还没执行删除锁的时候,正在网络传输,锁过期了怎么办;
				/*
				 * 也就说:在我们判断锁是不是同一个锁的值的时候,刚好要删除之前,这个请求A的锁过期了;在这个判断完成之后,删除之前的点点间隙之间,
				 * 另外一个请求B进来设置了锁,那么删除了就是B的锁而不是A的锁了;
				 *
				 * 解决办法:有没有一种可能在查询到key的同时删除该key，防止高并发下的意外的发生(查询到就删除,没有查询到就执行该脚本操作)
				 * 也就是lua脚本
				 */
				String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
				//jedis.eval("lua");可与用lua脚本，在查询到key的同时删除该key，防止高并发下的意外的发生
				jedis.eval(script, Collections.singletonList(skuLockKey), Collections.singletonList(token)); //用token确认删除的是自己的sku的锁

				System.out.println("ip为" + remoteAddr + "的同学" + Thread.currentThread().getName() + "使用完毕,将锁归还:" + skuLockKey);
			} else {
				//如果设置分布式锁返回nil
				// 设置失败,自旋
				System.out.println("ip为" + remoteAddr + "的同学" + Thread.currentThread().getName() + "没有拿到锁,开始自旋");
				return getSkuById(skuId, remoteAddr);
			}
		}
		jedis.close();
		return pmsSkuInfo;
	}


	/**
	 * 点击销售属性组合切换详情页面
	 *
	 * @param spuId
	 * @return
	 */
	@Override
	public List<PmsSkuInfo> getSkuSaleAttrValueListBySpuId(String spuId) {
		return pmsSkuInfoMapper.selectSkuSaleAttrValueListBySpu(spuId);
	}

	/**
	 * 查询所有的skuInfo信息
	 *
	 * @return
	 */
	@Override
	public List<PmsSkuInfo> getPmsSkuInfos() {
		List<PmsSkuInfo> pmsSkuInfoList = pmsSkuInfoMapper.selectAll();

		for (PmsSkuInfo pmsSkuInfo : pmsSkuInfoList) {
			String skuInfoId = pmsSkuInfo.getId();

			Example example = new Example(PmsSkuAttrValue.class);
			example.createCriteria().andEqualTo("skuId", skuInfoId);
			List<PmsSkuAttrValue> pmsSkuAttrValueList = pmsSkuAttrValueMapper.selectByExample(example);

			pmsSkuInfo.setSkuAttrValueList(pmsSkuAttrValueList);
		}
		return pmsSkuInfoList;
	}

	/**
	 * 根据主键获取sku信息
	 * @param productSkuId
	 * @return
	 */
	@Override
	public PmsSkuInfo getSkuInfoById(String productSkuId) {
		return pmsSkuInfoMapper.selectByPrimaryKey(productSkuId);
	}


}
