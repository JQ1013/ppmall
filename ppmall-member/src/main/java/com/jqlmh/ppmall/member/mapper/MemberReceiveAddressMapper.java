package com.jqlmh.ppmall.member.mapper;

import com.jqlmh.ppmall.bean.UmsMemberReceiveAddress;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author LMH
 * @create 2020-04-08 0:02
 */
@Repository
@Mapper
public interface MemberReceiveAddressMapper extends tk.mybatis.mapper.common.Mapper<UmsMemberReceiveAddress> {
}
