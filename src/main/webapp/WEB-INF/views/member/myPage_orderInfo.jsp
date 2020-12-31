<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_orderInfo.css" type="text/css">
</head>
<body>
   <h1 id="orderInfo">주문 상세 조회</h1>	
   <hr id="order_hr">
   
   <script>
		$(function(){
			var delivery = document.getElementsByClassName('delivery');
			var orderDelivery = document.getElementById("${ order.orderDelivery }");
			
			for(var i = 0; i < delivery.length; i++){
					if(orderDelivery == delivery[i]){
					delivery[i].style.fontWeight ="bold";
					delivery[i].style.color = "blue";
					console.log(delivery[i]);
					}
			}
		})    
    </script>
    
       <table id="orderInfo_table">
           <tr>
               <th>주문 번호</th>
               <td>${ order.oNo }</td>
           </tr>
           <tr>
           		<th></th>
           		<td><img src="${pageContext.request.contextPath}/resources/images/product_ready.png"></td>
           		<td><img src="${pageContext.request.contextPath}/resources/images/delivery_ready.png"></td>
           		<td><img src="${pageContext.request.contextPath}/resources/images/delivery.png"></td>
           		<td><img src="${pageContext.request.contextPath}/resources/images/complete.png"></td>
           </tr>
           <tr>
               <th>배송 상태</th>
               <td><span id="상품준비중" class="delivery">상품 준비중</span></td>
               <td><span id="배송준비중" class="delivery">배송 준비중</span></td>
               <td><span id="배송중" class="delivery">배송중</span></td>
               <td><span id="배송완료" class="delivery">배송 완료</span></td>
               <td><input type="hidden" id="orderDelivery" value="${ order.orderDelivery }"></td>
           </tr>
           <tr>
               <th>상품명</th>
               <td colspan="3">${ order.pName }</td>
           </tr>
           <tr>
               <th>주문자명</th>
               <td colspan="3">${ order.recipient }</td>
           </tr>
			<tr>
			<th>배송 주소</th>
			<td colspan="3">${ order.orderAddr }</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td colspan="3">${ order.reciPhone }</td>
			</tr>
			<tr>
				<th>배송메시지</th>
				<td colspan="3">${ order.orderMsg }</td>
			</tr>
			<tr>
				<th>결제 금액</th>
				<td colspan="3"><fmt:formatNumber value="${ order.orderPay }" pattern="###,###,###"/>원</td>
			</tr>
       </table>
       
       <div id="btn_box">
           <input type="button" class="btn" id="okayBtn" value="확 인" onclick="self.close();">
       </div>
    
</body>
</html>