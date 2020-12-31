package com.kh.green.shares.model.vo;

import java.sql.Date;

public class Comments {
	private int cNo; //rId
	private int bNo;
	private String mId; //rWriter
	private String cContent;
	private Date cDate;
	private Date cModifyDate;
	private String cStatus;
	private int cReport;
	
	public Comments() {}
	
	public Comments(int cNo, int bNo, String mId, String cContent, Date cDate, String cStatus) {
		super();
		this.cNo = cNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cContent = cContent;
		this.cDate = cDate;
		this.cStatus = cStatus;
	}



	public Comments(int cNo, int bNo, String mId, String cContent, Date cDate, Date cModifyDate, String cStatus) {
		super();
		this.cNo = cNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cContent = cContent;
		this.cDate = cDate;
		this.cModifyDate = cModifyDate;
		this.cStatus = cStatus;
	}



	public Comments(int cNo, int bNo, String mId, String cContent, Date cDate, Date cModifyDate, String cStatus,
			int cReport) {
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
		return "Comments [cNo=" + cNo + ", bNo=" + bNo + ", mId=" + mId + ", cContent=" + cContent + ", cDate=" + cDate
				+ ", cModifyDate=" + cModifyDate + ", cStatus=" + cStatus + ", cReport=" + cReport + "]";
	}
	
	
}
