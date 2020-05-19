package com.jqlmh.ppmall.item.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.PmsProductSaleAttr;
import com.jqlmh.ppmall.bean.PmsSkuInfo;
import com.jqlmh.ppmall.bean.PmsSkuSaleAttrValue;
import com.jqlmh.ppmall.service.SkuService;
import com.jqlmh.ppmall.service.SpuService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

/**
 * @author LMH
 * @create 2020-04-12 20:00
 */

@Controller
public class ItemController {

	@Reference
	private SkuService skuService;

	@Reference
	private SpuService spuService;
	/**
	 * 根据skuId查询sku信息
	 * @param skuId:skuId
	 * @param model sku信息集合
	 * @return item.html和信息
	 */
	@RequestMapping("/{skuId}.html")
	public String item(@PathVariable("skuId") String skuId, Model model, HttpServletRequest request){

		//1.查询sku信息+图片信息
		//PmsSkuInfo pmsSkuInfo=skuService.getSkuByIdFromDB(skuId);

		//使用redis
		String ip = request.getRemoteAddr();
		// request.getHeader("");// nginx负载均衡
		PmsSkuInfo pmsSkuInfo = skuService.getSkuById(skuId,ip);
		//返回页面
		model.addAttribute("skuInfo",pmsSkuInfo);

		//2.查询sku所有的销售属性信息
		/*
			该skuId对应下的--spuId(pms_sku_info)---根据spuId获取该spu的所有销售属性saleAttrName(pms_product_sale_attr)
			---在获取所有的销售属性值sale_attr_value_name(pms_product_sale_attr_value)
		*/
		List<PmsProductSaleAttr> spuSaleAttrList = spuService.spuSaleAttrListCheckBySku(pmsSkuInfo.getSpuId(),skuId);

		model.addAttribute("spuSaleAttrListCheckBySku",spuSaleAttrList);

		//3.根据当前SKU对应的spu,查询其他sku的集合的hash表
		List<PmsSkuInfo> pmsSkuInfos=skuService.getSkuSaleAttrValueListBySpuId(pmsSkuInfo.getSpuId());
		HashMap<String, String> skuSaleAttrValueMap = new HashMap<>();

		for (PmsSkuInfo skuInfo : pmsSkuInfos) {
			StringBuilder key= new StringBuilder();
			String value=skuInfo.getId();

			List<PmsSkuSaleAttrValue> skuSaleAttrValueList = skuInfo.getSkuSaleAttrValueList();
			for (int i=0;i<skuSaleAttrValueList.size();i++) {
				if(i==skuSaleAttrValueList.size()-1){
					key.append(skuSaleAttrValueList.get(i).getSaleAttrValueId());
				}else {
					key.append(skuSaleAttrValueList.get(i).getSaleAttrValueId()).append("|");  //"260|263"
				}
			}

			skuSaleAttrValueMap.put(key.toString(),value);
		}

		// 将sku的销售属性hash表放到页面
		String valuesSkuJson = JSON.toJSONString(skuSaleAttrValueMap);
		model.addAttribute("valuesSkuJson",valuesSkuJson);

		return "item";
	}


}
