package com.jqlmh.ppmall.manage.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.jqlmh.ppmall.bean.PmsBaseCatalog1;
import com.jqlmh.ppmall.bean.PmsBaseCatalog2;
import com.jqlmh.ppmall.bean.PmsBaseCatalog3;
import com.jqlmh.ppmall.manage.mapper.PmsBaseCatalog1Mapper;
import com.jqlmh.ppmall.manage.mapper.PmsBaseCatalog2Mapper;
import com.jqlmh.ppmall.manage.mapper.PmsBaseCatalog3Mapper;
import com.jqlmh.ppmall.service.CatalogService;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-09 17:57
 */
@Service
public class CatalogServiceImpl implements CatalogService {

	@Autowired
	private PmsBaseCatalog1Mapper pmsBaseCatalog1Mapper;

	@Autowired
	private PmsBaseCatalog2Mapper pmsBaseCatalog2Mapper;

	@Autowired
	private PmsBaseCatalog3Mapper pmsBaseCatalog3Mapper;


	/**
	 * 获取所有的一级分类列表
	 * @return 一级分类列表
	 */
	@Override
	public List<PmsBaseCatalog1> getCatalog1() {
		return pmsBaseCatalog1Mapper.selectAll();
	}

	/**
	 * 获取根据一级分类的id获取所有的二级分类列表
	 * @param catalog1Id 一级分类id
	 * @return 二级分类对应列表
	 */
	@Override
	public List<PmsBaseCatalog2> getCatalog2(String catalog1Id) {
		Example example = new Example(PmsBaseCatalog2.class);
		example.createCriteria().andEqualTo("catalog1Id",catalog1Id);
		return pmsBaseCatalog2Mapper.selectByExample(example);
	}

	/**
	 * 获取根据二级分类的id获取所有的三级分类列表
	 * @param catalog2Id 二级分类id
	 * @return 三级分类对应列表
	 */
	@Override
	public List<PmsBaseCatalog3> getCatalog3(String catalog2Id) {
		Example example = new Example(PmsBaseCatalog3.class);
		example.createCriteria().andEqualTo("catalog2Id",catalog2Id);
		return pmsBaseCatalog3Mapper.selectByExample(example);
	}
}
