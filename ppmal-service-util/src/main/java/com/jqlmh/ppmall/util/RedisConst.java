package com.jqlmh.ppmall.util;

/**
 * @author LMH
 * @create 2020-04-14 20:46
 */

public class RedisConst {

	//sku相关
	public static final String SKU_PREFIX="sku:";
	public static final String SKUINFO_SUFFIX=":info";

	//member相关
	public static final String OMSCARTITEM_PREFIX="member:";

	//购物车
	public static final String OMSCARTITEM_SUFFIX=":cart";

	//用户信息
	public static final String UMSMEMBER_INFO_SUFFIX=":info";
	//用户token
	public static final String UMSMEMBER_TOKEN_SUFFIX=":token";

	//订单交易码
	public static final String MEMBER_TRADECODE_SUFFIX=":tradeCode";



	//分布式锁
	public static final String SKULOCK_SUFFIX=":lock";
}
