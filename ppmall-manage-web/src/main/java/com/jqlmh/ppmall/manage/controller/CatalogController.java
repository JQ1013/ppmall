package com.jqlmh.ppmall.manage.controller;


import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.bean.PmsBaseCatalog1;
import com.jqlmh.ppmall.bean.PmsBaseCatalog2;
import com.jqlmh.ppmall.bean.PmsBaseCatalog3;
import com.jqlmh.ppmall.service.CatalogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-09 17:22
 */
@Controller
@CrossOrigin
public class CatalogController {


	@Reference
	private CatalogService catalogService;

	/**
	 * 处理获取所有一级分类请求
	 * @return 一级分类列表
	 */
	@PostMapping("/getCatalog1")
	@ResponseBody
	public List<PmsBaseCatalog1> getCatalog1(){
		return catalogService.getCatalog1();
	}


	/**
	 * 处理获取对应一级分类id的二级分类
	 * @param catalog1Id
	 * @return
	 */
	@PostMapping("/getCatalog2")
	@ResponseBody
	public List<PmsBaseCatalog2> getCatalog2(@RequestParam("catalog1Id") String catalog1Id){
		return catalogService.getCatalog2(catalog1Id);
	}

	@PostMapping("/getCatalog3")
	@ResponseBody
	public List<PmsBaseCatalog3> getCatalog3(@RequestParam("catalog2Id") String catalog2Id){
		return catalogService.getCatalog3(catalog2Id);
	}
}
