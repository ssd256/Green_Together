package com.kh.green.shares.model.vo;

import java.sql.Date;

public class Shares {
	private int bNo; // 게시글 번호
	private String mId; // 게시글 작성자
	private String bTitle; // 제목
	private String bContent; // 내용
	private String bCategory; // 게시판 카테고리(물품나눔)
	private Date bDate; // 작성일자
	private Date bModifyDate; // 수정일자
	private char bStatus; // 삭제여부
	
	private char sStatus; // 상품 마감 여부 (재고가 0일 때 버튼 비활성화 - 뷰에서)
	private String sAddress; // 주소
	private int sStock; // 재고
	
	public Shares() {}

	public Shares(int bNo, String mId, String bTitle, String bContent, String bCategory, Date bDate, char bStatus,
			char sStatus, String sAddress, int sStock) {
		super();
		this.bNo = bNo;
		this.mId = mId;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCategory = bCategory;
		this.bDate = bDate;
		this.bStatus = bStatus;
		this.sStatus = sStatus;
		this.sAddress = sAddress;
		this.sStock = sStock;
	}

	public Shares(int bNo, String mId, String bTitle, String bContent, String bCategory, Date bDate, Date bModifyDate,
			char bStatus, char sStatus, String sAddress, int sStock) {
		super();
		this.bNo = bNo;
		this.mId = mId;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCategory = bCategory;
		this.bDate = bDate;
		this.bModifyDate = bModifyDate;
		this.bStatus = bStatus;
		this.sStatus = sStatus;
		this.sAddress = sAddress;
		this.sStock = sStock;
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

	public char getsStatus() {
		return sStatus;
	}

	public void setsStatus(char sStatus) {
		this.sStatus = sStatus;
	}

	public String getsAddress() {
		return sAddress;
	}

	public void setsAddress(String sAddress) {
		this.sAddress = sAddress;
	}

	public int getsStock() {
		return sStock;
	}

	public void setsStock(int sStock) {
		this.sStock = sStock;
	}

	@Override
	public String toString() {
		return "Shares [bNo=" + bNo + ", mId=" + mId + ", bTitle=" + bTitle + ", bContent=" + bContent + ", bCategory="
				+ bCategory + ", bDate=" + bDate + ", bModifyDate=" + bModifyDate + ", bStatus=" + bStatus
				+ ", sStatus=" + sStatus + ", sAddress=" + sAddress + ", sStock=" + sStock + "]";
	}

	
}
