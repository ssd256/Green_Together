package com.kh.green.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.green.common.Files;
import com.kh.green.member.model.vo.Member;
import com.kh.green.question.model.vo.Question;
import com.kh.green.shares.model.vo.Shares;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;


@Repository("mDAO")
public class MemberDAO {

	public Member memberLogin(SqlSessionTemplate sqlSession, Member m) {
		return (Member)sqlSession.selectOne("memberMapper.memberLogin", m);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}

	public Member kakaoLogin(SqlSessionTemplate sqlSession, Member m) {
		return (Member)sqlSession.selectOne("memberMapper.kakaoLogin", m);
	}

	public int nickNameCheck(SqlSessionTemplate sqlSession, String userNickName) {
		return sqlSession.selectOne("memberMapper.nickNameCheck", userNickName);
	}

	public int emailCheck(SqlSessionTemplate sqlSession, String userEmail) {
		return sqlSession.selectOne("memberMapper.emailCheck", userEmail);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.deleteMember", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int checkId(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.checkId", userId);
	}
	
	public Member searchUser(SqlSessionTemplate sqlSession, String userEmail) {
		return (Member)sqlSession.selectOne("memberMapper.searchUser", userEmail);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updatePwd", map);
	}

	public int searchPwdCheck(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.searchPwdCheck", map);
	}

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.getListCount");
	}

	public ArrayList<Participation> participationUser(SqlSessionTemplate sqlSession, String loginUserId) {
		return (ArrayList)sqlSession.selectList("memberMapper.participationUser", loginUserId);
	}

	public int mVolunteerCancle(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.update("volunteerMapper.participationStatus", p);
	}

	public Volunteer mVolunteerDetail(SqlSessionTemplate sqlSession, int bNo) {
		return (Volunteer)sqlSession.selectOne("volunteerMapper.mVolunteerDetail", bNo);
	}

	public ArrayList<Shares> sharesParticipate(SqlSessionTemplate sqlSession, String loginUserId) {
		return (ArrayList)sqlSession.selectList("memberMapper.sharesParticipate", loginUserId);
	}

	public ArrayList<Files> sharesFileParticipate(SqlSessionTemplate sqlSession, String loginUserId) {
		return (ArrayList)sqlSession.selectList("memberMapper.sharesFileParticipate", loginUserId);
	}

	public int updateTem(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updateTem", map);
	}

	public int updateLogoutTem(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.update("memberMapper.updateTem", map);
	}

	public Member checkUserWithSessionKey(SqlSessionTemplate sqlSession, String sessionId) {
		return (Member)sqlSession.selectOne("memberMapper.checkUserWithSessionKey", sessionId);
	}

	public ArrayList<Question> myPageAskedList(SqlSessionTemplate sqlSession, String loginUserId) {
		return (ArrayList)sqlSession.selectList("memberMapper.myPageAskedList", loginUserId);
	}

	public int volunteerAppUpdate(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.update("volunteerMapper.vAppDecountUpdate", p);
	}
}
