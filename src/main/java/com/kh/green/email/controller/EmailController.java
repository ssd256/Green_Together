package com.kh.green.email.controller;

import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kh.green.email.model.vo.Mail;
import com.kh.green.email.service.EmailService;

@Controller
@RequestMapping("/email/*")
public class EmailController {
	@Inject
	EmailService emailService;
	
	@RequestMapping("send.do")
	public String send(@ModelAttribute Mail mailVo,HttpSession session, Model model,
					   @RequestParam("emailId") String emailId, @RequestParam("emailAddress") String emailAddress) {
		
		String AuthenticationKey = createAuthenticationKey();
        String msg = createMeg(AuthenticationKey);

        mailVo.setMessage(msg);
        mailVo.setReceiveMail(emailId + "@" + emailAddress);
        
		try {
			emailService.sendMail(mailVo);
			session.setAttribute("AuthenticationKey", AuthenticationKey);
			model.addAttribute("receiveMail",mailVo.getReceiveMail());
			model.addAttribute("message","메일이 발송되었습니다. <br> 인증코드를 입력해주세요");
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message","이메일 발송 실패...");
		}
		return "member/checkEmailForm";
	}
	
	@RequestMapping("searchId.do")
	public String searchId(@ModelAttribute Mail mailVo, HttpSession session, Model model,
						   @RequestParam("emailId") String emailId, @RequestParam("emailAddress") String emailAddress) {
		String AuthenticationKey = createAuthenticationKey();
        String msg = createMeg(AuthenticationKey);

        mailVo.setMessage(msg);
		mailVo.setReceiveMail(emailId + "@" + emailAddress);
		
		try {
			emailService.sendMail(mailVo);
			session.setAttribute("AuthenticationKey", AuthenticationKey);
			model.addAttribute("search", "Id");
			model.addAttribute("receiveIdMail",mailVo.getReceiveMail());
			model.addAttribute("Idmessage","메일이 발송되었습니다. <br> 인증코드를 입력해주세요");
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("Idmessage","이메일 발송 실패...");
		}
		return "member/searchUserForm";
	}
	
	@RequestMapping("searchPwd.do")
	public String searchPwd(@ModelAttribute Mail mailVo, HttpSession session, Model model,  
						    @RequestParam("searchPwdId") String searchId,@RequestParam("pwdEmailId") String emailId, @RequestParam("pwdEmailAddress") String emailAddress) {
		
		String AuthenticationKey = createAuthenticationKey();
        String msg = createMeg(AuthenticationKey);

        mailVo.setMessage(msg);
		mailVo.setReceiveMail(emailId + "@" + emailAddress);
		
		try {
			emailService.sendMail(mailVo);
			session.setAttribute("AuthenticationKey", AuthenticationKey);
			model.addAttribute("search", "Pwd");
			model.addAttribute("receivePwdMail",mailVo.getReceiveMail());
			model.addAttribute("searchId",searchId);
			model.addAttribute("Pwdmessage","메일이 발송되었습니다. <br> 인증코드를 입력해주세요");
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("Pwdmessage","이메일 발송 실패...");
		}
		return "member/searchUserForm";
	}
	
	//인증 번호 생성기
	public String createAuthenticationKey() {
		StringBuffer temp =new StringBuffer();
		Random rnd = new Random();
		for(int i=0;i<10;i++)
		{
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		return temp.toString();
	}
	
	//메일 내용
	public String createMeg(String authenticationKey) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String host =  request.getRequestURL().toString().replace(request.getRequestURI(),"");
		
		String msg="<img align=\"center\" src=\""+host+"/spring/resources/images/캡처.PNG\" width=\"140\"height=\"70\">" 
					+"<h2>안녕하세요  함께그린입니다.</h2>" 
					+ "<h3> 요청하신 인증번호 입니다. : " + authenticationKey + "</h3>"
					+ "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
		return msg;
	}
	
}
