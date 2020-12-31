package com.kh.green.email.service;

import java.io.UnsupportedEncodingException;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.kh.green.email.model.vo.Mail;


@Service
public class EmailServicepl implements EmailService {
	@Inject
	JavaMailSender mailSender; //메일 발송 객체
	
	@Override
	public void sendMail(Mail mailVo) {
		
		try {
			MimeMessage msg=mailSender.createMimeMessage();
			//이메일 수신자
			msg.addRecipient(RecipientType.TO, new InternetAddress(mailVo.getReceiveMail()));
			//이메일 발신자
			msg.addFrom(new InternetAddress[] {new InternetAddress(mailVo.getSenderMail(),mailVo.getSenderName())});
			//이메일 제목
			msg.setSubject(mailVo.getSubject(), "UTF-8");
			//이메일 본문
			msg.setText(mailVo.getMessage(),"UTF-8","html");
			mailSender.send(msg);//전송
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
