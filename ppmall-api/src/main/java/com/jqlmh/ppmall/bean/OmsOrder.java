package com.jqlmh.ppmall.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单详细信息实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
@Setter
@Getter
@ToString
@Accessors(chain = true)
public class OmsOrder implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private String memberId;
	private String couponId;
	private String orderSn;
	private Date createTime;
	private String memberUsername;
	private BigDecimal totalAmount;
	private BigDecimal payAmount;
	private BigDecimal freightAmount;
	private BigDecimal promotionAmount;
	private BigDecimal integrationAmount;
	private BigDecimal couponAmount;
	private BigDecimal discountAmount;
	private Integer payType;
	private Integer sourceType;
	private Integer status;
	private Integer orderType;
	private String deliveryCompany;
	private String deliverySn;
	private Integer autoConfirmDay;
	private Integer integration;
	private Integer growth;
	private String promotionInfo;
	private Integer billType;
	private String billHeader;
	private String billContent;
	private String billReceiverPhone;
	private String billReceiverEmail;
	private String receiverName;
	private String receiverPhone;
	private String receiverPostCode;
	private String receiverProvince;
	private String receiverCity;
	private String receiverRegion;
	private String receiverDetailAddress;
	private String note;
	private Integer confirmStatus;
	private Integer deleteStatus;
	private Integer useIntegration;
	private Date paymentTime;
	private Date deliveryTime;
	private Date receiveTime;
	private Date commentTime;
	private Date modifyTime;

	@Transient
	private List<OmsOrderItem> omsOrderItemList;

}
