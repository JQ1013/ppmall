package com.jqlmh.ppmall.bean;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * @param
 * @return
 */
public class PmsSkuInfo implements Serializable {

	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	@Column
	private String id;

	@Column
	private String spuId;

	@Column
	private BigDecimal price;

	@Column
	private String skuName;

	@Column
	private BigDecimal weight;

	@Column
	private String skuDesc;

	@Column
	private String catalog3Id;

	@Column
	private String skuDefaultImg;

	@Transient
	private List<PmsSkuImage> skuImageList;

	@Transient
	private List<PmsSkuAttrValue> skuAttrValueList;

	@Transient
	private List<PmsSkuSaleAttrValue> skuSaleAttrValueList;


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
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

	public String getSpuId() {
		return spuId;
	}

	public void setSpuId(String spuId) {
		this.spuId = spuId;
	}

	public List<PmsSkuImage> getSkuImageList() {
		return skuImageList;
	}

	public void setSkuImageList(List<PmsSkuImage> skuImageList) {
		this.skuImageList = skuImageList;
	}

	public List<PmsSkuAttrValue> getSkuAttrValueList() {
		return skuAttrValueList;
	}

	public void setSkuAttrValueList(List<PmsSkuAttrValue> skuAttrValueList) {
		this.skuAttrValueList = skuAttrValueList;
	}

	public List<PmsSkuSaleAttrValue> getSkuSaleAttrValueList() {
		return skuSaleAttrValueList;
	}

	public void setSkuSaleAttrValueList(List<PmsSkuSaleAttrValue> skuSaleAttrValueList) {
		this.skuSaleAttrValueList = skuSaleAttrValueList;
	}

	@Override
	public String toString() {
		return "PmsSkuInfo{" +
				"id='" + id + '\'' +
				", spuId='" + spuId + '\'' +
				", price=" + price +
				", skuName='" + skuName + '\'' +
				", weight=" + weight +
				", skuDesc='" + skuDesc + '\'' +
				", catalog3Id='" + catalog3Id + '\'' +
				", skuDefaultImg='" + skuDefaultImg + '\'' +
				", skuImageList=" + skuImageList +
				", skuAttrValueList=" + skuAttrValueList +
				", skuSaleAttrValueList=" + skuSaleAttrValueList +
				'}';
	}
}
