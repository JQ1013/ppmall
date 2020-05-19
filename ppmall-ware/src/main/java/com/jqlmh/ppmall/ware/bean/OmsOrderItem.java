package com.jqlmh.ppmall.ware.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.math.BigDecimal;

@Setter
@Getter
@ToString
@Accessors(chain = true)
public class OmsOrderItem implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private String orderId;
	private String orderSn;
	private String productId;
	private String productPic;
	private String productName;
	private String productBrand;
	private String productSn;
	private BigDecimal productPrice;
	private Integer productQuantity;
	private String productSkuId;
	private String productSkuCode;
	private String productCategoryId;
	private String sp1;
	private String sp2;
	private String sp3;
	private String promotionName;
	private BigDecimal promotionAmount;
	private BigDecimal couponAmount;
	private BigDecimal integrationAmount;
	private BigDecimal realAmount;
	private Integer giftIntegration;
	private Integer giftGrowth;
	private String productAttr;


}
