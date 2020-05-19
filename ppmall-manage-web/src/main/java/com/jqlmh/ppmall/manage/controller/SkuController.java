package com.jqlmh.ppmall.manage.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.bean.PmsSkuImage;
import com.jqlmh.ppmall.bean.PmsSkuInfo;
import com.jqlmh.ppmall.service.SkuService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-11 20:15
 */

@RestController
@CrossOrigin
public class SkuController {

	@Reference
	private SkuService skuService;

	/**
	 * 处理保存sku信息的方法
	 * @param pmsSkuInfo:sku信息
	 */
	@RequestMapping("/saveSkuInfo")
	public void saveSkuInfo(@RequestBody PmsSkuInfo pmsSkuInfo){

		//要是没有选择默认图片.选择图片列表的第一个
		String skuDefaultImg = pmsSkuInfo.getSkuDefaultImg();
		if(StringUtils.isBlank(skuDefaultImg)){
			List<PmsSkuImage> pmsSkuImageList = pmsSkuInfo.getSkuImageList();
			if(pmsSkuImageList.isEmpty()){
				//如果图片列表为空则给一个固定的图片地址
				skuDefaultImg="http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuABu06AAMy6xI8ljs330.jpg";
			}else {
				skuDefaultImg=pmsSkuInfo.getSkuImageList().get(0).getImgUrl();
			}
		}
		skuService.saveSkuInfo(pmsSkuInfo);
	}
}
