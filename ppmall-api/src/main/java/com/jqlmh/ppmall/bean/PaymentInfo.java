package com.jqlmh.ppmall.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @param
 * @return
 */

@Setter
@Getter
@ToString
@Accessors(chain = true)
public class PaymentInfo implements Serializable {

	@Column
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String outTradeNo;

	@Column
	private String orderId;

	@Column
	private String alipayTradeNo;

	@Column
	private BigDecimal totalAmount;

	@Column
	private String Subject;

	@Column
	private String paymentStatus;

	@Column
	private Date createTime;

	@Column
	private Date callbackTime;

	@Column
	private String callbackContent;

}
