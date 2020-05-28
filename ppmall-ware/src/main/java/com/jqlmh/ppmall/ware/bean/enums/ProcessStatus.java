package com.jqlmh.ppmall.ware.bean.enums;

/**
 * 枚举类:订单状态
 *
 * @author LMH
 * @create 2020-04-26 10:53
 */
public enum ProcessStatus {
	/**
	 * 未支付
	 */
	UNPAID("未支付", OrderStatus.UNPAID),

	/**
	 * 已支付
	 */
	PAID("已支付", OrderStatus.PAID),

	/**
	 * 已通知仓储
	 */
	NOTIFIED_WARE("已通知仓储", OrderStatus.PAID),

	/**
	 * 待发货
	 */
	WAITING_DELIVER("待发货", OrderStatus.WAITING_DELIVER),

	/**
	 * 库存异常
	 */
	STOCK_EXCEPTION("库存异常", OrderStatus.PAID),

	/**
	 * 已发货
	 */
	DELIVERED("已发货", OrderStatus.DELIVERED),

	/**
	 * 已关闭
	 */
	CLOSED("已关闭", OrderStatus.CLOSED),

	/**
	 * 已完结
	 */
	FINISHED("已完结", OrderStatus.FINISHED),

	/**
	 * 支付失败
	 */
	PAY_FAIL("支付失败", OrderStatus.UNPAID),

	/**
	 * 订单已拆分
	 */
	SPLIT("订单已拆分", OrderStatus.SPLIT);

	private String comment;
	private OrderStatus orderStatus;

	ProcessStatus(String comment, OrderStatus orderStatus) {
		this.comment = comment;
		this.orderStatus = orderStatus;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public OrderStatus getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(OrderStatus orderStatus) {
		this.orderStatus = orderStatus;
	}


}
