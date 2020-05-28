package com.jqlmh.ppmall.bean;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Sku销售属性实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsSkuSaleAttrValue implements Serializable {

	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String skuId;

	@Column
	private String saleAttrId;

	@Column
	private String saleAttrValueId;

	@Column
	private String saleAttrName;

	@Column
	private String saleAttrValueName;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSkuId() {
		return skuId;
	}

	public void setSkuId(String skuId) {
		this.skuId = skuId;
	}

	public String getSaleAttrId() {
		return saleAttrId;
	}

	public void setSaleAttrId(String saleAttrId) {
		this.saleAttrId = saleAttrId;
	}

	public String getSaleAttrValueId() {
		return saleAttrValueId;
	}

	public void setSaleAttrValueId(String saleAttrValueId) {
		this.saleAttrValueId = saleAttrValueId;
	}

	public String getSaleAttrName() {
		return saleAttrName;
	}

	public void setSaleAttrName(String saleAttrName) {
		this.saleAttrName = saleAttrName;
	}

	public String getSaleAttrValueName() {
		return saleAttrValueName;
	}

	public void setSaleAttrValueName(String saleAttrValueName) {
		this.saleAttrValueName = saleAttrValueName;
	}

	@Override
	public String toString() {
		return "PmsSkuSaleAttrValue{" +
				"id='" + id + '\'' +
				", skuId='" + skuId + '\'' +
				", saleAttrId='" + saleAttrId + '\'' +
				", saleAttrValueId='" + saleAttrValueId + '\'' +
				", saleAttrName='" + saleAttrName + '\'' +
				", saleAttrValueName='" + saleAttrValueName + '\'' +
				'}';
	}
}
