package com.jqlmh.ppmall.passport.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.UmsMember;
import com.jqlmh.ppmall.service.MemberService;
import com.jqlmh.ppmall.util.HttpclientUtil;
import com.jqlmh.ppmall.util.JwtUtil;
import com.jqlmh.ppmall.util.AbstractMd5Tools;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * @author LMH
 * @create 2020-04-24 14:25
 */
@Controller
public class PassportController {


	@Reference
	private MemberService memberService;


	/**
	 * 处理去登录页面的请求
	 *
	 * @param returnUrl 要返回的地址
	 * @param model     model
	 * @return /index
	 */
	@RequestMapping(value = {"/login", "/"})
	public String login(String returnUrl, Model model) {
		if (StringUtils.isNotBlank(returnUrl)) {
			model.addAttribute("ReturnUrl", returnUrl);
		}
		return "index";
	}


	/**
	 * 处理验证用户名密码的请求
	 *
	 * @param umsMember 用户对象
	 * @return jwt加密token
	 */
	@ResponseBody
	@RequestMapping("/checkLogin")
	public String checkLogin(UmsMember umsMember, HttpServletRequest request) {


		//调用用户服务验证用户名和密码
		UmsMember loginMember = memberService.checkLoginInfo(umsMember);
		String token;
		if (loginMember != null) {
			//登录成功
			//jwt制作token[key一般要进行负载加密,盐值也需要复杂的东西]
			String memberId = loginMember.getId();
			String nickname = loginMember.getNickname();

			Map<String, Object> memberMap = new HashMap<>(16);
			memberMap.put("memberId", memberId);
			memberMap.put("nickname", nickname);

			//通过nginx转发的客户端ip
			String ip = request.getHeader("X-Forwarded-For");
			if (StringUtils.isBlank(ip)) {
				ip = request.getRemoteAddr();
				if (StringUtils.isBlank(ip)) {
					ip = "127.0.0.1";
				}
			}
			String salt = AbstractMd5Tools.MD5(ip);
			//按照设计的算法对参数进行加密,生成token
			token = JwtUtil.encode("2020lmhissorich", memberMap, salt);

			//将token存入一份到redis
			memberService.saveMemberTokenInCache(token, memberId);

		} else {
			//登录失败
			token = "failed";
		}
		return token;
	}


	/**
	 * 处理验证token真假的请求
	 *
	 * @param token token
	 * @return decodeTokenMap
	 */
	@ResponseBody
	@RequestMapping("/verify")
	public String verify(String token, HttpServletRequest request, String currentEncodeIpAddr) {

		//不用这个
		System.err.println("拦截器所在服务器生成的request请求传递的url:" + request.getRemoteAddr());
		//拦截器传递过来的参数
		System.err.println("原始发送请求的应用request传递的url:" + currentEncodeIpAddr);


		//通过jwt检验token真假
		Map<String, String> map = new HashMap<>(16);

		Map<String, Object> decodeTokenMap = JwtUtil.decode(token, "2020lmhissorich", currentEncodeIpAddr);
		if (decodeTokenMap == null) {
			return "failed";
		}
		map.put("authenticated", "success");
		map.put("memberId", (String) decodeTokenMap.get("memberId"));
		map.put("nickname", (String) decodeTokenMap.get("nickname"));

		return JSON.toJSONString(map);
	}

	/**
	 * 获取用户授权后的授权码,保存到数据库
	 * 网址1是用户点击微博图像登录
	 * 网址2是用户授权后回调的地址:返回code
	 *
	 * @param code 授权码
	 * @return 网站搜索首页
	 */
	@RequestMapping("/auth2.0_login")
	public String authLogin(String code, HttpServletRequest request) {

		//一、通过授权码code发送post请求到第三方网站，换取access_token
		//封装发送post请求的参数的map
		Map<String, String> paramMap = new HashMap<>(16);
		this.setParamMap(paramMap, code);

		//网址3
		String getAccessTokenUrl = "https://api.weibo.com/oauth2/access_token?";
		String accessTokenJson = HttpclientUtil.doPost(getAccessTokenUrl, paramMap);

		//返回的json字符串不为空,转为map,获取access_token和uid的值,保存数据库
		String token = "";
		if (StringUtils.isNotBlank(accessTokenJson)) {
			Map accessTokenMap = JSON.parseObject(accessTokenJson, Map.class);
			if (accessTokenMap != null) {
				String accessToken = (String) accessTokenMap.get("access_token");
				String sourceUid = (String) accessTokenMap.get("uid");

				//二、access_taken换取用户信息
				//网址4
				String getMemberInfoUrl =
						"https://api.weibo.com/2/users/show.json?access_token=" + accessToken + "&uid=" + sourceUid;
				String memberInfoJson = HttpclientUtil.doGet(getMemberInfoUrl);
				@SuppressWarnings("unchecked")
				Map<String, Object> memberInfoMap = JSON.parseObject(memberInfoJson, Map.class);

				//三、用户信息保存数据库,用户来源类型设置为微博类型
				UmsMember umsMember = new UmsMember();
				String createdAt = (String) (memberInfoMap != null ? memberInfoMap.get("created_at") : null);
				createdAt = createdAt != null ? createdAt.replace("+0800", "CST") : null;

				//Thu Oct 16 08:38:51 +0800 2014
				SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.US);
				Date createTime = new Date();
				try {
					createTime = sdf.parse(createdAt);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				System.err.println(createTime.getClass());
				if (memberInfoMap != null) {
					umsMember
							.setSourceType(4)
							.setAccessCode(code)
							.setAccessToken(accessToken)
							.setSourceUid((String) memberInfoMap.get("idstr"))
							.setCity((String) memberInfoMap.get("location"))
							.setCreateTime(createTime)
							.setNickname((String) memberInfoMap.get("screen_name"))
							.setGender((String) memberInfoMap.get("gender"));
				}

				//保存数据库的时候先查询数据库是否已经存过了[根据sourceUid]
				UmsMember checkMemberSaved = memberService.checkSocialLoginMember(umsMember.getSourceUid());
				String memberId;
				if (checkMemberSaved == null) {
					//数据库里面没有,保存信息
					memberId = memberService.saveSocialLoginMember(umsMember);
					//本来可以使用主键策略自动获取新增数据的id,但是因为rpc不能将dao层的对象传给controller层,所以dao层显式地返回保存对象的id

				} else {
					//数据库已有信息
					umsMember = checkMemberSaved;
					memberId = umsMember.getId();
				}

				//四、生成jwt的token,重定向到首页,携带该token
				String nickname = umsMember.getNickname();

				//jwt制作token[key一般要进行负载加密,盐值也需要复杂的东西]
				Map<String, Object> memberMap = new HashMap<>(16);
				memberMap.put("memberId", memberId);
				memberMap.put("nickname", nickname);

				//通过nginx转发的客户端ip
				String ip = request.getHeader("X-Forwarded-For");
				if (StringUtils.isBlank(ip)) {
					ip = request.getRemoteAddr();
					if (StringUtils.isBlank(ip)) {
						ip = "127.0.0.1";
					}
				}
				String salt = AbstractMd5Tools.MD5(ip);
				//按照设计的算法对参数进行加密,生成token
				token = JwtUtil.encode("2020lmhissorich", memberMap, salt);

				//将token存入一份到redis
				memberService.saveMemberTokenInCache(token, memberId);

			}
		}
		return "redirect:http://search.jqlmh.com/index?token=" + token;
	}


	/**
	 * 封装发送post请求的参数的map
	 *
	 * @param paramMap 参数Map
	 * @param code     授权码
	 */
	private void setParamMap(Map<String, String> paramMap, String code) {

		//App Key
		paramMap.put("client_id", "1790913327");
		//App 秘钥:用于获取access_token时做验证
		paramMap.put("client_secret", "7a0a0888610e052d5eeb95f800719e5c");
		// 1)code用后即毁
		// 2)access_token在几天内是一样的
		//固定
		paramMap.put("grant_type", "authorization_code");
		//授权成功回调地址
		paramMap.put("redirect_uri", "http://passport.jqlmh.com/auth2.0_login");
		//授权码
		paramMap.put("code", code);

	}


}
