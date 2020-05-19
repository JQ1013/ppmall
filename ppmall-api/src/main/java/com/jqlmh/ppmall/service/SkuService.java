package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PmsSkuInfo;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-11 21:06
 */
public interface SkuService {
	void saveSkuInfo(PmsSkuInfo pmsSkuInfo);

	PmsSkuInfo getSkuByIdFromDB(String skuId);

	List<PmsSkuInfo> getSkuSaleAttrValueListBySpuId(String spuId);

	PmsSkuInfo getSkuById(String skuId, String remoteAddr);


	List<PmsSkuInfo> getPmsSkuInfos();

	PmsSkuInfo getSkuInfoById(String productSkuId);
}
