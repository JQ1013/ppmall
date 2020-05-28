package com.jqlmh.ppmall.ware.bean.enums;

/**
 * @author LMH
 * @create 2020-04-26 10:53
 */
public enum PaymentWay {

	/**
	 * 在线支付
	 */
	ONLINE("在线支付"),

	/**
	 * 货到付款
	 */
	OUTLINE("货到付款");


	private String comment;


	PaymentWay(String comment) {
		this.comment = comment;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}


}
