package com.kh.green.alarm.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.alarm.model.vo.Alarm;
import com.kh.green.member.model.vo.Member;

@Repository("alarmDAO")
public class AlarmDAO {

	public int insertAlarm(SqlSessionTemplate sqlSession, Alarm alram) {
		return sqlSession.insert("alarmMapper.insertAlarm", alram);
	}

	public Member memberSerachId(SqlSessionTemplate sqlSession, String mNickname) {
		return (Member)sqlSession.selectOne("alarmMapper.memberSerachId", mNickname);
	}

	public int newListCount(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("alarmMapper.newListCount",userId);
	}

	public int originListCount(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("alarmMapper.originListCount",userId);
	}

	public ArrayList<Alarm> selectNewList(SqlSessionTemplate sqlSession, String userId) {
		 return (ArrayList)sqlSession.selectList("alarmMapper.selectNewList", userId); 
	}

	public ArrayList<Alarm> selectOriginList(SqlSessionTemplate sqlSession, String userId) {
		 return (ArrayList)sqlSession.selectList("alarmMapper.selectOriginList", userId); 
	}

	public int alarmClick(SqlSessionTemplate sqlSession, int alarmNo) {
		return sqlSession.update("alarmMapper.alarmClick", alarmNo);
	}

	public Alarm searchUrl(SqlSessionTemplate sqlSession, int alarmNo) {
		return (Alarm)sqlSession.selectOne("alarmMapper.searchUrl", alarmNo);
	}

	public int cNo2bNo(SqlSessionTemplate sqlSession, int cNo) {
		return sqlSession.selectOne("alarmMapper.cNo2bNo",cNo);
	}

	public int deleteAlarm(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("alarmMapper.deleteAlarm",bNo);
	}

}
