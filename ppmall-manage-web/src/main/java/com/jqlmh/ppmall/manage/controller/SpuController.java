package com.jqlmh.ppmall.manage.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.PmsProductImage;
import com.jqlmh.ppmall.bean.PmsProductInfo;
import com.jqlmh.ppmall.bean.PmsProductSaleAttr;
import com.jqlmh.ppmall.manage.utils.PmsUploadUtil;
import com.jqlmh.ppmall.service.SpuService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-10 15:41
 */
@RestController
@CrossOrigin
public class SpuController {

	@Reference
	private SpuService spuService;


	/**
	 * 处理获取所有spu的请求
	 * @param catalog3Id:三级分类id
	 * @return
	 */
	@RequestMapping("/spuList")
	public List<PmsProductInfo> spuList(@RequestParam("catalog3Id") String catalog3Id){
		return spuService.spuList(catalog3Id);
	}


	/**
	 * 处理新增spu的请求
	 * @param pmsProductInfo
	 * @return
	 */
	@RequestMapping("/saveSpuInfo")
	public String saveSpuInfo(@RequestBody PmsProductInfo pmsProductInfo){
		spuService.saveSpuInfo(pmsProductInfo);
		System.out.println(pmsProductInfo.getId()+pmsProductInfo.getSpuImageList()+pmsProductInfo.getSpuSaleAttrList());
		return JSON.toJSONString("success");
	}

	/**
	 * 处理图片存储的请求
	 * @param multipartFile 上传的图片
	 */
	@RequestMapping("/fileUpload")
	public String fileUpload(@RequestParam("file") MultipartFile multipartFile){
		System.out.println(multipartFile.getOriginalFilename());
		//1.将图片上传到分布式文件存储系统:工具内里面执行了上传保存操作

		//2.将图片的存储路径等元数据返回给页面,然后点击保存就保存到数据库
		String imageUrl = PmsUploadUtil.uploadImage(multipartFile);
		System.out.println(imageUrl);
		return imageUrl;
	}

	/**
	 * 处理添加sku页面的获取所有spu图片的请求
	 * @param spuId spuId
	 * @return spuId对应的所有图片集合
	 */
	@RequestMapping("/spuImageList")
	public List<PmsProductImage> spuImageList(@RequestParam("spuId") String spuId){
		return spuService.spuImageList(spuId);
	}

	/**
	 * 处理添加sku页面的获取所有spu销售和对应的属性值的请求
	 * @param spuId spuId
	 * @return List<PmsProductSaleAttrValue>
	 */
	@RequestMapping("/spuSaleAttrList")
	public List<PmsProductSaleAttr> spuSaleAttrList(@RequestParam("spuId") String spuId){
		return spuService.spuSaleAttrList(spuId);
	}


}
