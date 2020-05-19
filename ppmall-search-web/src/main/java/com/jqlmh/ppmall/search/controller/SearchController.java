package com.jqlmh.ppmall.search.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.annotation.LoginRequired;
import com.jqlmh.ppmall.bean.*;
import com.jqlmh.ppmall.service.AttrService;
import com.jqlmh.ppmall.service.SearchService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

/**
 * @author LMH
 * @create 2020-04-21 17:14
 */

@Controller
@CrossOrigin
public class SearchController {


	@Reference
	private SearchService searchService;

	@Reference
	private AttrService attrService;

	/**
	 * 处理来到首页的请求
	 * @return
	 */
	@LoginRequired()   //需要验证登录
	@RequestMapping(value = {"/index", "/"})
	public String index() {
		return "index";
	}


	/**
	 * 处理显示所有列表的请求
	 *
	 * @param pmsSearchParam :前台页面点击后传过来的封装的参数
	 * @param model          model对象
	 * @return list.html
	 */
	@RequestMapping("/list.html")
	public String list(PmsSearchParam pmsSearchParam, Model model) {
		//三级分类id,搜索关键字、平台属性值

		//1.调用搜索服务,返回搜索结果
		List<PmsSearchSkuInfo> pmsSearchSkuInfos = searchService.list(pmsSearchParam);
		model.addAttribute("skuLsInfoList", pmsSearchSkuInfos);

		//2.根据搜索词查询所有的平台属性
		//pmsSearchSkuInfos包含了List<PmsSkuAttrValue> skuAttrValueList,里面有所有的valueId
		//2.1.用一个set集合用于存放所有的去重的valueId
		Set<String> valueIdSet = new HashSet<>();

		for (PmsSearchSkuInfo pmsSearchSkuInfo : pmsSearchSkuInfos) {
			List<PmsSkuAttrValue> skuAttrValueList = pmsSearchSkuInfo.getSkuAttrValueList();
			for (PmsSkuAttrValue pmsSkuAttrValue : skuAttrValueList) {
				String valueId = pmsSkuAttrValue.getValueId();
				valueIdSet.add(valueId);
			}
		}

		//2.2.调用属性服务attrService根据属性值id将平台属性的集合列表查询出来
		List<PmsBaseAttrInfo> pmsBaseAttrInfoList = attrService.getAttrValueListByAttrId(valueIdSet);

		//4.删除平台属性,在删除的同事也需要做面包屑功能
		// 对平台属性进一步处理,去掉当前检索条件中valueId所在的属性组,避免选择了这一类属性的值后还可以选择这一类属性
		String[] delValueIds = pmsSearchParam.getValueId();
		if (delValueIds != null) {
			//用于封装面包屑的list
			List<PmsSearchCrumb> pmsSearchCrumbs = new ArrayList<>();

			//使用迭代器删除
			for (String delValueId : delValueIds) {
				//封装一个面包屑的参数
				PmsSearchCrumb pmsSearchCrumb = new PmsSearchCrumb();

				//通过点击的valueId,来获得对应的面包屑的属性名字:attrName
				PmsBaseAttrValue AttrValue=attrService.getPmsBaseAttrValue(delValueId);
				PmsBaseAttrInfo AttrInfo=attrService.getPmsBaseAttrInfo(AttrValue.getAttrId());
				pmsSearchCrumb.setAttrName(AttrInfo.getAttrName());

				pmsSearchCrumb.setValueId(delValueId);
				pmsSearchCrumb.setUrlParam(getUrlParamForCrumb(pmsSearchParam, delValueId));

				Iterator<PmsBaseAttrInfo> iterator = pmsBaseAttrInfoList.iterator();
				while (iterator.hasNext()) {
					PmsBaseAttrInfo pmsBaseAttrInfo = iterator.next();

					List<PmsBaseAttrValue> attrValueList = pmsBaseAttrInfo.getAttrValueList();
					for (PmsBaseAttrValue pmsBaseAttrValue : attrValueList) {
						String valueId = pmsBaseAttrValue.getId();
						//当查询出来(mysql查的)的所有平台属性中的valueId等于你点击传过来的valueId值,就执行删除本类平台属性
						if (delValueId.equals(valueId)) {
							//在删除平台属性之前先做面包屑参数赋值
							pmsSearchCrumb.setValueName(pmsBaseAttrValue.getValueName());

							//删除本类平台属性:pmsBaseAttrInfoList这个里面的
							iterator.remove();
						}
					}
				}
				pmsSearchCrumbs.add(pmsSearchCrumb);
			}
			model.addAttribute("attrValueSelectedList", pmsSearchCrumbs);
		}
		model.addAttribute("attrList", pmsBaseAttrInfoList);

		//5.平台属性列表的url处理
		String urlParam = getUrlParam(pmsSearchParam);
		model.addAttribute("urlParam", urlParam);

		//6.搜索关键字显示
		String keyword = pmsSearchParam.getKeyword();
		if (StringUtils.isNotBlank(keyword)) {
			model.addAttribute("keyword", keyword);
		}

		return "list";
	}

	/**
	 * 获得点击面包屑的×时候返回的页面地址:当前地址-面包屑的平台属性的值--->的新地址
	 *
	 * @param pmsSearchParam
	 * @param delValueId
	 * @return
	 */
	private String getUrlParamForCrumb(PmsSearchParam pmsSearchParam, String delValueId) {
		String catalog3Id = pmsSearchParam.getCatalog3Id();
		String keyword = pmsSearchParam.getKeyword();
		String[] valueIds = pmsSearchParam.getValueId();

		String urlParam = "";
		if (StringUtils.isNotBlank(catalog3Id)) {
			urlParam = StringUtils.isNotBlank(urlParam) ? urlParam + "&catalog3Id=" + catalog3Id : urlParam + "catalog3Id=" + catalog3Id;
		}

		if (StringUtils.isNotBlank(keyword)) {
			urlParam = StringUtils.isNotBlank(urlParam) ? urlParam + "&keyword=" + keyword : urlParam + "keyword=" + keyword;
		}


		if (valueIds != null) {
			for (String valueId : valueIds) {
				if (!valueId.equals(delValueId)) {
					urlParam = urlParam + "&valueId=" + valueId;
				}
			}
		}
		return urlParam;
	}


	/**
	 * 返回平台属性列表的url字符串
	 *
	 * @param pmsSearchParam
	 * @return
	 */
	private String getUrlParam(PmsSearchParam pmsSearchParam) {
		String catalog3Id = pmsSearchParam.getCatalog3Id();
		String keyword = pmsSearchParam.getKeyword();
		String[] valueIds = pmsSearchParam.getValueId();

		String urlParam = "";
		if (StringUtils.isNotBlank(catalog3Id)) {
			urlParam = StringUtils.isNotBlank(urlParam) ? urlParam + "&catalog3Id=" + catalog3Id : urlParam + "catalog3Id=" + catalog3Id;
		}

		if (StringUtils.isNotBlank(keyword)) {
			urlParam = StringUtils.isNotBlank(urlParam) ? urlParam + "&keyword=" + keyword : urlParam + "keyword=" + keyword;
		}


		if (valueIds != null) {
			for (String valueId : valueIds) {
				urlParam = urlParam + "&valueId=" + valueId;
			}
		}
		return urlParam;
	}

}
