package com.jqlmh.ppmall.order.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.annotation.LoginRequired;
import com.jqlmh.ppmall.bean.OmsCartItem;
import com.jqlmh.ppmall.bean.OmsOrder;
import com.jqlmh.ppmall.bean.OmsOrderItem;
import com.jqlmh.ppmall.bean.UmsMemberReceiveAddress;
import com.jqlmh.ppmall.service.CartService;
import com.jqlmh.ppmall.service.MemberService;
import com.jqlmh.ppmall.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author LMH
 * @create 2020-04-26 10:53
 */

@Controller
public class OrderController {


	@Reference
	private MemberService memberService;

	@Reference
	private CartService cartService;


	@Reference
	private OrderService orderService;

	/**
	 * 订单结算页面:将页面需要的信息查出来返回页面
	 *
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @return
	 */
	@LoginRequired(mustLogin = true)
	@RequestMapping("/toTrade")
	public String toTrade(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {

		String memberId = (String) request.getAttribute("memberId"); //获取从登陆页面放入request域中的memberId值
		String nickname = (String) request.getAttribute("nickname");
		model.addAttribute("nickname", nickname);

		//查出收件人地址列表
		List<UmsMemberReceiveAddress> receiveAddressList = memberService.listMemberReceiveAddress(memberId);
		model.addAttribute("receiveAddressList", receiveAddressList);

		//查出购物车集合
		List<OmsCartItem> cartList = cartService.getCartList(memberId);
		//循环购物车集合.没循环一个购物车对象就转换为一个OmsOrderItem对象--订单产品详细信息对象
		List<OmsOrderItem> omsOrderItems = new ArrayList<>();
		for (OmsCartItem omsCartItem : cartList) {
			//购物车为选中状态
			if (omsCartItem.getIsChecked().equals("1")) {
				OmsOrderItem omsOrderItem = new OmsOrderItem();
				omsOrderItem
						.setProductId(omsCartItem.getProductId())
						.setProductSkuId(omsCartItem.getProductSkuId())
						.setProductQuantity(omsCartItem.getQuantity())
						.setProductPrice(omsCartItem.getPrice())
						.setSp1(omsCartItem.getSp1())
						.setSp2(omsCartItem.getSp2())
						.setSp3(omsCartItem.getSp3())
						.setProductPic(omsCartItem.getProductPic())
						.setProductName(omsCartItem.getProductName())
						.setProductSkuCode(omsCartItem.getProductSkuCode())
						.setProductBrand(omsCartItem.getProductBrand())
						.setProductSn(omsCartItem.getProductSn())
						.setProductAttr(omsCartItem.getProductAttr());

				omsOrderItems.add(omsOrderItem);
			}
		}
		model.addAttribute("omsOrderItems", omsOrderItems);


		//计算结算总价
		BigDecimal settlementPrice = getSettlementPrice(cartList);
		model.addAttribute("settlementPrice", settlementPrice);


		//生成订单交易码,为了在提交订单是做交易码的校验[每个用户同一时间一次购买],放入redis,设置过期时间,用完就毁掉
		String tradeCode = orderService.generateTradeCode(memberId);
		model.addAttribute("tradeCode", tradeCode);

		return "trade";
	}


	/**
	 * @param memberReceiveAddressId
	 * @param request
	 * @return
	 */
	@LoginRequired(mustLogin = true)
	@RequestMapping("/submitOrder")
	public ModelAndView submitOrder(String memberReceiveAddressId, String tradeCode, HttpServletRequest request, ModelAndView mav) {

		String memberId = (String) request.getAttribute("memberId"); //获取从登陆页面放入request域中的memberId值
		String nickname = (String) request.getAttribute("nickname");

		//一、校验交易码,防止重复提交
		boolean validTradeCode = orderService.checkTradeCode(memberId, tradeCode); //true:交易码一致, false:交易码不一致
		if (validTradeCode) {

			//二、封装用户订单
			//1.一个用户的结算信息对象[结算信息对象包含订单详细信息list]
			OmsOrder omsOrder = new OmsOrder();

			//2.创建一个订单详情list,封装一个用户的所有sku订单的详细信息
			List<OmsOrderItem> omsOrderItemList = new ArrayList<>();


			//3.根据用户id获取要购买的商品列表(购物车勾选的)和总价格
			List<OmsCartItem> cartList = cartService.getCartList(memberId);

			//4.封装
			//4.1构造外部订单号
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String outOrderNo = sdf.format(new Date()) + System.currentTimeMillis(); //202004262230451312132145646


			//4.2封装收货人信息
			UmsMemberReceiveAddress receiveAddress = memberService.getReceiveAddressById(memberReceiveAddressId);

			//4.3购物车总价格
			BigDecimal settlementPrice = getSettlementPrice(cartList);

			//4.4确认收货时间
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, 8); //当前日期加8天
			Date date = calendar.getTime();

			//4.5业务字段封装
			omsOrder.setMemberId(memberId)
					.setMemberUsername(nickname)
					.setAutoConfirmDay(7)   //自动确认收货时间
					.setCouponId("2")
					//.setFreightAmount() 运费，支付后，在生成物流信息时
					.setCreateTime(new Date())
					.setDiscountAmount(null)
					.setNote("快点发货")  //备注
					.setOrderSn(outOrderNo)  //外部订单号
					.setPayAmount(settlementPrice)    //应付金额
					.setTotalAmount(settlementPrice)  //订单总金额
					.setOrderType(0)
					.setReceiveTime(date)  //确认收货时间
					.setStatus(0)
					.setSourceType(0)
					.setReceiverName(receiveAddress.getName())
					.setReceiverPhone(receiveAddress.getPhoneNumber())
					.setReceiverPostCode(receiveAddress.getPostCode())
					.setReceiverProvince(receiveAddress.getProvince())
					.setReceiverCity(receiveAddress.getCity())
					.setReceiverRegion(receiveAddress.getRegion())
					.setReceiverDetailAddress(receiveAddress.getDetailAddress());

			//三、封装用户所有的订单信息详情
			//产品名称,传给支付页面显示[显示第一个]
			String productName = "";

			for (OmsCartItem omsCartItem : cartList) {
				//1.循环选中的购物车商品对象
				if ("1".equals(omsCartItem.getIsChecked())) {

					//2.将每一个选中的商品对象转换为一个结算订单信息对象
					OmsOrderItem omsOrderItem = new OmsOrderItem();

					//3.检查价格
					boolean isCorrectPrice = cartService.checkPrice(omsCartItem.getProductSkuId(), omsCartItem.getPrice());
					if (!isCorrectPrice) {
						mav.setViewName("tradeFail");
						mav.addObject("errMsg", omsCartItem.getProductName() + "的商品价格已经变化,请重新加入购物车");
						return mav;
					}

					//4.检查库存,有库存才能提交订单成功[需要调用远程库存系统]

					//5.业务字段封装
					omsOrderItem
							.setProductId(omsCartItem.getProductId())
							.setProductSkuId(omsCartItem.getProductSkuId())
							.setProductQuantity(omsCartItem.getQuantity())
							.setProductPrice(omsCartItem.getPrice())
							.setSp1(omsCartItem.getSp1())
							.setSp2(omsCartItem.getSp2())
							.setSp3(omsCartItem.getSp3())
							.setProductPic(omsCartItem.getProductPic())
							.setProductName(omsCartItem.getProductName())
							.setProductSkuCode(omsCartItem.getProductSkuCode())
							.setProductBrand(omsCartItem.getProductBrand())
							.setProductSn(omsCartItem.getProductSn())  //在仓库的中skuId
							.setProductAttr(omsCartItem.getProductAttr())
							.setOrderSn(outOrderNo)  //外部订单号,用于外部使用,例如支付
							.setRealAmount(omsCartItem.getTotalPrice())
							.setProductCategoryId(omsCartItem.getProductCategoryId()); //三级类别id

					//6.将转换的结算订单信息对象加到订单详情list中
					omsOrderItemList.add(omsOrderItem);
				}
			}
			//设置产品名称
			productName = omsOrderItemList.get(0).getProductName();

			//7.设置该memberId用户的订单结算对象的订单详细信息list]
			omsOrder.setOmsOrderItemList(omsOrderItemList);

			//四、将订单和订单详情写入order表
			//同时要删除购物车相应的商品
			orderService.saveOmsOrder(omsOrder);  //里面包含删除方法

			//五、用户点击支付后重定向到支付页面
			mav.setViewName("redirect:http://payment.jqlmh.com/toPayment");
			mav.addObject("outOrderNo", outOrderNo)
					.addObject("settlementPrice", settlementPrice)
					.addObject("productName", productName);
			return mav;

		} else {
			mav.setViewName("tradeFail");
			mav.addObject("errMsg", "获取商品信息失败,请勿重复提交");
			return mav;
		}
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
			if (omsCartItem.getIsChecked().equals("1")) {
				settlementPrice = settlementPrice.add(omsCartItem.getTotalPrice());
			}
		}

		return settlementPrice;
	}
}
