package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.OmsCartItem;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author LMH
 * @create 2020-04-23 12:41
 */
public interface CartService {
	OmsCartItem getCartCheckedByMemberIdAndSkuId(String memberId, String skuId);

	void savaCart(OmsCartItem omsCartItem);

	void updateCart(OmsCartItem omsCartItemFromDb);

	void synchronizeCartCache(String memberId);

	/**
	 * 先从缓存拿数据,如果没有再从db取数据
	 * @param memberId
	 * @return
	 */
    List<OmsCartItem> getCartList(String memberId);


	/**
	 * 直接从数据库取数据
	 * @param memberId
	 * @return
	 */
	List<OmsCartItem> getCartListByMemberIdFromDb(String memberId);

	void updateCartIsChecked(String skuId, String isChecked, String memberId);

	boolean checkPrice(String productSkuId, BigDecimal price);

	void deleteCartSku(String skuId);
}
