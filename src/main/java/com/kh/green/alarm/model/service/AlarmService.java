package com.kh.green.alarm.model.service;

import java.util.ArrayList;

import com.kh.green.alarm.model.vo.Alarm;
import com.kh.green.member.model.vo.Member;

public interface AlarmService{

	int insertAlarm(Alarm alram);

	Member memberSerachId(String mNickname);

	int newListCount(String userId);

	int originListCount(String userId);

	ArrayList<Alarm> selectNewList(String userId);

	ArrayList<Alarm> selectOriginList(String userId);

	int alarmClick(int alarmNo);

	Alarm searchUrl(int alarmNo);

	int cNo2bNo(int cNo);

	int deleteAlarm(int bNo);

}
