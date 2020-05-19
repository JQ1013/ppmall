package com.jqlmh.ppmall.service;

import com.jqlmh.ppmall.bean.UmsMember;
import com.jqlmh.ppmall.bean.UmsMemberReceiveAddress;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-07 20:42
 */
public interface MemberService {
	List<UmsMember> listMember();

	List<UmsMemberReceiveAddress> listMemberReceiveAddress(String memberId);

	UmsMember checkLoginInfo(UmsMember umsMember);

	void saveMemberTokenInCache(String token, String memberId);

	String saveSocialLoginMember(UmsMember umsMember);

	UmsMember CheckSocialLoginMember(String sourceUid);

	UmsMemberReceiveAddress getReceiveAddressById(String memberReceiveAddressId);
}
