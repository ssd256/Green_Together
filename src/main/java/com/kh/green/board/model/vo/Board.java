package com.kh.green.board.model.vo;

import java.sql.Date;

public class Board {

	private int bNo;
	private String mId;
	private String bTitle;
	private String bContent;
	private String bCategory;
	private Date bDate;
	private Date bModifydate;
	private String bStatus;
	
	public Board() {
		// TODO Auto-generated constructor stub
	}
	
	public Board(int bNo, String mId, String bTitle, String bContent, String bCategory, Date bDate, Date bModifydate,
			String bStatus) {
		super();
		this.bNo = bNo;
		this.mId = mId;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCategory = bCategory;
		this.bDate = bDate;
		this.bModifydate = bModifydate;
		this.bStatus = bStatus;
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

	public Date getbModifydate() {
		return bModifydate;
	}

	public void setbModifydate(Date bModifydate) {
		this.bModifydate = bModifydate;
	}

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	@Override
	public String toString() {
		return "Board [bNo=" + bNo + ", mId=" + mId + ", bTitle=" + bTitle + ", bContent=" + bContent + ", bCategory="
				+ bCategory + ", bDate=" + bDate + ", bModifydate=" + bModifydate + ", bStatus=" + bStatus + "]";
	}
}
