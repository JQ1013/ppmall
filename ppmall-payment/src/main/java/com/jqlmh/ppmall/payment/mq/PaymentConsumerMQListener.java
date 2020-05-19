package com.jqlmh.ppmall.payment.mq;

import com.jqlmh.ppmall.bean.PaymentInfo;
import com.jqlmh.ppmall.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import javax.jms.JMSException;
import javax.jms.MapMessage;
import java.util.Date;
import java.util.Map;

/**
 * 消费延迟队列的消息,检查当前订单的交易状态,根据交易状态
 * 交易成功:更新支付信息发送订单队列(幂等性检查等)
 * 交易失败:设置重新发送延迟队列的时间和消息
 *
 * @author LMH
 * @create 2020-04-29 11:36
 */


@Component
public class PaymentConsumerMQListener {


	@Autowired
	private PaymentService paymentService;

	/**
	 * 消费延迟队列的消息,检查当前订单的交易状态,做不同操作
	 *
	 * @param mapMessage
	 */
	@JmsListener(destination = "PAYMENT_CHECK_QUEUE", containerFactory = "jmsQueueListener")
	public void consumePaymentCheckResult(MapMessage mapMessage) {


		String outOrderNo = null;
		int checkCount = 0;
		try {
			outOrderNo = mapMessage.getString("outOrderNo");
			checkCount = mapMessage.getInt("checkCount");
		} catch (JMSException e) {
			e.printStackTrace();
		}

		//调用paymentService支付宝接口进行支付状态检查
		System.err.println("开始第" + checkCount + "次进行支付状态检查");
		Map<String, Object> alipayTradeResponseMap = paymentService.checkAlipayPaymentStatus(outOrderNo);

		if (alipayTradeResponseMap != null) {
			//订单状态
			String tradeStatus = (String) alipayTradeResponseMap.get("tradeStatus");

			//根据查询的订单状态,判断是否进行下一次的延迟任务还是支付成功更新数据+后续任务
			if ("TRADE_SUCCESS".equals(tradeStatus)) {
				//支付成功,更新支付信息发送支付消息队列

				//在支付信息更新之前,进行支付更新的幂等性检查操作
				//因为在支付宝给我们回调的时候,我们验签成功后会更新支付信息表,这样子在我们检查状态后发现支付成功后又会执行一次更新支付信息表操作,所以需要幂等性检查


				PaymentInfo paymentInfo = new PaymentInfo();
				paymentInfo
						.setOutTradeNo(outOrderNo)
						.setPaymentStatus("交易支付成功")
						.setAlipayTradeNo((String) alipayTradeResponseMap.get("tradeNo"))   //支付宝交易凭证号
						.setCallbackTime(new Date())
						.setCallbackContent((String) alipayTradeResponseMap.get("callBackContent"));  //回调请求字符串

				//更新支付信息表
				//检查幂等性:在更新表信息方法中 先检查:先看能不能差不该条记录的paymentStatus值是不是已经设置为"交易支付成功"
				paymentService.updatePaymentInfoAfterPay(paymentInfo);

				System.err.println("已经支付成功,调用支付服务,修改支付信息和发送支付结果队列");
				return;
			}

		}

		checkCount--;
		if (checkCount > 0) {
			//支付失败,继续发送延迟消息队列,计算延迟时间等
			System.err.println("没有支付成功,检查次数为:" + checkCount + ",继续发送延迟队列消息");
			paymentService.sendDelayPaymentResult(outOrderNo, checkCount);
		} else {
			System.err.println("检查剩余次数用尽，结束检查");
		}


	}
}
