package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.PmsSearchParam;
import com.jqlmh.ppmall.bean.PmsSearchSkuInfo;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-21 19:52
 */
public interface SearchService {
	List<PmsSearchSkuInfo> list(PmsSearchParam pmsSearchParam);
}
