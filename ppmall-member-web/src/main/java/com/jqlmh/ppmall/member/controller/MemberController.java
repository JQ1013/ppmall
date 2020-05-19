package com.jqlmh.ppmall.member.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.bean.UmsMember;
import com.jqlmh.ppmall.bean.UmsMemberReceiveAddress;
import com.jqlmh.ppmall.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-07 20:41
 */
@Controller
public class MemberController {

	@Reference
	private MemberService memberService;

	@GetMapping("/test")
	@ResponseBody
	public String test(){
		return "hello member!!";
	}

	/**
	 * 处理获取所有会员请求
	 * @return 所有会员list
	 */
	@GetMapping("/members")
	@ResponseBody
	public List<UmsMember> getAllMember(){
		return memberService.listMember();
	}

	/**
	 * 根据memberId查询用户的收货地址信息
	 * @return 所有会员list
	 */
	@GetMapping("/memberreceiveaddresses/{memberid}")
	@ResponseBody
	public List<UmsMemberReceiveAddress> getAllMemberReceiveAddress(@PathVariable("memberid") String memberId){
		return memberService.listMemberReceiveAddress(memberId);
	}
}
