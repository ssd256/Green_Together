package com.kh.green.product.model.vo;

public class OrderDetail {
   private int oDetailNum;
   private String mId;
   private int oPay;
   private int oCount;
   
   public OrderDetail() {}

   public OrderDetail(int oDetailNum, String mId, int oPay, int oCount) {
      super();
      this.oDetailNum = oDetailNum;
      this.mId = mId;
      this.oPay = oPay;
      this.oCount = oCount;
   }

   public int getoDetailNum() {
      return oDetailNum;
   }

   public void setoDetailNum(int oDetailNum) {
      this.oDetailNum = oDetailNum;
   }

   public String getmId() {
      return mId;
   }

   public void setmId(String mId) {
      this.mId = mId;
   }

   public int getoPay() {
      return oPay;
   }

   public void setoPay(int oPay) {
      this.oPay = oPay;
   }

   public int getoCount() {
      return oCount;
   }

   public void setoCount(int oCount) {
      this.oCount = oCount;
   }

   @Override
   public String toString() {
      return "OrderDetail [oDetailNum=" + oDetailNum + ", mId=" + mId + ", oPay=" + oPay + ", oCount=" + oCount + "]";
   }
   
}