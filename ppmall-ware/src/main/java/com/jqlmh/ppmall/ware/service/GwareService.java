package com.jqlmh.ppmall.ware.service;


import com.jqlmh.ppmall.ware.bean.WareInfo;
import com.jqlmh.ppmall.ware.bean.WareOrderTask;
import com.jqlmh.ppmall.ware.bean.WareSku;

import java.util.List;
import java.util.Map;

/**
 * @param
 * @return
 */
public interface GwareService {
	Integer getStockBySkuId(String skuid);

	boolean hasStockBySkuId(String skuid, Integer num);

	List<WareInfo> getWareInfoBySkuid(String skuid);

	void addWareInfo();

	Map<String, List<String>> getWareSkuMap(List<String> skuIdlist);

	void addWareSku(WareSku wareSku);

	void deliveryStock(WareOrderTask taskExample);

	WareOrderTask saveWareOrderTask(WareOrderTask wareOrderTask);

	List<WareOrderTask> checkOrderSplit(WareOrderTask wareOrderTask);

	void lockStock(WareOrderTask wareOrderTask);

	List<WareOrderTask> getWareOrderTaskList(WareOrderTask wareOrderTask);

	List<WareSku> getWareSkuList();

	List<WareInfo> getWareInfoList();
}
