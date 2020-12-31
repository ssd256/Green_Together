package com.kh.green.shares.model.vo;

public class Apply {
	private int bNo;
	private String sApplicant;
	private String ApplyInfo;
	
	public Apply() {}

	public Apply(int bNo, String sApplicant, String applyInfo) {
		super();
		this.bNo = bNo;
		this.sApplicant = sApplicant;
		ApplyInfo = applyInfo;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getsApplicant() {
		return sApplicant;
	}

	public void setsApplicant(String sApplicant) {
		this.sApplicant = sApplicant;
	}

	public String getApplyInfo() {
		return ApplyInfo;
	}

	public void setApplyInfo(String applyInfo) {
		ApplyInfo = applyInfo;
	}

	@Override
	public String toString() {
		return "Apply [bNo=" + bNo + ", sApplicant=" + sApplicant + ", ApplyInfo=" + ApplyInfo + "]";
	}
	
	
}
