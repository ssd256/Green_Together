package com.kh.green.volunteer.model.vo;

public class Participation {
	private int bNo;				// 게시글 번호
	private String mId;				// 봉사활동 신청자
	private char vStatus;			// 봉사활동 신청여부
	private String bTitle;  		// 게시글 제목
	private String bLocation; 		// 게시글 장소
	private int vRecruitment;		// 모집인원
	private int vApplicant;			// 신청인원
	private String vDay;			// 모집끝날짜
	private char vRStatus;			// 봉사활동 후기여부
	
	public Participation() {}

	public Participation(int bNo, String mId, char vStatus, String bTitle, String bLocation, int vRecruitment,
			int vApplicant, String vDay) {
		super();
		this.bNo = bNo;
		this.mId = mId;
		this.vStatus = vStatus;
		this.bTitle = bTitle;
		this.bLocation = bLocation;
		this.vRecruitment = vRecruitment;
		this.vApplicant = vApplicant;
		this.vDay = vDay;
	}
	
	

	public Participation(int bNo, String mId, char vStatus, String bTitle, String bLocation, int vRecruitment,
			int vApplicant, String vDay, char vRStatus) {
		super();
		this.bNo = bNo;
		this.mId = mId;
		this.vStatus = vStatus;
		this.bTitle = bTitle;
		this.bLocation = bLocation;
		this.vRecruitment = vRecruitment;
		this.vApplicant = vApplicant;
		this.vDay = vDay;
		this.vRStatus = vRStatus;
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

	public char getvStatus() {
		return vStatus;
	}

	public void setvStatus(char vStatus) {
		this.vStatus = vStatus;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbLocation() {
		return bLocation;
	}

	public void setbLocation(String bLocation) {
		this.bLocation = bLocation;
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

	public String getvDay() {
		return vDay;
	}

	public void setvDay(String vDay) {
		this.vDay = vDay;
	}
	
	

	public char getvRStatus() {
		return vRStatus;
	}

	public void setvRStatus(char vRStatus) {
		this.vRStatus = vRStatus;
	}

	@Override
	public String toString() {
		return "Participation [bNo=" + bNo + ", mId=" + mId + ", vStatus=" + vStatus + ", bTitle=" + bTitle
				+ ", bLocation=" + bLocation + ", vRecruitment=" + vRecruitment + ", vApplicant=" + vApplicant
				+ ", vDay=" + vDay + ", vRStatus=" + vRStatus + "]";
	}
	
	
	

}
