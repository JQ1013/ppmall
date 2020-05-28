package com.jqlmh.ppmall.ware.mapper;


import com.jqlmh.ppmall.ware.bean.WareInfo;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @param
 * @return
 */
@Repository
public interface WareInfoMapper extends Mapper<WareInfo> {


    List<WareInfo> selectWareInfoBySkuid(String skuid);


}
