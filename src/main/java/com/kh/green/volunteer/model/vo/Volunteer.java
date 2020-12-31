package com.kh.green.volunteer.model.vo;

import java.sql.Date;

public class Volunteer {
	private int bNo;				// 게시글 번호
	private String mId;				// 게시글 작성자
	private String bTitle;			// 게시글 제목
	private String bContent;		// 게시글 내용
	private String bCategory;		// 게시판 카테고리(봉사활동)
	private Date bDate; 			// 게시글 작성일자
	private Date bModifyDate; 		// 게시글 수정일자
	private char bStatus; 			// 게시글 삭제여부
	private String vDay;			// 봉사날짜
	private String vTime;			// 봉사시간
	private String vLocation;		// 봉사장소
	private String vAgency;			// 봉사기관
	private int vRecruitment;		// 모집인원
	private int vApplicant;			// 신청인원
	private String vResponsibility;	// 봉사담당자 이름
	private int vPhone;				// 봉사담당자 핸드폰번호
	private String pre_title;		// 이전글 제목
	private int pre_no;				// 이전글 번호
	private String next_title;		// 다음글 제목
	private int next_no;			// 다음글 번호
	private String day1;			// 관리자가 등록한 봉사활동 시작 날짜
	private String day2;			// 관리자가 등록한 봉사활동 마지막 날짜
	private String time1;			// 관리자가 등록한 봉사활동 시작 시간
	private String time2;			// 관리자가 등록한 봉사활동 마지막 시간
	private String address1;		// 관리자가 등록한 봉사활동 장소
	private String address2;		// 관리자가 등록한 봉사활동 장소의 상세주소
	private int vCount;				// 봉사활동 후기 개수
	
	public Volunteer() {}

	public Volunteer(int bNo, String mId, String bTitle, String bContent, String bCategory, Date bDate,
			Date bModifyDate, char bStatus, String vDay, String vTime, String vLocation, String vAgency,
			int vRecruitment, int vApplicant, String vResponsibility, int vPhone, String pre_title, int pre_no,
			String next_title, int next_no, String day1, String day2, String time1, String time2, String address1,
			String address2, int vCount) {
		super();
		this.bNo = bNo;
		this.mId = mId;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCategory = bCategory;
		this.bDate = bDate;
		this.bModifyDate = bModifyDate;
		this.bStatus = bStatus;
		this.vDay = vDay;
		this.vTime = vTime;
		this.vLocation = vLocation;
		this.vAgency = vAgency;
		this.vRecruitment = vRecruitment;
		this.vApplicant = vApplicant;
		this.vResponsibility = vResponsibility;
		this.vPhone = vPhone;
		this.pre_title = pre_title;
		this.pre_no = pre_no;
		this.next_title = next_title;
		this.next_no = next_no;
		this.day1 = day1;
		this.day2 = day2;
		this.time1 = time1;
		this.time2 = time2;
		this.address1 = address1;
		this.address2 = address2;
		this.vCount = vCount;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public String getbCategory() {
		return bCategory;
	}

	public void setbCategory(String bCategory) {
		this.bCategory = bCategory;
	}

	public Date getbDate() {
		return bDate;
	}

	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}

	public Date getbModifyDate() {
		return bModifyDate;
	}

	public void setbModifyDate(Date bModifyDate) {
		this.bModifyDate = bModifyDate;
	}

	public char getbStatus() {
		return bStatus;
	}

	public void setbStatus(char bStatus) {
		this.bStatus = bStatus;
	}

	public String getvDay() {
		return vDay;
	}

	public void setvDay(String vDay) {
		this.vDay = vDay;
	}

	public String getvTime() {
		return vTime;
	}

	public void setvTime(String vTime) {
		this.vTime = vTime;
	}

	public String getvLocation() {
		return vLocation;
	}

	public void setvLocation(String vLocation) {
		this.vLocation = vLocation;
	}

	public String getvAgency() {
		return vAgency;
	}

	public void setvAgency(String vAgency) {
		this.vAgency = vAgency;
	}

	public int getvRecruitment() {
		return vRecruitment;
	}

	public void setvRecruitment(int vRecruitment) {
		this.vRecruitment = vRecruitment;
	}

	public int getvApplicant() {
		return vApplicant;
	}

	public void setvApplicant(int vApplicant) {
		this.vApplicant = vApplicant;
	}

	public String getvResponsibility() {
		return vResponsibility;
	}

	public void setvResponsibility(String vResponsibility) {
		this.vResponsibility = vResponsibility;
	}

	public int getvPhone() {
		return vPhone;
	}

	public void setvPhone(int vPhone) {
		this.vPhone = vPhone;
	}

	public String getPre_title() {
		return pre_title;
	}

	public void setPre_title(String pre_title) {
		this.pre_title = pre_title;
	}

	public int getPre_no() {
		return pre_no;
	}

	public void setPre_no(int pre_no) {
		this.pre_no = pre_no;
	}

	public String getNext_title() {
		return next_title;
	}

	public void setNext_title(String next_title) {
		this.next_title = next_title;
	}

	public int getNext_no() {
		return next_no;
	}

	public void setNext_no(int next_no) {
		this.next_no = next_no;
	}

	public String getDay1() {
		return day1;
	}

	public void setDay1(String day1) {
		this.day1 = day1;
	}

	public String getDay2() {
		return day2;
	}

	public void setDay2(String day2) {
		this.day2 = day2;
	}

	public String getTime1() {
		return time1;
	}

	public void setTime1(String time1) {
		this.time1 = time1;
	}

	public String getTime2() {
		return time2;
	}

	public void setTime2(String time2) {
		this.time2 = time2;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public int getvCount() {
		return vCount;
	}

	public void setvCount(int vCount) {
		this.vCount = vCount;
	}

	@Override
	public String toString() {
		return "Volunteer [bNo=" + bNo + ", mId=" + mId + ", bTitle=" + bTitle + ", bContent=" + bContent
				+ ", bCategory=" + bCategory + ", bDate=" + bDate + ", bModifyDate=" + bModifyDate + ", bStatus="
				+ bStatus + ", vDay=" + vDay + ", vTime=" + vTime + ", vLocation=" + vLocation + ", vAgency=" + vAgency
				+ ", vRecruitment=" + vRecruitment + ", vApplicant=" + vApplicant + ", vResponsibility="
				+ vResponsibility + ", vPhone=" + vPhone + ", pre_title=" + pre_title + ", pre_no=" + pre_no
				+ ", next_title=" + next_title + ", next_no=" + next_no + ", day1=" + day1 + ", day2=" + day2
				+ ", time1=" + time1 + ", time2=" + time2 + ", address1=" + address1 + ", address2=" + address2
				+ ", vCount=" + vCount + "]";
	}
}
