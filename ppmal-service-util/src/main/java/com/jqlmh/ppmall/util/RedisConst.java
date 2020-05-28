package com.jqlmh.ppmall.util;

/**
 * redis的key命名常量类
 *
 * @author LMH
 * @create 2020-04-14 20:46
 */

public class RedisConst {

	/**
	 * SKU的redis前缀
	 */
	public static final String SKU_PREFIX = "sku:";

	/**
	 * SKU信息的redis后缀
	 */
	public static final String SKU_INFO_SUFFIX = ":info";

	/**
	 * 购物车信息的redis后缀
	 */
	public static final String OMS_CART_ITEM_SUFFIX = ":cart";

	/**
	 * 购物车信息的redis前缀
	 */
	public static final String OMS_CART_ITEM_PREFIX = "member:";


	/**
	 * 用户信息的redis后缀
	 */
	public static final String UMS_MEMBER_INFO_SUFFIX = ":info";

	/**
	 * 用户Token后缀
	 */
	public static final String UMS_MEMBER_TOKEN_SUFFIX = ":token";

	/**
	 * 订单交易码后缀
	 */
	public static final String MEMBER_TRADE_CODE_SUFFIX = ":tradeCode";


	/**
	 * 分布式锁后缀
	 */
	public static final String SKU_LOCK_SUFFIX = ":lock";
}
