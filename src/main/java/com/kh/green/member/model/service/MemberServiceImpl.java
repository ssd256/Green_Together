package com.kh.green.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.green.common.Files;
import com.kh.green.member.model.dao.MemberDAO;
import com.kh.green.member.model.vo.Member;
import com.kh.green.question.model.vo.Question;
import com.kh.green.shares.model.vo.Shares;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;

@Service("mService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDAO mDAO;
	
	@Override
	public Member memberLogin(Member m) {
		return mDAO.memberLogin(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession, m);
	}

	@Override
	public Member kakaLogin(Member m) {
		return mDAO.kakaoLogin(sqlSession, m);
	}

	@Override
	public int nickNameCheck(String userNickName) {
		return mDAO.nickNameCheck(sqlSession, userNickName);
	}

	@Override
	public int emailCheck(String userEmail) {
		return mDAO.emailCheck(sqlSession, userEmail);
	}

	@Override
	public int deleteMember(Member m) {
		return mDAO.deleteMember(sqlSession, m);
	}

	@Override
	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public int checkId(String userId) {
		return mDAO.checkId(sqlSession, userId);
	}

	@Override
	public Member searchUser(String userEmail) {
		return mDAO.searchUser(sqlSession, userEmail);
	}

	@Override
	public int updatePwd(HashMap<String, String> map) {
		return mDAO.updatePwd(sqlSession, map);
	}

	@Override
	public int searchPwdCheck(HashMap<String, String> map) {
		return mDAO.searchPwdCheck(sqlSession, map);
	}

	@Override
	public ArrayList<Participation> participationUser(String loginUserId) {
		return mDAO.participationUser(sqlSession, loginUserId);
	}

	@Override
	public int mVolunteerCancle(Participation p) {
		return mDAO.mVolunteerCancle(sqlSession, p);
	}

	@Override
	public Volunteer volunteerDetail(int bNo) {
		return mDAO.mVolunteerDetail(sqlSession, bNo);
	}
	
	@Override
	public ArrayList<Shares> sharesParticipate(String loginUserId) {
		return mDAO.sharesParticipate(sqlSession, loginUserId);
	}
	
	@Override
	public ArrayList<Files> sharesFileParticipate(String loginUserId) {
		return mDAO.sharesFileParticipate(sqlSession, loginUserId);
	}

	@Override
	public int updateTem(HashMap<String, String> map) {
		return mDAO.updateTem(sqlSession, map);
	}

	@Override
	public int updateLogoutTem(HashMap<String, String> map) {
		return mDAO.updateLogoutTem(sqlSession, map);
	}

	@Override
	public Member checkUserWithSessionKey(String sessionId) {
		return mDAO.checkUserWithSessionKey(sqlSession, sessionId);
	}

	@Override
	public ArrayList<Question> myPageAskedList(String loginUserId) {
		return mDAO.myPageAskedList(sqlSession, loginUserId);
	}

	@Override
	public int volunteerAppUpdate(Participation p) {
		return mDAO.volunteerAppUpdate(sqlSession, p);
	}


}
