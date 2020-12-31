package com.kh.green.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.green.member.model.vo.Member;

public class MemberInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = LoggerFactory.getLogger(MemberInterceptor.class);
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		if(loginUser != null) {
			logger.debug( loginUser.getUserId() + "로그인 성공!");
		}else {
			logger.debug( "로그인 실패!");
		}
	}
}
