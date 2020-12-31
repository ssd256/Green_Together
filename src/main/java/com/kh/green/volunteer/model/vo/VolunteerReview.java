package com.kh.green.volunteer.model.vo;

import java.sql.Date;

public class VolunteerReview {
	private int vrNo;			// 후기게시글 번호
	private int bNo;			// 봉사활동게시글 번호
	private String mId;			// 작성자
	private String mNickname;	// 작성자 닉네임
	private String vrTitle;		// 후기게시글 제목
	private String vrContent;	// 후기게시글 내용
	private Date vrDate; 		// 작성일자
	private Date vrModifyDate; 	// 수정일자
	private char vrStatus;		// 삭제여부
	
	public VolunteerReview() {}

	public VolunteerReview(int vrNo, int bNo, String mId, String mNickname, String vrTitle, String vrContent,
			Date vrDate, Date vrModifyDate, char vrStatus) {
		super();
		this.vrNo = vrNo;
		this.bNo = bNo;
		this.mId = mId;
		this.mNickname = mNickname;
		this.vrTitle = vrTitle;
		this.vrContent = vrContent;
		this.vrDate = vrDate;
		this.vrModifyDate = vrModifyDate;
		this.vrStatus = vrStatus;
	}

	public int getVrNo() {
		return vrNo;
	}

	public void setVrNo(int vrNo) {
		this.vrNo = vrNo;
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

	public String getmNickname() {
		return mNickname;
	}

	public void setmNickname(String mNickname) {
		this.mNickname = mNickname;
	}

	public String getVrTitle() {
		return vrTitle;
	}

	public void setVrTitle(String vrTitle) {
		this.vrTitle = vrTitle;
	}

	public String getVrContent() {
		return vrContent;
	}

	public void setVrContent(String vrContent) {
		this.vrContent = vrContent;
	}

	public Date getVrDate() {
		return vrDate;
	}

	public void setVrDate(Date vrDate) {
		this.vrDate = vrDate;
	}

	public Date getVrModifyDate() {
		return vrModifyDate;
	}

	public void setVrModifyDate(Date vrModifyDate) {
		this.vrModifyDate = vrModifyDate;
	}

	public char getVrStatus() {
		return vrStatus;
	}

	public void setVrStatus(char vrStatus) {
		this.vrStatus = vrStatus;
	}

	@Override
	public String toString() {
		return "VolunteerReview [vrNo=" + vrNo + ", bNo=" + bNo + ", mId=" + mId + ", mNickname=" + mNickname
				+ ", vrTitle=" + vrTitle + ", vrContent=" + vrContent + ", vrDate=" + vrDate + ", vrModifyDate="
				+ vrModifyDate + ", vrStatus=" + vrStatus + "]";
	}

	

}
