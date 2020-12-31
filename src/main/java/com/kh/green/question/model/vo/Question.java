package com.kh.green.question.model.vo;

import java.sql.Date;

public class Question {
	private int bNo;			// 게시글번호
	private String qCategory;	// 문의 내용에 관한 카테고리
	private String mId;			// 작성자	= admin
	private String mNickname;  // 닉네임
	private String bTitle;		// 제목  --> 질문
	private String bContent;	// 내용  --> 답변 
	private String bCategory;	// 자주묻는질문,문의사항게시판 카테고리
	private Date bDate;			// 작성일자
	private Date bModifyDate;    // 수정일자
	private String bStatus;		// 삭제여부
	private int recnt; 			// ** 해당게시글 댓글의 수
	
	//	이전글, 다음글 영역 vo
	private int prevNo; 				// 이전글 번호
	private String prevTitle;		// 이전글 제목
	private String prevCate;			// 이전글 카테고리
	private String prevNickname; 	// 이전글 닉네임
	private Date prevDate; 			// 이전글 작성일
	
	private int nextNo; 			//다음글 번호 	
	private String nextTitle;		// 다음글 제목
	private String nextCate;		// 다음글 카테고리
	private String nextNickname; 	// 다음글 닉네임
	private Date nextDate; 			// 다음글 작성일
	
	public Question() {}

	public Question(int bNo, String qCategory, String mId, String mNickname, String bTitle, String bContent,
			String bCategory, Date bDate, Date bModifyDate, String bStatus, int recnt, int prevNo, String prevTitle,
			String prevCate, String prevNickname, Date prevDate, int nextNo, String nextTitle, String nextCate,
			String nextNickname, Date nextDate) {
		super();
		this.bNo = bNo;
		this.qCategory = qCategory;
		this.mId = mId;
		this.mNickname = mNickname;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCategory = bCategory;
		this.bDate = bDate;
		this.bModifyDate = bModifyDate;
		this.bStatus = bStatus;
		this.recnt = recnt;
		
		this.prevNo = prevNo;
		this.prevTitle = prevTitle;
		this.prevCate = prevCate;
		this.prevNickname = prevNickname;
		this.prevDate = prevDate;
		this.nextNo = nextNo;
		this.nextTitle = nextTitle;
		this.nextCate = nextCate;
		this.nextNickname = nextNickname;
		this.nextDate = nextDate;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getqCategory() {
		return qCategory;
	}

	public void setqCategory(String qCategory) {
		this.qCategory = qCategory;
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

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	public int getRecnt() {
		return recnt;
	}

	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}

	public int getPrevNo() {
		return prevNo;
	}

	public void setPreNo(int prevNo) {
		this.prevNo = prevNo;
	}

	public String getPrevTitle() {
		return prevTitle;
	}

	public void setPrevTitle(String prevTitle) {
		this.prevTitle = prevTitle;
	}

	public String getPrevCate() {
		return prevCate;
	}

	public void setPrevCate(String prevCate) {
		this.prevCate = prevCate;
	}

	public String getPrevNickname() {
		return prevNickname;
	}

	public void setPrevNickname(String prevNickname) {
		this.prevNickname = prevNickname;
	}

	public Date getPrevDate() {
		return prevDate;
	}

	public void setPrevDate(Date prevDate) {
		this.prevDate = prevDate;
	}

	public int getNextNo() {
		return nextNo;
	}

	public void setNextNo(int nextNo) {
		this.nextNo = nextNo;
	}

	public String getNextTitle() {
		return nextTitle;
	}

	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}

	public String getNextCate() {
		return nextCate;
	}

	public void setNextCate(String nextCate) {
		this.nextCate = nextCate;
	}

	public String getNextNickname() {
		return nextNickname;
	}

	public void setNextNickname(String nextNickname) {
		this.nextNickname = nextNickname;
	}

	public Date getNextDate() {
		return nextDate;
	}

	public void setNextDate(Date nextDate) {
		this.nextDate = nextDate;
	}

	@Override
	public String toString() {
		return "Question [bNo=" + bNo + ", qCategory=" + qCategory + ", mId=" + mId + ", mNickname=" + mNickname
				+ ", bTitle=" + bTitle + ", bContent=" + bContent + ", bCategory=" + bCategory + ", bDate=" + bDate
				+ ", bModifyDate=" + bModifyDate + ", bStatus=" + bStatus + ", recnt=" + recnt + ", prevNo=" + prevNo
				+ ", prevTitle=" + prevTitle + ", prevCate=" + prevCate + ", prevNickname=" + prevNickname
				+ ", prevDate=" + prevDate + ", nextNo=" + nextNo + ", nextTitle=" + nextTitle + ", nextCate="
				+ nextCate + ", nextNickname=" + nextNickname + ", nextDate=" + nextDate + "]";
	}

	
}
