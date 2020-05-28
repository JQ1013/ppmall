package com.jqlmh.ppmall.bean;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Spu信息实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsProductInfo implements Serializable {

	@Column
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String productName;

	@Column
	private String description;

	@Column
	private String catalog3Id;

	@Transient
	private List<PmsProductSaleAttr> spuSaleAttrList;
	@Transient
	private List<PmsProductImage> spuImageList;


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCatalog3Id() {
		return catalog3Id;
	}

	public void setCatalog3Id(String catalog3Id) {
		this.catalog3Id = catalog3Id;
	}

	public List<PmsProductSaleAttr> getSpuSaleAttrList() {
		return spuSaleAttrList;
	}

	public void setSpuSaleAttrList(List<PmsProductSaleAttr> spuSaleAttrList) {
		this.spuSaleAttrList = spuSaleAttrList;
	}

	public List<PmsProductImage> getSpuImageList() {
		return spuImageList;
	}

	public void setSpuImageList(List<PmsProductImage> spuImageList) {
		this.spuImageList = spuImageList;
	}

	@Override
	public String toString() {
		return "PmsProductInfo{" +
				"id='" + id + '\'' +
				", productName='" + productName + '\'' +
				", description='" + description + '\'' +
				", catalog3Id='" + catalog3Id + '\'' +
				", spuSaleAttrList=" + spuSaleAttrList +
				", spuImageList=" + spuImageList +
				'}';
	}
}


