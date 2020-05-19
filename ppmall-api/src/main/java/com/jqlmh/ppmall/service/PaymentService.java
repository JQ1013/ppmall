package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PaymentInfo;

import java.util.Map;

/**
 * @author LMH
 * @create 2020-04-27 21:52
 */
public interface PaymentService {
	void savePaymentInfoBeforePay(PaymentInfo paymentInfo);

	void updatePaymentInfoAfterPay(PaymentInfo paymentInfo);

	void sendDelayPaymentResult(String outOrderNo,int checkCount);

	Map<String, Object> checkAlipayPaymentStatus(String outOrderNo);
}
