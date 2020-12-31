package com.kh.green.common.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.kh.green.member.model.service.MemberService;
import com.kh.green.member.model.vo.Member;

public class CommonInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);
	
	@Autowired
	private MemberService mService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// session 객체를 가져옴
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
        Object obj = session.getAttribute("loginUser");
        if ( obj ==null ){// 로그인된 세션이 없는 경우...
            // 우리가 만들어 논 쿠키를 꺼내온다.
            Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
            if ( loginCookie !=null ){// 쿠키가 존재하는 경우(이전에 로그인때 생성된 쿠키가 존재한다는 것)
                // loginCookie의 값을 꺼내오고 -> 즉, 저장해논 세션Id를 꺼내오고
                String sessionId = loginCookie.getValue();
                // 세션Id를 checkUserWithSessionKey에 전달해 이전에 로그인한적이 있는지 체크하는 메서드를 거쳐서
                // 유효시간이 > now() 인 즉 아직 유효시간이 지나지 않으면서 해당 sessionId 정보를 가지고 있는 사용자 정보를 반환한다.
                
//                System.out.println("sessionId : " + sessionId);
                Member member = mService.checkUserWithSessionKey(sessionId);
                if ( member !=null ){// 그런 사용자가 있다면
                    // 세션을 생성시켜 준다.
                    session.setAttribute("loginUser", member);
                }
            }
        }
         
        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서 true로하면 컨트롤러 uri로 가게 됨.
        return true;
	}
}
