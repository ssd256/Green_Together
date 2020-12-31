package com.kh.green.member.model.vo;

import java.sql.Date;

public class Member {
	private String userId; 			// 아이디
	private String userPwd;			// 비밀번호
	private String usertem;			// 임시비밀번호 상태
	private String userNickName; 	// 닉네임
	private String userName;		//이름
	private Date userBirthday;		//생일
	private String userGender;		//성별
	private String userAddress;		//주소
	private String userEmail;		//이메일
	private String userPhone;		//번호
	private String userInterst;		//취미
	private String userJob;			//직업
	private String userEnable;		//탈퇴여부
	private String userGrade;		//등급
	private int userKakao;			//카카오 아이디
	
	
	public Member() {}
	//로그인
	public Member(String userId, String userPwd) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
	}

	public Member(String userId, String userPwd, String usertem, String userNickName, String userName, Date userBirthday,
			String userGender, String userAddress, String userEmail, String userPhone, String userInterst, String userJob,
			String userEnable, String userGrade, int userKakao) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.usertem = usertem;
		this.userNickName = userNickName;
		this.userName = userName;
		this.userBirthday = userBirthday;
		this.userGender = userGender;
		this.userAddress = userAddress;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
		this.userInterst = userInterst;
		this.userJob = userJob;
		this.userEnable = userEnable;
		this.userGrade = userGrade;
		this.userKakao = userKakao;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUsertem() {
		return usertem;
	}

	public void setUsertem(String usertem) {
		this.usertem = usertem;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getUserBirthday() {
		return userBirthday;
	}

	public void setUserBirthday(Date userBirthday) {
		this.userBirthday = userBirthday;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserInterst() {
		return userInterst;
	}

	public void setUserInterst(String userInterst) {
		this.userInterst = userInterst;
	}

	public String getUserJob() {
		return userJob;
	}

	public void setUserJob(String userJob) {
		this.userJob = userJob;
	}

	public String getUserEnable() {
		return userEnable;
	}

	public void setUserEnable(String userEnable) {
		this.userEnable = userEnable;
	}

	public String getUserGrade() {
		return userGrade;
	}

	public void setUserGrade(String userGrade) {
		this.userGrade = userGrade;
	}

	public int getUserKakao() {
		return userKakao;
	}

	public void setUserKakao(int userKakao) {
		this.userKakao = userKakao;
	}

	@Override
	public String toString() {
		return "Member [userId=" + userId + ", userPwd=" + userPwd + ", usertem=" + usertem + ", userNickName="
				+ userNickName + ", userName=" + userName + ", userBirthday=" + userBirthday + ", userGender="
				+ userGender + ", userAddress=" + userAddress + ", userEmail=" + userEmail + ", userPhone=" + userPhone
				+ ", userInterst=" + userInterst + ", userJob=" + userJob + ", userEnable=" + userEnable
				+ ", userGrade=" + userGrade + ", userKakao=" + userKakao + "]";
	}
	
	
	
	
}
