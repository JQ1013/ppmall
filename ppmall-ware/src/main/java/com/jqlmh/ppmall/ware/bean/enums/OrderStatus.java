package com.jqlmh.ppmall.ware.bean.enums;

/**
 * @param
 * @return
 */
public enum OrderStatus {
	/**
	 *未支付
	 */
	UNPAID("未支付"),

	/**
	 * 已支付
	 */
	PAID("已支付"),

	/**
	 * 待发货
	 */
	WAITING_DELIVER("待发货"),

	/**
	 * 已发货
	 */
	DELIVERED("已发货"),

	/**
	 * 交易一已关闭
	 */
	CLOSED("已关闭"),

	/**
	 * 已完成
	 */
	FINISHED("已完结"),

	/**
	 * 订单已拆分
	 */
	SPLIT("订单已拆分");

	private String comment;


	OrderStatus(String comment) {
		this.comment = comment;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}


}
