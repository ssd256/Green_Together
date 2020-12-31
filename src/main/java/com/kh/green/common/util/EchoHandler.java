package com.kh.green.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.green.member.model.vo.Member;

//웹소켓4
//웹소켓 핸들러 구성
public class EchoHandler extends TextWebSocketHandler {
	//로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	//서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession Websession) throws Exception {
		sessions.add(Websession);
		
		String senderNickName = getId(Websession);
		userSessionsMap.put(senderNickName , Websession);
		
//		System.out.println("<( ‵□′)───C＜─___-)|| 웹소켓 연결 : " + Websession.getId());
	}
	
	//소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession Websession, TextMessage message) throws Exception {
//		System.out.println("<( ‵□′)───C＜─___-)|| handleTextMessage : " + message);
		String msg = message.getPayload();
		
		if(!StringUtils.isEmpty(msg)) {
			String[] strs = msg.split(",");
			
			if(strs != null && strs.length == 3) {
				String cmd = strs[0]; // 알람 종류
				String userId = strs[1]; // 알람 보낼 ID
				String seq = strs[2]; // 알람 내용
				
				//작성자가 로그인 해서 있다면
				WebSocketSession boardWriterSession = userSessionsMap.get(userId);
				
				if("reply".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(userId+"님 문의사항 답변이 등록되었습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				}
				if("ordercancel".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(userId+"주문취소 요청이 들어왔습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				}
				if("delivery".equals(cmd) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(userId+"배송 완료된 물품이 있습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	//연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession Websession, CloseStatus status) throws Exception {
//		System.out.println("<( ‵□′)───C＜─___-)|| afterConnectionClosed : " + Websession + ","+status);
		userSessionsMap.remove(Websession.getId());
		sessions.remove(Websession);
	}
	
	//웹소켓 Id 가져오기
	private String getId(WebSocketSession Websession) {
		Map<String, Object> httpSession = Websession.getAttributes();
		Member loginUser = (Member)httpSession.get("loginUser");
		
		if(loginUser == null) {
			return Websession.getId();
		} else {
			return loginUser.getUserId();
		}
	}

}
