package com.jqlmh.ppmall.member.mapper;

import com.jqlmh.ppmall.bean.UmsMember;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author LMH
 * @create 2020-04-07 20:41
 */

@Repository
@Mapper
public interface MemberMapper extends tk.mybatis.mapper.common.Mapper<UmsMember> {

	//List<UmsMember> listMember();
}
