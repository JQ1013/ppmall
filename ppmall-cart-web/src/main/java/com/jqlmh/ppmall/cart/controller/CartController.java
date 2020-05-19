package com.jqlmh.ppmall.cart.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.annotation.LoginRequired;
import com.jqlmh.ppmall.bean.OmsCartItem;
import com.jqlmh.ppmall.bean.PmsSkuInfo;
import com.jqlmh.ppmall.service.CartService;
import com.jqlmh.ppmall.service.SkuService;
import com.jqlmh.ppmall.util.CookieUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author LMH
 * @create 2020-04-22 21:16
 */
@Controller
@CrossOrigin
public class CartController {

	@Reference
	private SkuService skuService;

	@Reference
	private CartService cartService;


	/**
	 * 处理ajax发送的获取内嵌页面的请求
	 *
	 * @param isChecked
	 * @param skuId
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @return
	 */
	@LoginRequired
	@RequestMapping("/checkCart")
	public String checkCart(String isChecked, String skuId, HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {

		String memberId = (String) request.getAttribute("memberId");
		String nickName = (String) request.getAttribute("nickname");
		//调用服务,修改状态
		cartService.updateCartIsChecked(skuId, isChecked, memberId);

		//将最新的数据从缓存中查询,渲染给内嵌页
		List<OmsCartItem> omsCartItemList = cartService.getCartList(memberId);
		model.addAttribute("cartList", omsCartItemList);


		//计算所有勾选的购物车的总价
		BigDecimal settlementPrice = getSettlementPrice(omsCartItemList);
		model.addAttribute("settlementPrice", settlementPrice);

		return "cartListInner";
	}


	/**
	 * 处理去购物车结算页面的请求
	 *
	 * @param request  请求
	 * @param response 响应
	 * @return 购物车详情页面
	 */
	@LoginRequired
	@RequestMapping("/cartList")
	public String cartList(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {

		List<OmsCartItem> omsCartItemList = new ArrayList<>();

		String memberId = (String) request.getAttribute("memberId"); //获取从登陆页面放入request域中的memberId值
		String nickname = (String) request.getAttribute("nickname");

		//1.用户已登录
		if (StringUtils.isNotBlank(memberId)) {
			//查询db[先从缓存查,再从redis中查]
			omsCartItemList = cartService.getCartList(memberId);

		} else {
			//2.用户未登录
			//2.1查询cookie
			String cartListCookie = CookieUtil.getCookieValue(request, "cartListCookie", true);

			if (StringUtils.isNotBlank(cartListCookie)) {
				//2.2cookie中有数据,将cookie字符串转为对象list
				omsCartItemList = JSON.parseArray(cartListCookie, OmsCartItem.class);

			}
		}

		//计算单个订单总价
		for (OmsCartItem omsCartItem : omsCartItemList) {
			omsCartItem.setTotalPrice(omsCartItem.getPrice().multiply(new BigDecimal(omsCartItem.getQuantity())));
		}
		model.addAttribute("cartList", omsCartItemList);

		//计算所有勾选的购物车的总价
		BigDecimal settlementPrice = getSettlementPrice(omsCartItemList);
		model.addAttribute("settlementPrice", settlementPrice);

		return "cartList";
	}

	/**
	 * 计算所有勾选的购物车的总价
	 *
	 * @param omsCartItemList 购物车信息
	 * @return settlementPrice:结算总价
	 */
	private BigDecimal getSettlementPrice(List<OmsCartItem> omsCartItemList) {

		BigDecimal settlementPrice = new BigDecimal("0");
		for (OmsCartItem omsCartItem : omsCartItemList) {
			if ("1".equals(omsCartItem.getIsChecked())) {
				settlementPrice = settlementPrice.add(omsCartItem.getTotalPrice());
			}
		}

		return settlementPrice;
	}


	/**
	 * 处理加入购物车的请求
	 *
	 * @param skuId    skuId
	 * @param quantity 加入购物车sku数量
	 * @param request  请求
	 * @param response 响应
	 * @return 加入购物车成功页面
	 */
	@LoginRequired
	@RequestMapping("/addToCart")
	public String addToCart(String skuId, Integer quantity, HttpServletRequest request, HttpServletResponse response) {
		//一、调用商品服务查询商品信息
		PmsSkuInfo skuInfo = skuService.getSkuById(skuId, "");

		//二、将商品信息封装成购物车信息
		OmsCartItem omsCartItem = new OmsCartItem();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		omsCartItem
				.setCreateDate(new Date())
				.setDeleteStatus(0)
				.setModifyDate(new Date())
				.setPrice(skuInfo.getPrice())
				.setProductAttr("")
				.setProductBrand("")
				.setProductCategoryId(skuInfo.getCatalog3Id())
				.setProductName(skuInfo.getSkuName())
				.setProductPic(skuInfo.getSkuDefaultImg())
				.setProductSkuId(skuId)
				.setProductId(skuInfo.getSpuId())
				.setQuantity(quantity);

		//三、判断用户是否登录
		String memberId = (String) request.getAttribute("memberId");//获取从登陆页面放入request域中的memberId值
		String nickname = (String) request.getAttribute("nickname");

		/*
		不管用户是否登录,所有购物车信息,是一个集合,多个订单
			--->未登录:当前浏览器中的购物车所有订单信息
			--->已登录:db中的购物车所有订单信息
		*/
		List<OmsCartItem> omsCartItemList = new ArrayList<>();


		//(1)用户没有登录
		if (StringUtils.isBlank(memberId)) {

			//1.先获取浏览器已经有的cookie值(原有的购物车数据),转换为对象list
			String cartListCookie = CookieUtil.getCookieValue(request, "cartListCookie", true);

			if (StringUtils.isBlank(cartListCookie)) {
				//1.1获取的原有的购物车数据为空
				omsCartItemList.add(omsCartItem);
			} else {
				//1.2获取的原有的购物车数据不为空
				omsCartItemList = JSON.parseArray(cartListCookie, OmsCartItem.class);

				//2.判断原来的购物车数据中是否已经有该订单
				boolean isExist = Check_cart_exist(omsCartItemList, omsCartItem);

				if (isExist) {
					//2.1之前添加过该订单,更新购物车数量
					//遍历cookie中的订单数据
					for (OmsCartItem cartItem : omsCartItemList) {
						//当cookie中的订单的skuId和当前要加入购物车的skuId相同时,就更新cookie中这个订单的信息(数量)
						if (cartItem.getProductSkuId().equals(omsCartItem.getProductSkuId())) {
							cartItem.setQuantity(cartItem.getQuantity() + omsCartItem.getQuantity());
						}
					}
				} else {
					//2.2之前没有添加过购物车,新增当前订单到购物车
					omsCartItemList.add(omsCartItem);
				}
			}

			//3.每次更新购物车的数据后都要覆盖浏览器端的cookie[服务器修改的是浏览器cookie的副本,所以修改完后需要返回去覆盖浏览器的cookie]
			CookieUtil.setCookie(
					request,
					response,
					"cartListCookie",
					JSON.toJSONString(omsCartItemList),
					60 * 5, true);

		} else {
			//(2)用户已登录
			//1.从db中查出购物车当前订单数据
			OmsCartItem omsCartItemFromDb = cartService.getCartCheckedByMemberIdAndSkuId(memberId, skuId);

			if (omsCartItemFromDb == null) {
				//1.1db中未添加过当前sku
				omsCartItem
						.setMemberId(memberId)
						.setMemberNickname("test423")
						.setProductSkuCode(
								sdf.format(new Date())
								+ String.format("%04d", Integer.parseInt(skuInfo.getSpuId()))
								+ String.format("%03d", Integer.parseInt(memberId))
						);

				cartService.savaCart(omsCartItem);
			} else {
				//2.2db中添加过当前sku,更新数量
				omsCartItemFromDb.setQuantity(omsCartItem.getQuantity() + omsCartItemFromDb.getQuantity());

				cartService.updateCart(omsCartItemFromDb);
			}
			//2.操作数据库后同步缓存
			cartService.synchronizeCartCache(memberId);
		}

		return "redirect:/success.html";
	}


	/**
	 * 根据skuId检查原来的购物车里面是否已经有该订单
	 *
	 * @param omsCartItemList
	 * @param omsCartItem
	 * @return
	 */
	private boolean Check_cart_exist(List<OmsCartItem> omsCartItemList, OmsCartItem omsCartItem) {
		boolean isExist = false;
		for (OmsCartItem cartItem : omsCartItemList) {
			if (cartItem.getProductSkuId().equals(omsCartItem.getProductSkuId())) {
				isExist = true;
			}
		}
		return isExist;
	}

}
