package com.kh.green.common;

public class Files {
	private int fNum;
	private int bNo;
	private String fPath;
	private String fOriginName;
	private String fChangeName;
	private int fLevel;
	private String fStatus;
	
	public Files() {}

	public Files(int bNo, String fChangeName) {
		super();
		this.bNo = bNo;
		this.fChangeName = fChangeName;
	}

	public Files(int fNum, int bNo, String fPath, String fOriginName, String fChangeName, int fLevel, String fStatus) {
		super();
		this.fNum = fNum;
		this.bNo = bNo;
		this.fPath = fPath;
		this.fOriginName = fOriginName;
		this.fChangeName = fChangeName;
		this.fLevel = fLevel;
		this.fStatus = fStatus;
	}

	public int getfNum() {
		return fNum;
	}

	public void setfNum(int fNum) {
		this.fNum = fNum;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public String getfPath() {
		return fPath;
	}

	public void setfPath(String fPath) {
		this.fPath = fPath;
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

	public String getfStatus() {
		return fStatus;
	}

	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}

	@Override
	public String toString() {
		return "File [fNum=" + fNum + ", bNo=" + bNo + ", fPath=" + fPath + ", fOriginName=" + fOriginName
				+ ", fChangeName=" + fChangeName + ", fLevel=" + fLevel + ", fStatus=" + fStatus + "]";
	}
	
	
}
