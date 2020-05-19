package com.jqlmh.ppmall.manage.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.jqlmh.ppmall.bean.PmsProductImage;
import com.jqlmh.ppmall.bean.PmsProductInfo;
import com.jqlmh.ppmall.bean.PmsProductSaleAttr;
import com.jqlmh.ppmall.bean.PmsProductSaleAttrValue;
import com.jqlmh.ppmall.manage.mapper.PmsProductImageMapper;
import com.jqlmh.ppmall.manage.mapper.PmsProductInfoMapper;
import com.jqlmh.ppmall.manage.mapper.PmsProductSaleAttrMapper;
import com.jqlmh.ppmall.manage.mapper.PmsProductSaleAttrValueMapper;
import com.jqlmh.ppmall.service.SpuService;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-10 15:51
 */

@Service
public class SpuServiceImpl implements SpuService {

	@Autowired
	private PmsProductInfoMapper pmsProductInfoMapper;

	@Autowired
	private PmsProductImageMapper pmsProductImageMapper;

	@Autowired
	private PmsProductSaleAttrMapper pmsProductSaleAttrMapper;

	@Autowired
	private PmsProductSaleAttrValueMapper pmsProductSaleAttrValueMapper;


	/**
	 * 根据三级分类id,查询所有对应的spu
	 *
	 * @param catalog3Id :三级分类id
	 * @return List<PmsProductInfo>
	 */
	@Override
	public List<PmsProductInfo> spuList(String catalog3Id) {
		Example example = new Example(PmsProductInfo.class);
		example.createCriteria().andEqualTo("catalog3Id", catalog3Id);
		return pmsProductInfoMapper.selectByExample(example);
	}

	/**
	 * 保存新增的spu属性:包括PmsProductInfo+[PmsProductSaleAttr+PmsProductImage]
	 *
	 * @param pmsProductInfo
	 * @return
	 */
	@Override
	public void saveSpuInfo(PmsProductInfo pmsProductInfo) {
		//保存spu信息
		Integer i = pmsProductInfoMapper.insertSelective(pmsProductInfo);

		//生成产品主键id
		String pmsProductInfoId = pmsProductInfo.getId();

		//保存图片信息
		List<PmsProductImage> spuImageList = pmsProductInfo.getSpuImageList();
		for (PmsProductImage pmsProductImage : spuImageList) {
			//获取该spu的产品id,并设置图片的为产品id:productId
			pmsProductImage.setProductId(pmsProductInfoId);
			pmsProductImageMapper.insertSelective(pmsProductImage);
		}

		//保存销售属性
		List<PmsProductSaleAttr> spuSaleAttrList = pmsProductInfo.getSpuSaleAttrList();

		for (PmsProductSaleAttr pmsProductSaleAttr : spuSaleAttrList) {
			//获取该spu的产品id,并设置销售属性的产品id:productId
			pmsProductSaleAttr.setProductId(pmsProductInfoId);
			pmsProductSaleAttrMapper.insertSelective(pmsProductSaleAttr);

			//保存每一个销售属性的所有值
			List<PmsProductSaleAttrValue> spuSaleAttrValueList = pmsProductSaleAttr.getSpuSaleAttrValueList();
			for (PmsProductSaleAttrValue pmsProductSaleAttrValue : spuSaleAttrValueList) {
				//加入数据库
				//设置productId
				pmsProductSaleAttrValue.setProductId(pmsProductInfoId);

				//不用设置saleAttrId:因为前端会发送过来

				//插入数据库
				pmsProductSaleAttrValueMapper.insertSelective(pmsProductSaleAttrValue);
			}
		}
	}

	/**
	 * 获取对应spuId的对应图片
	 *
	 * @param spuId:spuId
	 * @return List<PmsProductImage>
	 */
	@Override
	public List<PmsProductImage> spuImageList(String spuId) {
		Example example = new Example(PmsProductImage.class);
		example.createCriteria().andEqualTo("productId", spuId);
		return pmsProductImageMapper.selectByExample(example);
	}

	/**
	 * 根据spuId,处理添加sku页面的获取所有spu销售属性和值
	 *
	 * @param spuId spuId
	 * @return List<PmsProductSaleAttrValue>
	 */
	@Override
	public List<PmsProductSaleAttr> spuSaleAttrList(String spuId) {
		//1.查询对应属性
		Example example = new Example(PmsProductSaleAttr.class);
		example.createCriteria().andEqualTo("productId", spuId);
		List<PmsProductSaleAttr> pmsProductSaleAttrList = pmsProductSaleAttrMapper.selectByExample(example);

		//2.根据spuId查询对应属性值
		for (PmsProductSaleAttr pmsProductSaleAttr : pmsProductSaleAttrList) {
			Example example1 = new Example(PmsProductSaleAttrValue.class);

			//销售属性id使用的是系统字典里面的id(pms_base_sale_attr表),不是销售属性表的主键
			Example.Criteria criteria = example1.createCriteria().andEqualTo("productId", spuId).andEqualTo("saleAttrId", pmsProductSaleAttr.getSaleAttrId());
			List<PmsProductSaleAttrValue> saleAttrValueList = pmsProductSaleAttrValueMapper.selectByExample(example1);

			pmsProductSaleAttr.setSpuSaleAttrValueList(saleAttrValueList);
		}

		return pmsProductSaleAttrList;
	}

	/**
	 * 在item页面,根据选择的销售属性选定一个sku
	 * @param spuId
	 * @param skuId
	 * @return
	 */
	@Override
	public List<PmsProductSaleAttr> spuSaleAttrListCheckBySku(String spuId, String skuId) {
		return pmsProductSaleAttrMapper.selectSpuSaleAttrListCheckBySku(spuId,skuId);
	}
}
