package com.jqlmh.ppmall.config;

import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.annotation.LoginRequired;
import com.jqlmh.ppmall.util.CookieUtil;
import com.jqlmh.ppmall.util.HttpclientUtil;
import com.jqlmh.ppmall.util.AbstractMd5Tools;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * 拦截器代码
 */
@Component
public class AuthInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

		//判断被拦截的请求的处理方法的注解上有没有@LoginRequired这个注解
		HandlerMethod hm = (HandlerMethod) handler;
		LoginRequired methodAnnotation = hm.getMethodAnnotation(LoginRequired.class);

		//没有这个注解,请求不被拦截下来[是否拦截]
		if (methodAnnotation == null) {
			return true;
		}

		String token = "";
		//如果老token不为空
		String oldToken = CookieUtil.getCookieValue(request, "oldToken", true);
		if (StringUtils.isNotBlank(oldToken)) {
			token = oldToken;
		}

		//如果新token不为空,直接使用新token
		String newToken = request.getParameter("token");
		if (StringUtils.isNotBlank(newToken)) {
			token = newToken;
		}

		//认证结果
		String authenticated = "failed";

		//认证后附带信息:memberId、nickname等
		Map<String, String> authenticatedInfoMap = new HashMap<>();

		//token不为空才进行验证
		if (StringUtils.isNotBlank(token)) {

			//将要加密的盐值通过url参数传递给verify()方法
			String ip = request.getHeader("X-Forwarded-For"); //通过nginx转发的客户端ip
			if (StringUtils.isBlank(ip)) {
				ip = request.getRemoteAddr();
				if (StringUtils.isBlank(ip)) {
					ip = "127.0.0.1";
				}
			}
			String salt = AbstractMd5Tools.MD5(ip);

			//调用认证中心验证token:返回字符串
			String authenticatedJson = HttpclientUtil.doGet("http://passport.jqlmh.com/verify?token=" + token + "&currentEncodeIPAddr=" + salt);
			authenticatedInfoMap = JSON.parseObject(authenticatedJson, Map.class);

			if (authenticatedInfoMap != null) {
				authenticated = authenticatedInfoMap.get("authenticated");
			}
		}


		boolean mustLogin = methodAnnotation.mustLogin(); //获得该请求是否必须登录成功
		//[是否需要登录]
		//必须登录成功才能使用
		if (mustLogin) {

			//token验证不通过,token为空那么就默认为"failed"也是不通过的, token为空是验证不通过的一种情况
			if (!Objects.equals(authenticated, "success")) {
				//重定向,返回登录页面
				try {
					response.sendRedirect("http://passport.jqlmh.com/login?ReturnUrl=" + request.getRequestURL());
				} catch (IOException e) {
					e.printStackTrace();
				}
				return false;
			}

			//token验证通过,覆盖cookie中的token信息
			CookieUtil.setCookie(
					request,
					response,
					"oldToken",
					token,
					WebConst.COOKIE_EXPIRE,
					true);

			//需要将token携带的用户信息写入request域中,便于在购物车操作的时候取
			request.setAttribute("memberId", authenticatedInfoMap != null ? authenticatedInfoMap.get("memberId") : null);
			request.setAttribute("nickname", authenticatedInfoMap != null ? authenticatedInfoMap.get("nickname") : null);

		} else {
			//不需要登录也能使用,但是必须验证,因为验证是不是合法用户,才能得到memberId,
			// 我们在购物车是通过memberId是否为空来判断用户是否已经登录的,所以不管登录是否成功,都需要验证
			if ("success".equals(authenticated)) {
				//验证通过
				//token验证通过,覆盖cookie中的token信息
				CookieUtil.setCookie(
						request,
						response,
						"oldToken",
						token,
						WebConst.COOKIE_EXPIRE,
						true);

				//需要将token携带的用户信息写入request域中,便于在购物车操作的时候取
				request.setAttribute("memberId", authenticatedInfoMap.get("memberId"));
				request.setAttribute("nickname", authenticatedInfoMap.get("nickname"));
			}

		}

		return true;
	}
}