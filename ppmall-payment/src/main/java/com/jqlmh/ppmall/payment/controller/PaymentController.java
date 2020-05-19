package com.jqlmh.ppmall.payment.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.jqlmh.ppmall.annotation.LoginRequired;
import com.jqlmh.ppmall.bean.OmsOrder;
import com.jqlmh.ppmall.bean.PaymentInfo;
import com.jqlmh.ppmall.payment.config.AlipayConfig;
import com.jqlmh.ppmall.service.OrderService;
import com.jqlmh.ppmall.service.PaymentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author LMH
 * @create 2020-04-27 14:41
 */
@Controller
public class PaymentController {

	@Autowired
	private AlipayClient alipayClient;

	@Reference
	private OrderService orderService;

	@Autowired
	private PaymentService paymentService;


	/**
	 * 处理提交订单后去支付页面的请求
	 *
	 * @param outOrderNo
	 * @param settlementPrice
	 * @param productName
	 * @param request
	 * @param model
	 * @return
	 */
	@LoginRequired(mustLogin = true)
	@RequestMapping("/toPayment")
	public String toPayment(String outOrderNo, BigDecimal settlementPrice, String productName, HttpServletRequest request, Model model) {

		String memberId = (String) request.getAttribute("memberId"); //获取从登陆页面放入request域中的memberId值
		String nickname = (String) request.getAttribute("nickname");

		model
				.addAttribute("nickname", nickname)
				.addAttribute("memberId", memberId)
				.addAttribute("outOrderNo", outOrderNo)
				.addAttribute("settlementPrice", settlementPrice)
				.addAttribute("productName", productName);

		return "index";
	}


	/**
	 * 处理页面选择支付宝支付方式后提交订单的请求
	 *
	 * @param outOrderNo
	 * @param settlementPrice
	 * @param productName
	 * @return
	 */
	@LoginRequired(mustLogin = true)
	@ResponseBody
	@RequestMapping("/aliPay/submit")
	public String aliPay(String outOrderNo, BigDecimal settlementPrice, String productName) {

		//获得支付宝的一个请求的客户端,他不是一个连接,而是创建一个表单并发送给支付宝
		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest(); //创建API对应的request

		//回调地址
		alipayRequest.setReturnUrl(AlipayConfig.return_payment_url);
		alipayRequest.setNotifyUrl(AlipayConfig.notify_payment_url); //在公共参数中设置回跳和通知地址


		//填充业务参数
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("out_trade_no", outOrderNo);
		paramMap.put("product_code", "FAST_INSTANT_TRADE_PAY");
		paramMap.put("total_amount", 0.01);
		paramMap.put("subject", productName);
		String param = JSON.toJSONString(paramMap);

		alipayRequest.setBizContent(param); //填充业务参数

		String form = "";
		try {
			form = alipayClient.pageExecute(alipayRequest).getBody();  //调用SDK生成表单
			System.err.println(form);
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}

		//生成并保存用户的支付信息[未支付前的]
		//先根据外部订单号查出该笔交易的信息
		OmsOrder omsOrder = orderService.getOrderInfoByOutOrderNo(outOrderNo);
		PaymentInfo paymentInfo = new PaymentInfo();
		paymentInfo
				.setOrderId(omsOrder.getId())
				.setCreateTime(new Date())
				.setOutTradeNo(outOrderNo)
				.setPaymentStatus("未付款")
				.setSubject(productName)
				.setTotalAmount(settlementPrice);

		paymentService.savePaymentInfoBeforePay(paymentInfo);

		//提交订单后,还没有结算
		//向消息中间件发送一个检查支付状态的(被支付服务消费)延迟消息队列
		paymentService.sendDelayPaymentResult(outOrderNo, 5);

		return form;
	}


	/**
	 * 处理页面选择微信支付方式的请求
	 *
	 * @param outOrderNo
	 * @param settlementPrice
	 * @param productName
	 * @return
	 */
	@LoginRequired(mustLogin = true)
	@RequestMapping("/weChat/submit")
	public String weChat(String outOrderNo, BigDecimal settlementPrice, String productName) {
		return "finish";
	}


	/**
	 * 支付成功后,返回的页面
	 *
	 * @return
	 */
	@RequestMapping("/alipay/callback/return")
	public String alipayCallBackReturn(HttpServletRequest request,Model model) {

		String sign = request.getParameter("sign");
		String trade_no = request.getParameter("trade_no");
		String out_trade_no = request.getParameter("out_trade_no");
		String call_back_content = request.getParameter("sign");

		//通过支付宝的paramsMap进行签名验证,alipay-sdk 2.0的接口将这个paramsMap参数去掉了,导致同步请求没法验签名
		//假设验签
		if (StringUtils.isNotBlank(sign)) {
			//验签成功
			//更新支付信息表,在此之前先检查幂等性


			PaymentInfo paymentInfo = new PaymentInfo();
			paymentInfo
					.setOutTradeNo(out_trade_no)
					.setPaymentStatus("交易支付成功")
					.setAlipayTradeNo(trade_no)   //支付宝交易凭证号
					.setCallbackTime(new Date())
					.setCallbackContent(call_back_content);  //回调请求字符串

			//支付成功后,需要更新数据库中的用户的支付状态
			//支付成功后,引起的系统服务改变-->订单服务的更-->库存服务更新-->物流
			//调用mq发送支付成功的消息
			paymentService.updatePaymentInfoAfterPay(paymentInfo);
		}
		return "finish";
	}

}
