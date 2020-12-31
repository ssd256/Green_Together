package com.kh.green.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.green.member.model.vo.Member;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = LoggerFactory.getLogger(AdminCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
//		System.out.println("interceptorLoginUser : " + loginUser);
		if(loginUser == null ||  loginUser.getUserGrade().equals("user")) {
		response.sendRedirect("/spring/home.do");
		return false;
		}
		return super.preHandle(request, response, handler);
	}
}
