package com.jqlmh.ppmall.ware.enums;

/**
 * 任务枚举类
 *
 * @author LMH
 * @create 2020-04-26 10:53
 */
public enum TaskStatus {
	/**
	 * 已付款
	 */
	PAID("已付款"),

	/**
	 * 已减库存
	 */
	DEDUCTED("已减库存"),

	/**
	 * 库存超卖
	 */
	OUT_OF_STOCK("已付款，库存超卖"),

	/**
	 * 已出库
	 */
	DELIVERED("已出库"),

	/**
	 * 已拆分
	 */
	SPLIT("已拆分");


	private String comment;


	TaskStatus(String comment) {
		this.comment = comment;
	}


	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
}
