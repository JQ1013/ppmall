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


@Getter
@Setter
@ToString
@Accessors(chain = true) //setter的链式编程
public class OmsCartItem implements Serializable{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;
    private String productId;
    private String productSkuId;
    private String memberId;
    private Integer quantity;
    //sku价格
    private BigDecimal price;
    private String sp1;
    private String sp2;
    private String sp3;
    private String productPic;
    private String productName;
    private String productSubTitle;
    private String productSkuCode;
    private String memberNickname;
    private Date createDate;
    private Date modifyDate;
    private Integer deleteStatus;
    private String productCategoryId;
    private String productBrand;
    private String productSn;
    private String productAttr;
    private String isChecked;

    @Transient
    private BigDecimal totalPrice; //总价格


}
