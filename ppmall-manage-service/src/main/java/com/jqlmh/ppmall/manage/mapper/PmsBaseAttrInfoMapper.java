package com.jqlmh.ppmall.manage.mapper;

import com.jqlmh.ppmall.bean.PmsBaseAttrInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Set;

/**
 * @author LMH
 * @create 2020-04-09 20:40
 */
@Repository
public interface PmsBaseAttrInfoMapper extends Mapper<PmsBaseAttrInfo> {
	List<PmsBaseAttrInfo> selectAttrValueListByAttrId(@Param("valueIds") Set<String> valueIdSet);
}
