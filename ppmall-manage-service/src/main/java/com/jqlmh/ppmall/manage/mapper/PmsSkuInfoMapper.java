package com.jqlmh.ppmall.manage.mapper;

import com.jqlmh.ppmall.bean.PmsSkuInfo;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-11 21:10
 */
@Repository
public interface PmsSkuInfoMapper extends Mapper<PmsSkuInfo> {
	List<PmsSkuInfo> selectSkuSaleAttrValueListBySpu(String spuId);
}
