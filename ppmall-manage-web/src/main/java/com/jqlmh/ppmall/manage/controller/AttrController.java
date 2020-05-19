package com.jqlmh.ppmall.manage.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.bean.PmsBaseAttrInfo;
import com.jqlmh.ppmall.bean.PmsBaseAttrValue;
import com.jqlmh.ppmall.bean.PmsBaseSaleAttr;
import com.jqlmh.ppmall.service.AttrService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-09 20:32
 */
@CrossOrigin
@Controller
public class AttrController {

	@Reference
	private AttrService attrService;

	/**
	 * 处理显示属性的请求
	 * @param catalog3Id
	 * @return
	 */
	@GetMapping("/attrInfoList")
	@ResponseBody
	public List<PmsBaseAttrInfo> attrInfoList(@RequestParam("catalog3Id") String catalog3Id) {
		return attrService.attrInfoList(catalog3Id);
	}


	/**
	 * 处理显示属性值的请求
	 * @param attrId
	 * @return
	 */
	@PostMapping("/getAttrValueList")
	@ResponseBody
	public List<PmsBaseAttrValue> getAttrValueList(@RequestParam("attrId") String attrId) {
		return attrService.getAttrValueList(attrId);
	}


	/**
	 * 处理保存属性值的请求
	 * @param pmsBaseAttrInfo:前端传来的属性对象+属性值
	 */
	@RequestMapping("/saveAttrInfo")
	@ResponseBody
	public String saveAttrInfo(@RequestBody PmsBaseAttrInfo pmsBaseAttrInfo) {
		System.out.println(pmsBaseAttrInfo);
		String info = attrService.saveAttrInfo(pmsBaseAttrInfo);
		System.out.println(info);
		return info;
	}

	/**
	 * 处理获取销售属性字典(名称)的请求
	 * @return
	 */
	@PostMapping("/baseSaleAttrList")
	@ResponseBody
	public List<PmsBaseSaleAttr> baseSaleAttrList() {
		return attrService.baseSaleAttrList();
	}
}
