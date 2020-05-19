package com.jqlmh.ppmall.payment.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.jqlmh.ppmall.bean.PaymentInfo;
import com.jqlmh.ppmall.payment.mapper.PaymentInfoMapper;
import com.jqlmh.ppmall.service.PaymentService;
import com.jqlmh.ppmall.util.ActiveMQUtil;
import org.apache.activemq.ScheduledMessage;
import org.apache.activemq.command.ActiveMQMapMessage;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.entity.Example;

import javax.jms.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * @author LMH
 * @create 2020-04-27 21:05
 */
@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentInfoMapper paymentInfoMapper;

	@Autowired
	private ActiveMQUtil activeMQUtil;

	@Autowired
	private AlipayClient alipayClient;


	/**
	 * 在支付之前保存支付的相关信息
	 *
	 * @param paymentInfo 支付信息对象
	 */
	@Override
	public void savePaymentInfoBeforePay(PaymentInfo paymentInfo) {
		paymentInfoMapper.insertSelective(paymentInfo);
	}


	/**
	 * 在支付成功后,在支付信息表更新支付宝返回的参数信息
	 *
	 * @param paymentInfo 支付信息对象
	 */
	@Override
	public void updatePaymentInfoAfterPay(PaymentInfo paymentInfo) {

		//幂等性检查
		Example example1 = new Example(PaymentInfo.class);
		example1.createCriteria().andEqualTo("outTradeNo",paymentInfo.getOutTradeNo());
		PaymentInfo isPaymentInfoExist = paymentInfoMapper.selectOneByExample(example1);
		if (isPaymentInfoExist != null && "交易支付成功".equals(isPaymentInfoExist.getPaymentStatus())) {
			return;
		}

		Example example = new Example(PaymentInfo.class);
		example.createCriteria().andEqualTo("outTradeNo", paymentInfo.getOutTradeNo());

		Connection connection = null;
		Session session = null;
		MessageProducer producer = null;

		try {
			paymentInfoMapper.updateByExampleSelective(paymentInfo, example);

			connection = activeMQUtil.getConnectionFactory().createConnection();
			connection.start();

			//支付成功后,引起的系统服务改变-->订单服务的更-->库存服务更新-->物流
			//调用mq发送支付成功的消息

			//开启事务
			session = connection.createSession(true, Session.SESSION_TRANSACTED);
			Queue paymentSuccessQueue = session.createQueue("PAYMENT_RESULT_QUEUE");
			//创建消息队列

			//创建生产者
			producer = session.createProducer(paymentSuccessQueue);

			//生成消息内容
			//TextMessage message = new ActiveMQTextMessage();
			MapMessage message = new ActiveMQMapMessage();  //hash结构的消息
			message.setString("outTradeNo", paymentInfo.getOutTradeNo());

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


	/**
	 * 在提交订单后,向消息中间件发送一个检查支付状态的(被支付服务消费)延迟消息队列,定时发送
	 *
	 * @param outOrderNo 外部订单号
	 * @param checkCount 检查次数
	 */
	@Override
	public void sendDelayPaymentResult(String outOrderNo, int checkCount) {
		Connection connection = null;
		Session session = null;
		MessageProducer producer = null;
		try {
			connection = activeMQUtil.getConnectionFactory().createConnection();
			connection.start();

			//更新订单信息成功后
			//调用mq发送支付成功的消息

			//开启事务
			session = connection.createSession(true, Session.SESSION_TRANSACTED);
			Queue orderPayedQueue = session.createQueue("PAYMENT_CHECK_QUEUE");
			//创建消息队列

			//创建生产者
			producer = session.createProducer(orderPayedQueue);

			//生成消息内容
			//TextMessage message = new ActiveMQTextMessage();
			MapMessage message = new ActiveMQMapMessage();  //hash结构的消息
			message.setLongProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY, 1000 * 60);  //设置延迟方式和时间
			message.setString("outOrderNo", outOrderNo);
			message.setInt("checkCount", checkCount);

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


	/**
	 * 通过外部订单号去检查当前订单的订单状态
	 *
	 * @param outOrderNo
	 * @return
	 */
	@Override
	public Map<String, Object> checkAlipayPaymentStatus(String outOrderNo) {
		AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();

		//封装查询参数map,转换为字符串
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("out_trade_no", outOrderNo);
		String param = JSON.toJSONString(paramMap);

		//设置查询参数.发送请求
		request.setBizContent(param);
		AlipayTradeQueryResponse response = null;
		String body=null;
		try {
			response = alipayClient.execute(request);
			body = alipayClient.pageExecute(request).getBody();
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}

		//System.out.println(body);

		if (response != null && response.isSuccess()) {
			System.out.println("交易已创建,检查成功");
			//将支付宝返回的参数返回给消费端
			Map<String, Object> map = new HashMap<>();
			map.put("outTradeNo", response.getOutTradeNo());
			map.put("tradeNo", response.getTradeNo());
			map.put("tradeStatus", response.getTradeStatus());
			map.put("callBackContent", body.split("&")[2].substring(5));
			return map;
		} else {
			System.err.println("可能交易未创建,检查失败");
			return null;
		}
	}
}
