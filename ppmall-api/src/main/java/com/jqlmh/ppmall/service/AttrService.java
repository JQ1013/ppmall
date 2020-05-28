package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PmsBaseAttrInfo;
import com.jqlmh.ppmall.bean.PmsBaseAttrValue;
import com.jqlmh.ppmall.bean.PmsBaseSaleAttr;

import java.util.List;
import java.util.Set;

/**
 * 平台属性接口
 *
 * @author LMH
 * @create 2020-04-09 20:36
 */
public interface AttrService {

	/**
	 * 根据三级分类的id获得对应的所有平台属性
	 *
	 * @param catalog3Id 三级分类id
	 * @return 三级分类平台属性列表
	 */
	List<PmsBaseAttrInfo> attrInfoList(String catalog3Id);


	/**
	 * 根据传入的属性id获取这个属性的所有值
	 *
	 * @param attrId 属性id
	 * @return 属性所有值
	 */
	List<PmsBaseAttrValue> getAttrValueList(String attrId);

	/**
	 * 根据前端传过来的值保存属性
	 *
	 * @param pmsBaseAttrInfo 平台属性对象
	 * @return String
	 */
	String saveAttrInfo(PmsBaseAttrInfo pmsBaseAttrInfo);

	/**
	 * 获取所有的销售属性名称(平台提供的)
	 *
	 * @return List<PmsBaseSaleAttr>
	 */
	List<PmsBaseSaleAttr> baseSaleAttrList();

	/**
	 * 根据valueId获取所有的平台属性信息(用于显示搜索后的平台属性显示)
	 *
	 * @param valueIdSet 所有的valueId
	 * @return List<PmsBaseAttrInfo>
	 */
	List<PmsBaseAttrInfo> getAttrValueListByAttrId(Set<String> valueIdSet);

	/**
	 * 根据attrId获得一个PmsBaseAttrValue对象
	 *
	 * @param delValueId 要去掉的ValueId
	 * @return PmsBaseAttrValue
	 */
	PmsBaseAttrValue getPmsBaseAttrValue(String delValueId);

	/**
	 * 根据主键Id获取一个PmsBaseAttrInfo对象
	 *
	 * @param attrId attrId
	 * @return PmsBaseAttrInfo
	 */
	PmsBaseAttrInfo getPmsBaseAttrInfo(String attrId);
}
