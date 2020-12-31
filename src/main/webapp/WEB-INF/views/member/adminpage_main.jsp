<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/adminpage_main.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
	<%@ include file="../common/admin-aside.jsp"%>
		<section>
        <p id="sectionTitle">주문 내역 & 배송 관리<p>
    	<hr id="producthr">
    	
    	<div class="productDiv">
		<c:if test="${ empty olist }">
			주문내역이 비었습니다.  
		</c:if>
		
		
    	<form id="product_info">
	    	<c:forEach var="o" items="${ olist }" varStatus="s">	
			
				<c:if test="${ !(empty olist) }">
			    	<table class="product_table">
			    		<c:if test="${ s.count == 1}">
						<tr>
							<th></th>
							<th>주문번호</th>
							<th colspan="2">제품 정보</th> 
							<th>배송 주소</th>
							<th>주문 상태</th>
							<th>배송 상태</th>
						</tr>
						</c:if>
						<tr>
							<td><input type="hidden" class="oId_${ s.count }" name="oId" value="${ o.oId }"></td>
							<td><input type="hidden" class="oNo_${ s.count }" name="orderNo" value="${ o.oNo }">${ o.oNo }</td>
							<td class="img_area">
 								<img src="resources/product_uploadFiles/${o.fName}" alt="액박">
							</td>
							<td class="product_name">${ o.pName }</td>
							<td class="order_address">${ o.orderAddr }</td>
							<td class="order_status">
								<input type="text" name="orderState" class="orderState_${ s.count }" value="${ o.orderState }" disabled="disabled">
								<select name="statusSelect" class="status_select_${ s.count }">
								 	<option value="결제완료">결제완료</option>
								 	<option value="결제취소">결제취소</option>
								 </select>
							<br>
								 <input type="button" class="order_manage_${ s.count }" name="orderBtn" value="주문관리" onclick="orderManage(${ s.count });"><br>
								 <input type="button" name="cancelBtn" class="order_cancel_${ s.count }" value="취 소">
							</td>
							<td class="order_delivery">
								<input type="text" name="orderDelivery" class="orderDelivery_${ s.count }" value="${ o.orderDelivery }" disabled="disabled">
								<select name="deliverySelect" class="delivery_select_${ s.count }">
								 	<option value="상품준비중">상품준비중</option>
								 	<option value="배송준비중">배송준비중</option>
								 	<option value="배송중">배송중</option>
								 	<option value="배송완료">배송완료</option>
								 </select>
							
							<br>
								<input type="button" class="delivery_manage_${ s.count }" name="deliveryBtn" value="배송관리" onclick="deliveryManage(${ s.count });"><br>
								<input type="button" name="cancelBtn" class="delivery_cancel_${ s.count }" value="취 소">
							</td>
						</tr>
					</table>
					</c:if>
				</c:forEach>
			</form>
    	</div>
    	
    	<!-- 이전 -->
	    <div class="pagination">
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prev_btn"> < </a>
	    	</c:if>
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="adminPage.me">        
    				<c:param name="page" value="${ pi.currentPage - 1 }" />
 	          	</c:url>
          		<a href="${ before }" class="prev_btn"> < </a>
            </c:if>
	    	
    		<!-- 페이지 -->
    		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
    			<c:if test="${ p eq pi.currentPage }">
    				<b><a class="page no">${ p }</a></b>
    			</c:if>
    			
    			<c:if test="${ p ne pi.currentPage }">
    				<c:url var="pagination" value="adminPage.me">
    					<c:param name="page" value="${ p }"/>
					</c:url>	
					<a href="${ pagination }" class="page no">${ p }</a>
				</c:if>
    		</c:forEach>		
    		
    		<!-- 다음 -->
    		<c:if test="${ pi.currentPage >= pi.maxPage }">
    			<a class="next_btn"> > </a>
    		</c:if>
    		<c:if test="${ pi.currentPage < pi.maxPage }">
    			<c:url var="after" value="adminPage.me">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a href="${ after }" class="next_btn"> > </a>
    		</c:if>
		</div>
		
    </section>
    
    <script>
	    $(document).ready(function(){
	    	$('select[name="statusSelect"]').hide();
	    	$('select[name="deliverySelect"]').hide();
	    	$('input[name="cancelBtn"]').hide();
	    });
	    
	    
		// 페이지 로딩후 웹소켓 전달
	    setTimeout("delivery()", 200);
		function delivery(){
			let delivery= "${delivery}";
		    let sendId= "${sendId}";
		        
	    	if(delivery == "delivery" && socket){
   				let socketMsg = "delivery," + sendId+","+ "${bNo}";
   				socket.send(socketMsg);
	    	}
	    };  
	    
	    
    	function orderManage(c){
			$('.orderState_' + c).hide();		// 주문 상태 text
  			$('.status_select_' + c).show();	// 주문 상태 선택 select
  			$('.order_manage_' + c).val('변 경');	// 주문관리 버튼
  			$('.delivery_manage_' + c).attr('disabled', 'disabled');	// 배송관리 버튼
 			
			$('.order_manage_' + c).click(function(){
				var oNo = $('.oNo_' + c).val();
   				var order = $('.status_select_' + c + ' option:selected').val();
   				swal({
   					text: '주문상태를 변경하시겠습니까?',
   					icon: 'info',
   					buttons: ["아니오", "예"],
   					closeOnClickOutside: false,
    				}).then((ok) => {
    					if(ok){
			    			$('.status_select_' + c).hide();
		    				$('.orderState_' + c).show();
		    				$('.delivery_manage_' + c).removeAttr('disabled');
		    				$('.order_manage_' + c).val('주문관리');
	    					location.href = 'adorderChange.me?oNo=' + oNo + '&order=' + order;							
    					} 
    				$('.status_select_' + c).hide();
    				$('.orderState_' + c).show();
    				$('.delivery_manage_' + c).removeAttr('disabled');
    				$('.order_manage_' + c).val('주문관리');
    				
   				})
			})
    	};
    	
    	
    	function deliveryManage(c){
			$('.orderDelivery_' + c).hide();	
   			$('.delivery_select_' + c).show();
   			$('.delivery_manage_' + c).val('변 경');
   			$('.order_manage_' + c).attr('disabled', 'disabled');
     			
    			$('.delivery_manage_' + c).click(function(){
   					var oNo = $('.oNo_' + c).val();
   					var oId = $('.oId_' + c).val();
    				var delivery = $('.delivery_select_' + c + ' option:selected').val();
    				swal({
    					text: '배송상태를 변경하시겠습니까?',
    					icon: 'info',
    					buttons: ["아니오", "예"],
    					closeOnClickOutside: false,
	    				}).then((ok) => {
	    					if(ok){
	    	        			$('.delivery_select_' + c).hide();
	    	    				$('.orderDelivery_' + c).show();
	    	    				$('.delivery_manage_' + c).val('배송관리');
  			    					location.href = 'addeliveryChange.me?oNo=' + oNo + '&delivery=' + delivery + '&oId=' + oId;							
		    				}
    					$('.delivery_select_' + c).hide();
   	    				$('.orderDelivery_' + c).show();
   	    				$('.order_manage_' + c).removeAttr('disabled');
   	    				$('.delivery_manage_' + c).val('배송관리');
    				})
    			})
    	};
    
    </script>
    </main>
    <img id="top" src="resources/images/top_button2.png"/>
    <%@ include file="../common/footer.jsp"%>		
</body>
</html>