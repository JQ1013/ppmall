package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.OmsOrder;

/**
 * @author LMH
 * @create 2020-04-26 16:39
 */
public interface OrderService {
	String generateTradeCode(String memberId);

	boolean checkTradeCode(String memberId,String tradeCode);

	void saveOmsOrder(OmsOrder omsOrder);

	OmsOrder getOrderInfoByOutOrderNo(String outOrderNo);
}
