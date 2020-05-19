package com.jqlmh.ppmall.order.service.impl;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.OmsOrder;
import com.jqlmh.ppmall.bean.OmsOrderItem;
import com.jqlmh.ppmall.order.mapper.OmsOrderItemMapper;
import com.jqlmh.ppmall.order.mapper.OmsOrderMapper;
import com.jqlmh.ppmall.service.CartService;
import com.jqlmh.ppmall.service.OrderService;
import com.jqlmh.ppmall.util.ActiveMQUtil;
import com.jqlmh.ppmall.util.RedisConst;
import com.jqlmh.ppmall.util.RedisUtil;
import org.apache.activemq.command.ActiveMQTextMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import redis.clients.jedis.Jedis;
import tk.mybatis.mapper.entity.Example;

import javax.jms.*;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

/**
 * @author LMH
 * @create 2020-04-26 16:38
 */
@Service
public class OrderServiceImpl implements OrderService {


	@Autowired
	private RedisUtil redisUtil;

	@Autowired
	private OmsOrderMapper omsOrderMapper;

	@Autowired
	private OmsOrderItemMapper omsOrderItemMapper;

	@Reference
	private CartService cartService;

	@Autowired
	private ActiveMQUtil activeMQUtil;

	/**
	 * 生成订单交易码,存入缓存,设置过期时间15min
	 *
	 * @param memberId
	 * @return
	 */
	@Override
	public String generateTradeCode(String memberId) {

		String tradeCodeKey = RedisConst.OMSCARTITEM_PREFIX + memberId + RedisConst.MEMBER_TRADECODE_SUFFIX; //member:,memberId:tradeCode
		String tradeCode = UUID.randomUUID().toString();

		try (Jedis jedis = redisUtil.getJedis()) {
			if (jedis != null) {
				jedis.setex(tradeCodeKey, 60 * 15, tradeCode);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tradeCode;
	}

	/**
	 * 从缓存中根据memberId查找是否有对应交易码
	 *
	 * @param memberId
	 * @return
	 */
	@Override
	public boolean checkTradeCode(String memberId, String tradeCode) {

		boolean TradeCodeValid = false;

		String tradeCodeKey = RedisConst.OMSCARTITEM_PREFIX + memberId + RedisConst.MEMBER_TRADECODE_SUFFIX; //member:,memberId:tradeCode
		try (Jedis jedis = redisUtil.getJedis()) {
			if (jedis != null) {
				String tradeCodeFromCache = jedis.get(tradeCodeKey);

				//使用lua脚本防止高并发下.一个请求还没来得及判断交易码是否相同,多个请求同时进来,造成多个请求的交易码都校验成功
				//在查询到key的同时删除该key，防止高并发下的订单攻击
				String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
				Long evalResult = (Long) jedis.eval(script, Collections.singletonList(tradeCodeKey), Collections.singletonList(tradeCodeFromCache));//用token确认删除的是自己的sku的锁

				//缓存中交易码不为空且等于订单页面传来的交易码
				if (evalResult != null && evalResult != 0) {
					//有效交易码,查询到删除,此次交易有效
					TradeCodeValid = true;  //交易码有效
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return TradeCodeValid;
	}


	/**
	 * 保存用户的一个提交订单信息,并同时删除购物车已生成提单的sku
	 *
	 * @param omsOrder
	 */
	@Override
	public void saveOmsOrder(OmsOrder omsOrder) {

		//保存订单表
		omsOrderMapper.insertSelective(omsOrder);
		String orderId = omsOrder.getId();

		//保存订单详情包
		List<OmsOrderItem> omsOrderItemList = omsOrder.getOmsOrderItemList();
		for (OmsOrderItem omsOrderItem : omsOrderItemList) {
			omsOrderItem.setOrderId(orderId);
			omsOrderItemMapper.insertSelective(omsOrderItem);

			//删除购物车的已提交的订单信息[便于测试,暂时不删除]
			// String skuId=omsOrderItem.getProductSkuId();
			// cartService.deleteCartSku(skuId);
		}

	}


	/**
	 * 根据外部订单号查出该笔交易的信息
	 *
	 * @param outOrderNo
	 * @return
	 */
	@Override
	public OmsOrder getOrderInfoByOutOrderNo(String outOrderNo) {
		Example example = new Example(OmsOrder.class);
		example.createCriteria().andEqualTo("orderSn", outOrderNo);
		return omsOrderMapper.selectOneByExample(example);
	}


	/**
	 * 根据监听到的消息队列消息更新order表的信息
	 *
	 * @param mapMessage 监听到的消息
	 */
	@JmsListener(destination = "PAYMENT_RESULT_QUEUE", containerFactory = "jmsQueueListener")
	public void updateOrderStatus(MapMessage mapMessage) {
		//获取消息队列总指定的消息
		String outTradeNo = "";
		try {
			outTradeNo = mapMessage.getString("outTradeNo");
			System.out.println(outTradeNo);
		} catch (JMSException e) {
			e.printStackTrace();
		}

		//更新订单状态
		Example example = new Example(OmsOrder.class);
		example.createCriteria().andEqualTo("orderSn", outTradeNo);


		//更新完后发送一个消息到队列,提供给库存系统消费
		Connection connection = null;
		Session session = null;
		MessageProducer producer = null;
		try {
			omsOrderMapper.updateByExampleSelective(new OmsOrder().setStatus(1), example);
			connection = activeMQUtil.getConnectionFactory().createConnection();
			connection.start();

			//更新订单信息成功后
			//调用mq发送支付成功的消息

			//开启事务
			session = connection.createSession(true, Session.SESSION_TRANSACTED);
			Queue orderPayedQueue = session.createQueue("ORDER_RESULT_QUEUE");
			//创建消息队列

			//创建生产者
			producer = session.createProducer(orderPayedQueue);

			//生成消息内容
			TextMessage message = new ActiveMQTextMessage();
			//MapMessage message = new ActiveMQMapMessage();  //hash结构的消息

			//查询订单信息的对象,转化为json字符串,存入ORDER_RESULT_QUEUE队列中,便于库存系统使用数据
			OmsOrder omsOrder = omsOrderMapper.selectOneByExample(example);

			//通过外部订单号查询所有该笔订单的商品信息
			Example example1 = new Example(OmsOrderItem.class);
			example1.createCriteria().andEqualTo("orderSn", outTradeNo);

			//设置订单信息对象的OmsOrderItemList属性
			List<OmsOrderItem> omsOrderItemList = omsOrderItemMapper.selectByExample(example1);
			omsOrder.setOmsOrderItemList(omsOrderItemList);

			message.setText(JSON.toJSONString(omsOrder));

			//发送消息
			producer.send(message);
			session.commit();
		} catch (Exception e) {
			try {
				//消息回滚
				Objects.requireNonNull(session).rollback();
			} catch (JMSException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				Objects.requireNonNull(producer).close();
				session.close();
				Objects.requireNonNull(connection).close();
			} catch (JMSException e) {
				e.printStackTrace();
			}
		}

	}
}
