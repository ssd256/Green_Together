package com.kh.green.product.model.vo;

import java.sql.Date;

public class Product {
	private int pNo;			// 상품번호
	private int bNo;			// 게시글번호
	private int fNum;			// 파일번호
	private String mId;			// 작성자	= 'admin'
	private String pCategory;	// 상품 카테고리
	private String pName;		// 상품명 & 게시글 제목
	private int pPrice;			// 상품가격
	private int pCount;			// 재고수량
	private String pComment;	// 상품설명 & 게시글 내용
	private String fOriginName;	// 원본파일명
	private String fChangeName;	// 수정파일명
	private int fLevel;			// 썸네일, 내용사진 구분
	private Date bDate;			// 상품등록 날짜
	private Date bModifyDate;	// 상품수정 날짜
	private String bStatus;		// 상품 삭제 여부(default = 'n')

	public Product() {}
	
	public Product(int pNo, int bNo, String pCategory, String pName, int pPrice, int pCount) {
		super();
		this.pNo = pNo;
		this.bNo = bNo;
		this.pCategory = pCategory;
		this.pName = pName;
		this.pPrice = pPrice;
		this.pCount = pCount;
	}
	
	public Product(int pNo, int bNo, int fNum, String pCategory, String pName, int pPrice, int pCount) {
		super();
		this.pNo = pNo;
		this.bNo = bNo;
		this.fNum = fNum;
		this.pCategory = pCategory;
		this.pName = pName;
		this.pPrice = pPrice;
		this.pCount = pCount;
	}

	public Product(int pNo, int bNo, String pCategory, String pName, int pPrice, int pCount,
					String fOriginName, String fChangeName, int fLevel) {
		super();
		this.pNo = pNo;
		this.bNo = bNo;
		this.pCategory = pCategory;
		this.pName = pName;
		this.pPrice = pPrice;
		this.pCount = pCount;
		this.fOriginName = fOriginName;
		this.fChangeName = fChangeName;
		this.fLevel = fLevel;
	}

	public Product(int pNo, int bNo, String mId, String pCategory, String pName, int pPrice, int pCount, String 
				   pComment, String fOriginName, String fChangeName, int fLevel, Date bDate, Date bModifyDate, String bStatus) {
		super();
		this.pNo = pNo;
		this.bNo = bNo;
		this.mId = mId;
		this.pCategory = pCategory;
		this.pName = pName;
		this.pPrice = pPrice;
		this.pCount = pCount;
		this.pComment = pComment;
		this.fOriginName = fOriginName;
		this.fChangeName = fChangeName;
		this.fLevel = fLevel;
		this.bDate = bDate;
		this.bModifyDate = bModifyDate;
		this.bStatus = bStatus;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	
	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public int getfNum() {
		return fNum;
	}

	public void setfNum(int fNum) {
		this.fNum = fNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getpCategory() {
		return pCategory;
	}

	public void setpCategory(String pCategory) {
		this.pCategory = pCategory;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public int getpCount() {
		return pCount;
	}

	public void setpCount(int pCount) {
		this.pCount = pCount;
	}

	public String getpComment() {
		return pComment;
	}

	public void setpComment(String pComment) {
		this.pComment = pComment;
	}

	public String getfOriginName() {
		return fOriginName;
	}

	public void setfOriginName(String fOriginName) {
		this.fOriginName = fOriginName;
	}

	public String getfChangeName() {
		return fChangeName;
	}

	public void setfChangeName(String fChangeName) {
		this.fChangeName = fChangeName;
	}

	public int getfLevel() {
		return fLevel;
	}

	public void setfLevel(int fLevel) {
		this.fLevel = fLevel;
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

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	@Override
	public String toString() {
		return "Product [pNo=" + pNo + ", bNo=" + bNo + ", fNum=" + fNum + ", mId=" + mId + ", pCategory=" + pCategory
				+ ", pName=" + pName + ", pPrice=" + pPrice + ", pCount=" + pCount + ", pComment=" + pComment
				+ ", fOriginName=" + fOriginName + ", fChangeName=" + fChangeName + ", fLevel=" + fLevel + ", bDate="
				+ bDate + ", bModifyDate=" + bModifyDate + ", bStatus=" + bStatus + "]";
	}

}
