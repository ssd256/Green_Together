package com.kh.green.question.model.vo;

import java.sql.Date;

public class Reply {
	private int cNo; 		  //댓글 번호
	private int bNo; 		  //게시글 번호
	private String mId; 	  //댓글 작성자
	private String cContent;  //댓글내용
	private Date cDate; 	  //작성일자
	private Date cModifyDate; //수정일자
	private String cStatus;   //삭제여부(기본값'N')
	private int cReport; 	  //신고횟수

	public Reply() {}

	public Reply(int cNo, int bNo, String mId, String cContent, Date cDate, Date cModifyDate, String cStatus, int cReport) {
		super();
		this.cNo = cNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cContent = cContent;
		this.cDate = cDate;
		this.cModifyDate = cModifyDate;
		this.cStatus = cStatus;
		this.cReport = cReport;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
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

	public String getcContent() {
		return cContent;
	}

	public void setcContent(String cContent) {
		this.cContent = cContent;
	}

	public Date getcDate() {
		return cDate;
	}

	public void setcDate(Date cDate) {
		this.cDate = cDate;
	}

	public Date getcModifyDate() {
		return cModifyDate;
	}

	public void setcModifyDate(Date cModifyDate) {
		this.cModifyDate = cModifyDate;
	}

	public String getcStatus() {
		return cStatus;
	}

	public void setcStatus(String cStatus) {
		this.cStatus = cStatus;
	}
	
	public int getcReport() {
		return cReport;
	}
	
	public void setcReport(int cReport) {
		this.cReport = cReport;
	}

	@Override
	public String toString() {
		return "Reply [cNo=" + cNo + ", bNo=" + bNo + ", mId=" + mId + ", cContent=" + cContent + ", cDate=" + cDate
				+ ", cModifyDate=" + cModifyDate + ", cStatus=" + cStatus + ", cReport" + cReport + "]";
	}
	
	
	
}



