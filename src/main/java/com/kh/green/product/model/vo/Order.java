package com.kh.green.product.model.vo;

import java.sql.Date;

public class Order {
   private int oId; //주문 구분번호
   private String oNo; //주문번호
   private String orderId;//주문자 아이디
   private int bNo; // 게시판 번호
   private int pNo; // 상품번호
   private int cNo; // 장바구니 번호
   private String fName; // 상품사진
   private String pName; // 상품명
   private int orderCount; //수량
   private String recipient; //수령인
   private String reciPhone; //수령인 연락처
   private String orderAddr; //배송지
   private int orderPay; //결제금액
   private String orderWay;//결제 방법
   private String orderMsg; //배송 요청사항
   private Date orderDate;//결제날짜
   private String orderState; //주문상태
   private String orderDelivery; //배송상태
   private int pCount; // 상품 재고수량
   private String imp_uid;
   
   public Order() {} //기본생성자
   
   
   public Order(String pName) {
	super();
	this.pName = pName;
   }

   public Order(String orderId, String pName) {
      super();
      this.orderId = orderId;
      this.pName = pName;
   }

   public Order(String orderId, int pNo, String pName, int orderCount, String recipient, String reciPhone, String orderAddr,
         int orderPay, String orderWay, String orderMsg) {
      super();
      this.orderId = orderId;
      this.pNo = pNo;
      this.pName = pName;
      this.orderCount = orderCount;
      this.recipient = recipient;
      this.reciPhone = reciPhone;
      this.orderAddr = orderAddr;
      this.orderPay = orderPay;
      this.orderWay = orderWay;
      this.orderMsg = orderMsg;
   }

   public Order(int oId, String oNo, String orderId, int bNo, int pNo, int cNo, String fName, String pName, int orderCount, String recipient, String reciPhone,
         String orderAddr, int orderPay, String orderWay, String orderMsg, Date orderDate, String orderState,
         String orderDelivery, int pCount, String imp_uid) {
      super();
      this.oId = oId;
      this.oNo = oNo;
      this.orderId = orderId;
      this.bNo = bNo;
      this.pNo = pNo;
      this.cNo = cNo;
      this.fName = fName;
      this.pName = pName;
      this.orderCount = orderCount;
      this.recipient = recipient;
      this.reciPhone = reciPhone;
      this.orderAddr = orderAddr;
      this.orderPay = orderPay;
      this.orderWay = orderWay;
      this.orderMsg = orderMsg;
      this.orderDate = orderDate;
      this.orderState = orderState;
      this.orderDelivery = orderDelivery;
      this.pCount = pCount;
      this.imp_uid = imp_uid;
   }
   
   public int getoId() {
	   return oId;
   }

   public void setoId(int oId) {
	   this.oId = oId;
   }

   public String getoNo() {
      return oNo;
   }

   public void setoNo(String oNo) {
      this.oNo = oNo;
   }

   public String getOrderId() {
      return orderId;
   }

   public void setOrderId(String orderId) {
      this.orderId = orderId;
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
   
	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
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

   public int getOrderCount() {
      return orderCount;
   }

   public void setOrderCount(int orderCount) {
      this.orderCount = orderCount;
   }

   public String getRecipient() {
      return recipient;
   }

   public void setRecipient(String recipient) {
      this.recipient = recipient;
   }

   public String getReciPhone() {
      return reciPhone;
   }

   public void setReciPhone(String reciPhone) {
      this.reciPhone = reciPhone;
   }

   public String getOrderAddr() {
      return orderAddr;
   }

   public void setOrderAddr(String orderAddr) {
      this.orderAddr = orderAddr;
   }

   public int getOrderPay() {
      return orderPay;
   }

   public void setOrderPay(int orderPay) {
      this.orderPay = orderPay;
   }

   public String getOrderWay() {
      return orderWay;
   }

   public void setOrderWay(String orderWay) {
      this.orderWay = orderWay;
   }

   public String getOrderMsg() {
      return orderMsg;
   }

   public void setOrderMsg(String orderMsg) {
      this.orderMsg = orderMsg;
   }

   public Date getOrderDate() {
      return orderDate;
   }

   public void setOrderDate(Date orderDate) {
      this.orderDate = orderDate;
   }

   public String getOrderState() {
      return orderState;
   }

   public void setOrderState(String orderState) {
      this.orderState = orderState;
   }

   public String getOrderDelivery() {
      return orderDelivery;
   }

   public void setOrderDelivery(String orderDelivery) {
      this.orderDelivery = orderDelivery;
   }

   public int getpCount() {
	   return pCount;
	}
	
	public void setpCount(int pCount) {
		this.pCount = pCount;
	}
	
	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}


	@Override
	public String toString() {
		return "Order [oId=" + oId + ", oNo=" + oNo + ", orderId=" + orderId + ", bNo=" + bNo + ", pNo=" + pNo
				+ ", cNo=" + cNo + ", fName=" + fName + ", pName=" + pName + ", orderCount=" + orderCount
				+ ", recipient=" + recipient + ", reciPhone=" + reciPhone + ", orderAddr=" + orderAddr + ", orderPay="
				+ orderPay + ", orderWay=" + orderWay + ", orderMsg=" + orderMsg + ", orderDate=" + orderDate
				+ ", orderState=" + orderState + ", orderDelivery=" + orderDelivery + ", pCount=" + pCount
				+ ", imp_uid=" + imp_uid + "]";
	}

}
