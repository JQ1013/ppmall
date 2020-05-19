package com.jqlmh.ppmall.member.service.impl;

import com.jqlmh.ppmall.bean.UmsMember;
import com.jqlmh.ppmall.bean.UmsMemberReceiveAddress;
import com.jqlmh.ppmall.member.mapper.MemberMapper;
import com.jqlmh.ppmall.member.mapper.MemberReceiveAddressMapper;
import com.jqlmh.ppmall.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-07 20:42
 */
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private MemberReceiveAddressMapper memberReceiveAddressMapper;


	/**
	 * 获得所有的会员列表
	 * @return 所有会员
	 */
	@Override
	public List<UmsMember> listMember() {
		return memberMapper.selectAll();
	}

	/**
	 * 获取所有会员的收货地址
	 * @param memberId
	 * @return 会员收货地址
	 */
	@Override
	public List<UmsMemberReceiveAddress> listMemberReceiveAddress(Integer memberId) {
		Example example= new Example(UmsMemberReceiveAddress.class);
		example.createCriteria().andEqualTo("memberId", memberId);
		return memberReceiveAddressMapper.selectByExample(example);
	}
}
