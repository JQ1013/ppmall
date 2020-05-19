package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PmsProductImage;
import com.jqlmh.ppmall.bean.PmsProductInfo;
import com.jqlmh.ppmall.bean.PmsProductSaleAttr;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-10 15:51
 */
public interface SpuService {

	List<PmsProductInfo> spuList(String catalog3Id);

	void saveSpuInfo(PmsProductInfo pmsProductInfo);

	List<PmsProductImage> spuImageList(String spuId);

	List<PmsProductSaleAttr> spuSaleAttrList(String spuId);

	List<PmsProductSaleAttr> spuSaleAttrListCheckBySku(String spuId, String skuId);
}
