package com.jqlmh.ppmall.manage.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.jqlmh.ppmall.bean.PmsBaseAttrInfo;
import com.jqlmh.ppmall.bean.PmsBaseAttrValue;
import com.jqlmh.ppmall.bean.PmsBaseSaleAttr;
import com.jqlmh.ppmall.manage.mapper.PmsBaseAttrInfoMapper;
import com.jqlmh.ppmall.manage.mapper.PmsBaseAttrValueMapper;
import com.jqlmh.ppmall.manage.mapper.PmsBaseSaleAttrMapper;
import com.jqlmh.ppmall.service.AttrService;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * 平台属性service接口
 *
 * @author LMH
 * @create 2020-04-09 20:36
 */

@Service
public class AttrServiceImpl implements AttrService {

	@Autowired
	private PmsBaseAttrInfoMapper pmsBaseAttrInfoMapper;

	@Autowired
	private PmsBaseAttrValueMapper pmsBaseAttrValueMapper;

	@Autowired
	private PmsBaseSaleAttrMapper pmsBaseSaleAttrMapper;


	/**
	 * 根据三级分类的id获得对应的所有平台属性
	 *
	 * @param catalog3Id 三级分类id
	 * @return 三级分类平台属性列表
	 */
	@Override
	public List<PmsBaseAttrInfo> attrInfoList(String catalog3Id) {
		Example example = new Example(PmsBaseAttrInfo.class);
		example.createCriteria().andEqualTo("catalog3Id", catalog3Id);
		List<PmsBaseAttrInfo> pmsBaseAttrInfos = pmsBaseAttrInfoMapper.selectByExample(example);

		for (PmsBaseAttrInfo pmsBaseAttrInfo : pmsBaseAttrInfos) {
			Example example1 = new Example(PmsBaseAttrValue.class);
			example1.createCriteria().andEqualTo("attrId", pmsBaseAttrInfo.getId());
			List<PmsBaseAttrValue> attrValueList = pmsBaseAttrValueMapper.selectByExample(example1);
			pmsBaseAttrInfo.setAttrValueList(attrValueList);
		}
		return pmsBaseAttrInfos;
	}

	/**
	 * 根据传入的属性id获取这个属性的所有值
	 *
	 * @param attrId 属性id
	 * @return 属性所有值
	 */
	@Override
	public List<PmsBaseAttrValue> getAttrValueList(String attrId) {
		Example example = new Example(PmsBaseAttrValue.class);
		example.createCriteria().andEqualTo("attrId", attrId);
		return pmsBaseAttrValueMapper.selectByExample(example);

	}

	/**
	 * 根据前端传过来的值保存属性
	 *
	 * @param pmsBaseAttrInfo 平台属性对象
	 * @return String
	 */
	@Override
	public String saveAttrInfo(PmsBaseAttrInfo pmsBaseAttrInfo) {

		//如果没有属性id,新增
		if (pmsBaseAttrInfo.getId() == null) {

			//根据名字判断该属性是否已有
			List<PmsBaseAttrInfo> pmsBaseAttrInfos = pmsBaseAttrInfoMapper.selectAll();
			//创建一个list用于装数据库的所有属性名字
			List<String> attrNameList = new ArrayList<>();

			for (PmsBaseAttrInfo attrInfo : pmsBaseAttrInfos) {
				attrNameList.add(attrInfo.getAttrName());
			}
			//判断新增的属性名字是否存在
			if (attrNameList.contains(pmsBaseAttrInfo.getAttrName())) {
				//有返回错误信息
				return "已经有该属性了,不要重复添加!!!!";
			} else {
				//1.没有,保存属性
				pmsBaseAttrInfoMapper.insertSelective(pmsBaseAttrInfo);

				//保存属性值:因为这里的属性都是新增的属性值,所以不需要执行删除所有操作
				List<PmsBaseAttrValue> list = pmsBaseAttrInfo.getAttrValueList();
				for (PmsBaseAttrValue pmsBaseAttrValue : list) {
					pmsBaseAttrValue.setAttrId(pmsBaseAttrInfo.getId());
					pmsBaseAttrValueMapper.insertSelective(pmsBaseAttrValue);
				}
				return "添加属性和属性值成功";
			}

		} else {
			//有id,执行修改属性操作
			//1.修改属性
			pmsBaseAttrInfoMapper.updateByPrimaryKeySelective(pmsBaseAttrInfo);

			//前端设计的逻辑是只能添加和删除属性值:
			//删除是前台的删除,本质没有数据库删除,点击保存的时候,也就是发送到后台所有属性值再插入一遍,所以就相当于根据属性id插入所有属性值
			//如果要去执行插入操作的话,需要判断有些属性值没有修改,这一部分的值不需要再次插入,也不能插入,会报主键重复异常;所以简单的方法就是先删除所有的属性值,再重新插入

			//2.保存属性值:先删除所有属性值,再执行插入操作
			//删除所有属性值
			Example example = new Example(PmsBaseAttrValue.class);
			example.createCriteria().andEqualTo("attrId", pmsBaseAttrInfo.getId());
			pmsBaseAttrValueMapper.deleteByExample(example);

			//执行插入新的属性值
			List<PmsBaseAttrValue> list = pmsBaseAttrInfo.getAttrValueList();
			for (PmsBaseAttrValue pmsBaseAttrValue : list) {
				pmsBaseAttrValue.setAttrId(pmsBaseAttrInfo.getId());
				pmsBaseAttrValueMapper.insertSelective(pmsBaseAttrValue);
			}
		}
		return "修改属性和值成功";
	}


	/**
	 * 获取所有的销售属性名称(平台提供的)
	 *
	 * @return List<PmsBaseSaleAttr>
	 */
	@Override
	public List<PmsBaseSaleAttr> baseSaleAttrList() {
		return pmsBaseSaleAttrMapper.selectAll();
	}


	/**
	 * 根据valueId获取所有的平台属性信息(用于显示搜索后的平台属性显示)
	 *
	 * @param valueIdSet 所有的valueId
	 * @return List<PmsBaseAttrInfo>
	 */
	@Override
	public List<PmsBaseAttrInfo> getAttrValueListByAttrId(Set<String> valueIdSet) {
		//可以使用StringUtils的工具类将set转换为字符串,然后使用字符串替换sql参数,这里使用的是动态sql拼接
		return pmsBaseAttrInfoMapper.selectAttrValueListByAttrId(valueIdSet);
	}

	/**
	 * 根据attrId获得一个PmsBaseAttrValue对象
	 *
	 * @param delValueId 要去掉的ValueId
	 * @return PmsBaseAttrValue
	 */
	@Override
	public PmsBaseAttrValue getPmsBaseAttrValue(String delValueId) {
		return pmsBaseAttrValueMapper.selectByPrimaryKey(delValueId);
	}

	/**
	 * 根据主键Id获取一个PmsBaseAttrInfo对象
	 *
	 * @param attrId attrId
	 * @return PmsBaseAttrInfo
	 */
	@Override
	public PmsBaseAttrInfo getPmsBaseAttrInfo(String attrId) {
		return pmsBaseAttrInfoMapper.selectByPrimaryKey(attrId);
	}


}
