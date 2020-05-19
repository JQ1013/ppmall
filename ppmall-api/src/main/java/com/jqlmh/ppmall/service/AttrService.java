package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PmsBaseAttrInfo;
import com.jqlmh.ppmall.bean.PmsBaseAttrValue;
import com.jqlmh.ppmall.bean.PmsBaseSaleAttr;

import java.util.List;
import java.util.Set;

/**
 * @author LMH
 * @create 2020-04-09 20:36
 */
public interface AttrService {
	List<PmsBaseAttrInfo> attrInfoList(String catalog3Id);

	List<PmsBaseAttrValue> getAttrValueList(String attrId);

	String saveAttrInfo(PmsBaseAttrInfo pmsBaseAttrInfo);

	List<PmsBaseSaleAttr> baseSaleAttrList();

	List<PmsBaseAttrInfo> getAttrValueListByAttrId(Set<String> valueIdSet);

	PmsBaseAttrValue getPmsBaseAttrValue(String delValueId);

	PmsBaseAttrInfo getPmsBaseAttrInfo(String attrId);
}
