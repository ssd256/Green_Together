package com.kh.green.product.model.vo;

public class Cart {
	private int cNo;		// 장바구니 번호
	private int pNo;		// 상품 번호
	private int bNo;		// 게시글 번호
	private String mId;		// 사용자 아이디
	private int cCount;		// 장바구니에 담은 상품 수량
	private int cPrice;		// 상품 가격
	private String fName;	// 장바구니에 담은 상품 사진명
	private String pName;	// 장바구니에 담은 상품명
	private String cStatus;	// 장바구니에 담은 상품 삭제유무(default = 'N')
	
	public Cart() {}

	public Cart(int pNo, int bNo, String mId, int cCount, int cPrice, String fName, String pName) {
		super();
		this.pNo = pNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cCount = cCount;
		this.cPrice = cPrice;
		this.fName = fName;
		this.pName = pName;
	}
	
	public Cart(int cNo, int pNo, int bNo, String mId, int cCount, int cPrice, String fName, String pName, String cStatus) {
		super();
		this.cNo = cNo;
		this.pNo = pNo;
		this.bNo = bNo;
		this.mId = mId;
		this.cCount = cCount;
		this.cPrice = cPrice;
		this.fName = fName;
		this.pName = pName;
		this.cStatus = cStatus;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
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
	
	public String getcStatus() {
		return cStatus;
	}

	public void setcStatus(String cStatus) {
		this.cStatus = cStatus;
	}

	@Override
	public String toString() {
		return "Cart [cNo=" + cNo + ", pNo=" + pNo + ", bNo=" + bNo + ", mId=" + mId + ", cCount=" + cCount
				+ ", cPrice=" + cPrice + ", fName=" + fName + ", pName=" + pName + ", cStatus=" + cStatus + "]";
	}

}
