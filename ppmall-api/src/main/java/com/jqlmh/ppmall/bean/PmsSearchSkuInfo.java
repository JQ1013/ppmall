package com.jqlmh.ppmall.bean;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * Sku信息实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsSearchSkuInfo implements Serializable {

	@Id
	private Long id;

	private String spuId;

	private BigDecimal price;

	private String skuName;

	private String skuDesc;

	private String catalog3Id;

	private String skuDefaultImg;

	private Double hotScore;

	private List<PmsSkuAttrValue> skuAttrValueList;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSpuId() {
		return spuId;
	}

	public void setSpuId(String spuId) {
		this.spuId = spuId;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getSkuName() {
		return skuName;
	}

	public void setSkuName(String skuName) {
		this.skuName = skuName;
	}

	public String getSkuDesc() {
		return skuDesc;
	}

	public void setSkuDesc(String skuDesc) {
		this.skuDesc = skuDesc;
	}

	public String getCatalog3Id() {
		return catalog3Id;
	}

	public void setCatalog3Id(String catalog3Id) {
		this.catalog3Id = catalog3Id;
	}

	public String getSkuDefaultImg() {
		return skuDefaultImg;
	}

	public void setSkuDefaultImg(String skuDefaultImg) {
		this.skuDefaultImg = skuDefaultImg;
	}

	public Double getHotScore() {
		return hotScore;
	}

	public void setHotScore(Double hotScore) {
		this.hotScore = hotScore;
	}

	public List<PmsSkuAttrValue> getSkuAttrValueList() {
		return skuAttrValueList;
	}

	public void setSkuAttrValueList(List<PmsSkuAttrValue> skuAttrValueList) {
		this.skuAttrValueList = skuAttrValueList;
	}

	@Override
	public String toString() {
		return "PmsSearchSkuInfo{" +
				"id='" + id + '\'' +
				", spuId='" + spuId + '\'' +
				", price=" + price +
				", skuName='" + skuName + '\'' +
				", skuDesc='" + skuDesc + '\'' +
				", catalog3Id='" + catalog3Id + '\'' +
				", skuDefaultImg='" + skuDefaultImg + '\'' +
				", hotScore=" + hotScore +
				", skuAttrValueList=" + skuAttrValueList +
				'}';
	}
}
