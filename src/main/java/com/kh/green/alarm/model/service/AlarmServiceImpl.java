package com.kh.green.alarm.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.alarm.model.dao.AlarmDAO;
import com.kh.green.alarm.model.vo.Alarm;
import com.kh.green.member.model.vo.Member;

@Service("alarmService")
public class AlarmServiceImpl implements AlarmService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AlarmDAO alramDAO;
	
	@Override
	public int insertAlarm(Alarm alram) {
		return alramDAO.insertAlarm(sqlSession, alram);
	}

	@Override
	public Member memberSerachId(String mNickname) {
		return alramDAO.memberSerachId(sqlSession, mNickname);
	}

	@Override
	public int newListCount(String userId) {
		return alramDAO.newListCount(sqlSession, userId);
	}

	@Override
	public int originListCount(String userId) {
		return alramDAO.originListCount(sqlSession, userId);
	}

	@Override
	public ArrayList<Alarm> selectNewList(String userId) {
		return alramDAO.selectNewList(sqlSession, userId);
	}

	@Override
	public ArrayList<Alarm> selectOriginList(String userId) {
		return alramDAO.selectOriginList(sqlSession, userId);
	}

	@Override
	public int alarmClick(int alarmNo) {
		return alramDAO.alarmClick(sqlSession, alarmNo);
	}

	@Override
	public Alarm searchUrl(int alarmNo) {
		return alramDAO.searchUrl(sqlSession, alarmNo);
	}

	@Override
	public int cNo2bNo(int cNo) {
		return alramDAO.cNo2bNo(sqlSession, cNo);
	}

	@Override
	public int deleteAlarm(int bNo) {
		return alramDAO.deleteAlarm(sqlSession, bNo);
	}

}
