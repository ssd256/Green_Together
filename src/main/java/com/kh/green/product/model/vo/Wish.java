package com.kh.green.product.model.vo;

public class Wish {
	private int wNo;
	private int pNo;
	private int bNo;
	private String mId;
	private int cCount;
	private int cPrice;
	private String fName;
	private String pName;
	private String wStatus;
	
	public Wish() {}

	public Wish(int pNo, int bNo, String mId, int cCount, int cPrice, String fName, String pName) {
		super();
		this.pNo = pNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cCount = cCount;
		this.cPrice = cPrice;
		this.fName = fName;
		this.pName = pName;
	}

	public Wish(int wNo, int pNo, int bNo, String mId, int cCount, int cPrice, String fName, String pName,
			String wStatus) {
		super();
		this.wNo = wNo;
		this.pNo = pNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cCount = cCount;
		this.cPrice = cPrice;
		this.fName = fName;
		this.pName = pName;
		this.wStatus = wStatus;
	}

	public int getwNo() {
		return wNo;
	}

	public void setwNo(int wNo) {
		this.wNo = wNo;
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

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getcCount() {
		return cCount;
	}

	public void setcCount(int cCount) {
		this.cCount = cCount;
	}

	public int getcPrice() {
		return cPrice;
	}

	public void setcPrice(int cPrice) {
		this.cPrice = cPrice;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getwStatus() {
		return wStatus;
	}

	public void setwStatus(String wStatus) {
		this.wStatus = wStatus;
	}

	@Override
	public String toString() {
		return "Wish [wNo=" + wNo + ", pNo=" + pNo + ", bNo=" + bNo + ", mId=" + mId + ", cCount=" + cCount
				+ ", cPrice=" + cPrice + ", fName=" + fName + ", pName=" + pName + ", wStatus=" + wStatus + "]";
	}
	
}
