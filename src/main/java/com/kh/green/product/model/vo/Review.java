package com.kh.green.product.model.vo;

import java.sql.Date;

public class Review {
	private int rNo;			// 후기 번호
	private int bNo;			// 게시판 번호
	private int pNo;			// 상품 번호
	private String fName;		// 상품 사진명
	private int oId;			// 주문 구분번호
	private String oNo;			// 주문 번호
	private String rContent;	// 후기 내용
	private int rStar;			// 별점	   (default = 5)
	private Date rDate;			// 후기등록 날짜(default = sysdate)	
	private String rStatus;		// 후기 삭제 여부(default = 'n')	
	private String mId;			// 후기 작성한 사용자 아이디
	private String nickName;	// 후기 작성한 사용자 닉네임
	
	public Review() {}
	
	// 상품 평균별점 내는 용도의 매개변수 생성자
	public Review(int rStar) {
		super();
		this.rStar = rStar;
	}

	public Review(int pNo, String oNo, String rContent, int rStar, String mId) {
		super();
		this.pNo = pNo;
		this.oNo = oNo;
		this.rContent = rContent;
		this.rStar = rStar;
		this.mId = mId;
	}

	public Review(int pNo, String oNo, String rContent, int rStar, Date rDate, String rStatus, String mId) {
		super();
		this.pNo = pNo;
		this.oNo = oNo;
		this.rContent = rContent;
		this.rStar = rStar;
		this.rDate = rDate;
		this.rStatus = rStatus;
		this.mId = mId;
	}

	public Review(int rNo, int bNo, int pNo, String fName, int oId, String oNo, String rContent, int rStar, Date rDate, String rStatus,
			String mId, String nickName) {
		super();
		this.rNo = rNo;
		this.bNo = bNo;
		this.pNo = pNo;
		this.fName = fName;
		this.oNo = oNo;
		this.rContent = rContent;
		this.rStar = rStar;
		this.rDate = rDate;
		this.rStatus = rStatus;
		this.mId = mId;
		this.nickName = nickName;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getfName() {
		return fName;
	}

	public void setfNo(String fName) {
		this.fName = fName;
	}

	public String getoNo() {
		return oNo;
	}

	public int getoId() {
		return oId;
	}

	public void setoId(int oId) {
		this.oId = oId;
	}

	public void setoNo(String oNo) {
		this.oNo = oNo;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public int getrStar() {
		return rStar;
	}

	public void setrStar(int rStar) {
		this.rStar = rStar;
	}

	public Date getrDate() {
		return rDate;
	}

	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "Review [rNo=" + rNo + ", bNo=" + bNo + ", pNo=" + pNo + ", fName=" + fName + ", oId=" + oId + ", oNo="
				+ oNo + ", rContent=" + rContent + ", rStar=" + rStar + ", rDate=" + rDate + ", rStatus=" + rStatus
				+ ", mId=" + mId + ", nickName=" + nickName + "]";
	}

}
