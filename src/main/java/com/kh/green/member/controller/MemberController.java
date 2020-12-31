package com.kh.green.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.kh.green.common.Files;
import com.kh.green.member.model.exception.MemberException;
import com.kh.green.member.model.service.MemberService;
import com.kh.green.member.model.vo.Member;
import com.kh.green.question.model.vo.Question;
import com.kh.green.shares.model.vo.Shares;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;

@Controller
@SessionAttributes("loginUser")
public class MemberController {
	@DateTimeFormat(pattern = "yy-MM-dd")
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService mService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
//////////////////////단순 페이지 이동///////////////////////////	
	
	@RequestMapping("memberInfo.me")
	public String updateFormView() {
		return "myPage_memberInfo";
	}
	
	@RequestMapping("checkEmailForm.me")
	public String checkEmailForm(HttpSession session) {
		session.removeAttribute("AuthenticationKey");
		return "checkEmailForm";
	}
	
	@RequestMapping("memberDeleteForm.me")
	public String memberDeleteView() {
		return "mypage_memberDelete";
	}
	
	@RequestMapping("signUp.me")
	public String signUp() {
		return "memberSignUP";
	}

	@RequestMapping("memberPwdUpdate.me")
	public String memberPwdUpdate() {
		return "myPage_pwdUpdate";
	}
	
	@RequestMapping("memberSharesList.me") // 지원 : 마이페이지 - 무료나눔 신청내역 넘어가기
	public ModelAndView memberSharesList(HttpSession session, ModelAndView mv) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getUserId();
		
		ArrayList<Shares> sList = mService.sharesParticipate(loginUserId);
		ArrayList<Files> fList = mService.sharesFileParticipate(loginUserId);
		
		if(sList != null) {
			mv.addObject("sList", sList)
			.addObject("fList", fList)
			.setViewName("myPage_memberSharesList");
		}
		return mv;
	}
	
	
	@RequestMapping("memberVolunteerList.me") // 명다정 : 마이페이지 - 봉사활동 신청내역 넘어가기
	public ModelAndView memberVolunteerList(HttpSession session, ModelAndView mv) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getUserId();
		
		ArrayList<Participation> pList = null;
		
		pList = mService.participationUser(loginUserId);
		if(pList != null) {
			mv.addObject("pList", pList)
			  .setViewName("mypage_memberVolunteerList");
		}
		return mv;
	}
	@RequestMapping("mVolunteerCancle.me") // 명다정 : 마이페이지 봉사활동 취소
	public ModelAndView mVolunteerCancle(@ModelAttribute Participation p,
										 ModelAndView mv, HttpSession session) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String loginUserId = loginUser.getUserId();
		
		p.setmId(loginUserId);
		
		int result = mService.mVolunteerCancle(p);
		if(result > 0) {
			int update = mService.volunteerAppUpdate(p);
			ArrayList<Participation> pList = null;
			
			pList = mService.participationUser(loginUserId);
			if(pList != null) {
				mv.addObject("pList", pList)
				  .setViewName("mypage_memberVolunteerList");
			}
		} else {
			throw new MemberException("봉사활동 취소에 실패했습니다.");
		}
		
		return mv;
	}
	
	@RequestMapping("mVolunteerDetail.me")// 명다정 : 봉사활동 상세보기 팝업창
	public ModelAndView mVolunteerDetail(@RequestParam("bNo") int bNo, ModelAndView mv) {
//		System.out.println("bNo 뭐어어게?!?!?!?!?!!?!? : " + bNo);
		Volunteer v = mService.volunteerDetail(bNo);
		if(v != null) {
			mv.addObject("v", v)
			  .setViewName("myPage_mVolunteerDetail");
		} else {
			throw new MemberException("봉사활동 조회에 실패했습니다.");
		}
		return mv;
	}
	
	
	@RequestMapping("memberAskedList.me")//이영실 : 문의내역조회
	public ModelAndView memberAskedList(HttpSession session, ModelAndView mv) {
	Member loginUser = (Member)session.getAttribute("loginUser");
	String loginUserId = loginUser.getUserId();
	
	ArrayList<Question> aList = mService.myPageAskedList(loginUserId);
	
	if(aList != null) {
		mv.addObject("aList", aList)
		.setViewName("myPage_memberAskedList");
	}
	return mv;
} 
	
	
//////////////////////단순 페이지 이동///////////////////////////	
	//로그인 페이지
	@RequestMapping("loginView.me")
	public ModelAndView loginView(ModelAndView mv, HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		logger.debug("referer : " + referer);
		mv.addObject("referer", referer)
		.setViewName("loginView");
		return mv;
	}
	
	//암호화 후 로그인
	@RequestMapping(value="login.me", method = RequestMethod.POST)
	public String login(Member m,  Model model, HttpSession session, HttpServletResponse response,
						@RequestParam("referer") String referer,  @RequestParam(value="loging", required=false) String loging) {
		
		
		Member loginUser = mService.memberLogin(m);
		logger.debug("loginUser : " + loginUser);
		
		if(bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			model.addAttribute("loginUser", loginUser);
//			System.out.println("referer : " + referer);
			if(loging != null) {
				loginCookieCreate(loginUser,session, response);
			}
		}else {
			throw new MemberException("로그인에 실패했습니다.");
		}
			return "redirect:"+referer;
	}
	//쿠키 로그인
	private void loginCookieCreate(Member loginUser, HttpSession session, HttpServletResponse response) {
		Cookie loginCookie = new Cookie("loginCookie", session.getId());
		loginCookie.setPath("/");
		loginCookie.setMaxAge(60*60*24*7);// 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
		
		loginUser.setUsertem(loginCookie.getValue());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", loginUser.getUserId());
		map.put("userTem", loginUser.getUsertem());
		
		int result = mService.updateTem(map);
		if(result > 0)
			response.addCookie(loginCookie);
	}

	//로그인전 아이디 비밀번호 체크
	@RequestMapping(value="loginCheck.me", method = RequestMethod.POST)
	public void loginCheck(Member m,HttpServletResponse response,@RequestParam("userId") String userId, @RequestParam("userPwd") String userPwd) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
//		logger.debug("userId : " + userId);
		boolean isUsable = mService.checkId(userId) > 0 ? true : false;
//		logger.debug("isUsable : " + isUsable);
		if(isUsable) {
			m.setUserId(userId);
			m.setUserPwd(userPwd);
			Member loginUser = mService.memberLogin(m);
			if(loginUser == null || !bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
				isUsable = false;
			}
		}
//		logger.debug("isUsable : " + isUsable);
		response.getWriter().print(isUsable);
	}
	
	//카카오 로그인
		@RequestMapping("kakaoLogin.me")
		public String updateMember(@ModelAttribute Member m, Model model, HttpSession session, HttpServletResponse response,
								   @RequestParam("id") int id, @RequestParam("email") String email,  @RequestParam("referer") String referer, 
								   @RequestParam(value="loging", required=false) String loging) {
			
			m.setUserEmail(email);
			m.setUserKakao(id);
			
			Member loginUser = mService.kakaLogin(m);
			logger.debug("loginUser : " + loginUser);
			logger.debug("m : " + m);
			
			if(loging != null) {
				loginCookieCreate(loginUser,session, response);
			}
			
			if(loginUser != null) {
				model.addAttribute("loginUser", loginUser);
				return "redirect:"+referer;
			} else {
				model.addAttribute("message", "등록되지 않은 아이디 입니다.");
				return "../common/errorPage";
			}
		}
		
	//로그아웃
	@RequestMapping("logout.me")
	public String logout(HttpSession session, SessionStatus status, HttpServletRequest request, HttpServletResponse response) {
		
		Member m = (Member)session.getAttribute("loginUser");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", m.getUserId());
		map.put("userTem", "N");
		
		int result = mService.updateLogoutTem(map);
		Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
		
		if(result > 0) {
			if ( loginCookie !=null ){
				// null이 아니면 존재하면!
				loginCookie.setPath("/");
				// 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
				loginCookie.setMaxAge(0);
				// 쿠키 설정을 적용한다.
				response.addCookie(loginCookie);
			}
		}
		status.setComplete();//아예 지워주는 역할
		return "redirect:home.do";
	}
	
	//회원 가입
	@RequestMapping("minsert.me")
	public String insertMember(@ModelAttribute Member m, 
			@RequestParam("post") String post, @RequestParam("address1") String addr1, @RequestParam("address2") String addr2,
			@RequestParam("emailId") String emailId, @RequestParam("emailAddress") String emailAddress,
			@RequestParam("phone1") String phone1, @RequestParam("phone2") String phone2, @RequestParam("phone3") String phone3) {
		
		m.setUserAddress(post + "/" + addr1 + "/" + addr2);
		m.setUserEmail(emailId + "@" + emailAddress);
		m.setUserPhone(phone1 + "-" + phone2 + "-" + phone3);
//		System.out.println(m);
		// 비밀번호 평문으로 저장이 될 수 있기 때문에 암호화 처리 필요 ==> 스프링 시큐리티 모듈에서 제공하는 bcrypt 암호화 방식 사용
		// bcrypt ?
		// 		1차로 암호화 된 메세지를 수학적 연산을 통해 암호화 된 메세지인 다이제스트 생성
		//		salt값 ==> 값을 랜덤하게 생성하여 암호화가 계속 다르게 나오도록
		
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		// System.out.println("encPwd : " + encPwd);
		m.setUserPwd(encPwd);
		
		int result = mService.insertMember(m);
		
		if(result > 0) {
			return "redirect:home.do";
		} else {
			throw new MemberException("회원가입에 실패하였습니다.");
		}
	}
	
	//회원 정보 수정
	@RequestMapping("memberUpdate.me")
	public String updateMember(@ModelAttribute Member m, Model model,
			@RequestParam("post") String post, @RequestParam("address1") String addr1, @RequestParam("address2") String addr2,
			@RequestParam("emailId") String emailId, @RequestParam("emailAddress") String emailAddress,
			@RequestParam("phone1") String phone1, @RequestParam("phone2") String phone2, @RequestParam("phone3") String phone3) {
		
		m.setUserAddress(post + "/" + addr1 + "/" + addr2);
		m.setUserEmail(emailId + "@" + emailAddress);
		m.setUserPhone(phone1 + "-" + phone2 + "-" + phone3);
		int result = mService.updateMember(m);
		logger.debug("m : " + m);
		
		if(result > 0) {
		Member loginUser = mService.memberLogin(m);
		model.addAttribute("loginUser", loginUser);
		} 
		return "myPage_memberInfo";
	}
	
	//닉네임 중복체크
	@RequestMapping("nickNameCheck.me")
	public void checkNickName(String userNickName,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		logger.debug("userNickName : " + userNickName);
		boolean isUsable = mService.nickNameCheck(userNickName) == 0 ? true : false;
		logger.debug("isUsable : " + isUsable);
		response.getWriter().print(isUsable);
	}
	
	//아이디 중복체크
	@RequestMapping("idCheck.me")
	public void checkId(String userId,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		logger.debug("userId : " + userId);
		boolean isUsable = mService.checkId(userId) == 0 ? true : false;
		logger.debug("isUsable : " + isUsable);
		response.getWriter().print(isUsable);
	}
	
	//비밀번호 확인
	@RequestMapping("checkPwd.me")
	public void checkPwd(String userId, String userPwd,HttpServletResponse response,@ModelAttribute Member m) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		logger.debug("member : " + m);
		Member loginUser = mService.memberLogin(m);
		logger.debug("loginUser : " + loginUser);
		logger.debug("userPwd : " + userPwd);
		boolean isPwd = false;
		if(bcryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
			isPwd=true;
		}
		logger.debug("isPwd : " + isPwd);
		response.getWriter().print(isPwd);
	}
	
	//이메일 중복체크
	@RequestMapping("emailCheck.me")
//	public void checkEamil(String userEmail,HttpServletResponse response) throws IOException {
	public void checkEamil(HttpServletResponse response, @RequestParam("emailId") String emailId, @RequestParam("emailAddress") String emailAddress) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		String userEmail = emailId + "@" + emailAddress;
		logger.debug("userEmail : " + userEmail);
		boolean isUsable = mService.emailCheck(userEmail) == 0 ? true : false;
		logger.debug("isUsable : " + isUsable);
		response.getWriter().print(isUsable);
	}
	
	
	//회원 탈퇴
	@RequestMapping("memberDelete.me")
	public String deleteMember(String userPwd, @ModelAttribute Member m, Model model,SessionStatus status,HttpServletRequest request, HttpServletResponse response) {
		int result = mService.deleteMember(m);
		Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
		if(result > 0) {
			if ( loginCookie !=null ){
				// null이 아니면 존재하면!
				loginCookie.setPath("/");
				// 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
				loginCookie.setMaxAge(0);
				// 쿠키 설정을 적용한다.
				response.addCookie(loginCookie);
			}
			status.setComplete();//아예 지워주는 역할
			return "redirect:home.do";
		} else {
			throw new MemberException("회원 탈퇴에 실패하였습니다.");
		}
	}
	
	//아이디 찾기
	@RequestMapping("searchIdForm.me")
	public ModelAndView searchIdForm(ModelAndView mv,HttpSession session) {
		session.removeAttribute("AuthenticationKey");
		mv.addObject("search", "Id")
		  .setViewName("searchUserForm");
		return mv;
	}
	@RequestMapping("searchId.me")
	public ModelAndView searchId(String userEmail, ModelAndView mv) {
		Member m = mService.searchUser(userEmail);
		logger.debug("searchId : " + m.getUserId());
		mv.addObject("searchId", m.getUserId())
		  .setViewName("searchId");
		return mv;	
	}
	
	//비밀번호 찾기
	@RequestMapping("searchPwdForm.me")
	public ModelAndView searchPwdForm(ModelAndView mv,HttpSession session) {
		 session.removeAttribute("AuthenticationKey");
		mv.addObject("search", "Pwd")
		.setViewName("searchUserForm");
		return mv;
	}
	@RequestMapping("searchPwd.me")
	public ModelAndView searchPwd(String userEmail, ModelAndView mv) {
		Member m = mService.searchUser(userEmail);
		logger.debug("searchId : " + m.getUserId());
		mv.addObject("searchId", m.getUserId())
		.setViewName("searchPwd");
		return mv;	
	}
	//비밀번호 찾기 이후 변경
	@RequestMapping("searchUpdatePwd.me")
	public String searchUpdatePwd( @RequestParam("newPwd1") String newPwd,@RequestParam("id") String id, Model model) {
		String encNewPwd = bcryptPasswordEncoder.encode(newPwd);
		
		logger.debug("id : " + id);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("newPwd", encNewPwd);
		
		int result = mService.updatePwd(map);
		
		if(result > 0) {
			model.addAttribute("message","비밀번호가 수정되었습니다.<br> 창을 닫고 로그인 해주세요");
			return "searchPwd";
		} else {
			throw new MemberException("비밀번호 수정에 실패했습니다.");
		}
	}
	//비밀번호 찾기 이메일 아이디 체크
		@RequestMapping("searchPwdCheck.me")
		public void searchPwdCheck(String userId,HttpServletResponse response, @RequestParam("emailId") String emailId, @RequestParam("emailAddress") String emailAddress) throws IOException {
			response.setContentType("application/json; charset=UTF-8");
			
			HashMap<String, String> map = new HashMap<String, String>();
			String userEmail = emailId + "@" + emailAddress;
			map.put("email", userEmail);
			map.put("id", userId);
			
			boolean isUsable = mService.searchPwdCheck(map) > 0 ? true : false;
			response.getWriter().print(isUsable);
		}
	
	//비밀번호 수정
	@RequestMapping("mPwdUpdate.me")
	public String updatePwd(@RequestParam("pwd") String pwd, @RequestParam("newPwd1") String newPwd, 
							HttpSession session,SessionStatus status, HttpServletRequest request, HttpServletResponse response ){
		
		//아이디 얻기 : 정보 수정만 했을 때 비밀번호가 없을 것을 예상하여 모든 정보를 새로 얻어오는 과정
		Member m = mService.memberLogin((Member)session.getAttribute("loginUser"));
		
		if(bcryptPasswordEncoder.matches(pwd, m.getUserPwd())) {
			String encNewPwd = bcryptPasswordEncoder.encode(newPwd);
			m.setUserPwd(encNewPwd);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", m.getUserId());
			map.put("newPwd", encNewPwd);
			
			int result = mService.updatePwd(map);
			Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
			if(result > 0) {
				if ( loginCookie !=null ){
					// null이 아니면 존재하면!
					loginCookie.setPath("/");
					// 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
					loginCookie.setMaxAge(0);
					// 쿠키 설정을 적용한다.
					response.addCookie(loginCookie);
				}
				
				status.setComplete();//아예 지워주는 역할
				return "pwdUpdate";
			} else {
				throw new MemberException("비밀번호 수정에 실패했습니다.");
			}
		}else {
			throw new MemberException("기존 비밀번호가 틀렸습니다..");
		}
	}
	//기존 비밀번호 체크
	@RequestMapping("pwdCheck.me")
	public void pwdCheck(String pwd,HttpServletResponse response, HttpSession session) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		Member m = mService.memberLogin((Member)session.getAttribute("loginUser"));
		boolean isUsable=false;
		if(bcryptPasswordEncoder.matches(pwd, m.getUserPwd())) {
			isUsable=true;
		}
//		System.out.println("isUsable : " + isUsable);
		response.getWriter().print(isUsable);
	}
}
