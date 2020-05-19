package com.jqlmh.ppmall.ware.mapper;


import com.jqlmh.ppmall.ware.bean.WareSku;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @param
 * @return
 */
public interface WareSkuMapper extends Mapper<WareSku> {


	Integer selectStockBySkuid(String skuid);

	int incrStockLocked(WareSku wareSku);

	int selectStockBySkuidForUpdate(WareSku wareSku);

	int deliveryStock(WareSku wareSku);

	List<WareSku> selectWareSkuAll();
}
