package com.jqlmh.ppmall.ware.bean.enums;

/**
 * @author LMH
 * @create 2020-04-26 10:53
 */
public enum PaymentStatus {

	/**
	 *支付中
	 */
	UNPAID("支付中"),

	/**
	 * 已支付
	 */
	PAID("已支付"),

	/**
	 * 支付失败
	 */
	PAY_FAIL("支付失败"),

	/**
	 * 已关闭
	 */
	ClOSED("已关闭");

	private final String name;

	PaymentStatus(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}}
