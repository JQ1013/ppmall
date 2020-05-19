package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PmsBaseCatalog1;
import com.jqlmh.ppmall.bean.PmsBaseCatalog2;
import com.jqlmh.ppmall.bean.PmsBaseCatalog3;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-09 17:55
 */
public interface CatalogService {
	List<PmsBaseCatalog1> getCatalog1();

	List<PmsBaseCatalog2> getCatalog2(String catalog1Id);

	List<PmsBaseCatalog3> getCatalog3(String catalog2Id);
}
