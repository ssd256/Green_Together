package com.kh.green.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.green.common.Files;
import com.kh.green.member.model.vo.Member;
import com.kh.green.question.model.vo.Question;
import com.kh.green.shares.model.vo.Shares;
import com.kh.green.volunteer.model.vo.Participation;
import com.kh.green.volunteer.model.vo.Volunteer;

public interface MemberService {

	Member memberLogin(Member m);

	int updateMember(Member m);

	Member kakaLogin(Member m);

	int nickNameCheck(String userNickName);

	int emailCheck(String userEmail);

	int deleteMember(Member m);

	int insertMember(Member m);

	int checkId(String userId);

	Member searchUser(String userEmail);

	int updatePwd(HashMap<String, String> map);

	int searchPwdCheck(HashMap<String, String> map);

	ArrayList<Participation> participationUser(String loginUserId);

	int mVolunteerCancle(Participation p);

	Volunteer volunteerDetail(int bNo);

	ArrayList<Shares> sharesParticipate(String loginUserId);

	ArrayList<Files> sharesFileParticipate(String loginUserId);

	int updateTem(HashMap<String, String> map);

	int updateLogoutTem(HashMap<String, String> map);

	Member checkUserWithSessionKey(String sessionId);

	ArrayList<Question> myPageAskedList(String loginUserId);

	int volunteerAppUpdate(Participation p);

}
