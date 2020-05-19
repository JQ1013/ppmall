package com.jqlmh.ppmall.manage.mapper;

import com.jqlmh.ppmall.bean.PmsProductSaleAttr;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-10 23:46
 */
@Repository
public interface PmsProductSaleAttrMapper extends Mapper<PmsProductSaleAttr> {

	List<PmsProductSaleAttr> selectSpuSaleAttrListCheckBySku(@Param("spuId") String spuId, @Param("skuId") String skuId);
}
