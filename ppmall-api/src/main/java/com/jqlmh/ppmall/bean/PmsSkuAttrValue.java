package com.jqlmh.ppmall.bean;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Sku属性实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsSkuAttrValue implements Serializable {

	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String attrId;

	@Column
	private String valueId;

	@Column
	private String skuId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAttrId() {
		return attrId;
	}

	public void setAttrId(String attrId) {
		this.attrId = attrId;
	}

	public String getValueId() {
		return valueId;
	}

	public void setValueId(String valueId) {
		this.valueId = valueId;
	}

	public String getSkuId() {
		return skuId;
	}

	public void setSkuId(String skuId) {
		this.skuId = skuId;
	}

	@Override
	public String toString() {
		return "PmsSkuAttrValue{" +
				"id='" + id + '\'' +
				", attrId='" + attrId + '\'' +
				", valueId='" + valueId + '\'' +
				", skuId='" + skuId + '\'' +
				'}';
	}
}
