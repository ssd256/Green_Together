package com.kh.green.alarm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.kh.green.alarm.model.service.AlarmService;
import com.kh.green.alarm.model.vo.Alarm;
import com.kh.green.common.BoardException;
import com.kh.green.member.model.vo.Member;

@Controller
public class AlarmController {
	
	@Autowired
	private AlarmService alarmService;
	
	@RequestMapping("alarmUpdate.al")
	public void alarmUpdate(HttpSession session, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		if(loginUser != null) {
			
			ArrayList<Alarm> alarmList = alarmService.selectNewList(loginUser.getUserId());
//			System.out.println("alarmList : " + alarmList);

			//Gson 선언
			Gson gson = new Gson();
			try {
				gson.toJson(alarmList, response.getWriter());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			return;
		}
	}
	
	@RequestMapping("alarmClick.al")
	public void alarmClick(@RequestParam("alarmNo") int alarmNo, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		int result = alarmService.alarmClick(alarmNo);
		Alarm alarm = alarmService.searchUrl(alarmNo);
		
		if(result > 0 && alarm != null) {
			String alarmUrl = alarm.getAlarmURL();
//			System.out.println("alarmUrl : " + alarmUrl);
			
			JSONObject json = new JSONObject();
			json.put("alarmUrl", alarmUrl);
			
			try {
				PrintWriter out = response.getWriter();
				out.println(json);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
		} else {
			throw new BoardException("이동 실패");
		}
	}
}
