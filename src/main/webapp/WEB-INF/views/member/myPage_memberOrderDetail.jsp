<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_memberOrderDetail.css" type="text/css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
    <main>
    <%@ include file="../common/member-aside.jsp"%>
	 <section style="margin: 0px;">
	 <h1 id="orderInfo">구매한 물품 목록</h1><br>
	 
	 <c:if test="${ empty olist }">
	 	구매한 상품이 없습니다.
	 </c:if>
	 
	 <c:if test="${ !(empty olist) }">
	 <c:forEach var="o" items="${ olist }" varStatus="s">
		 <table class="order_table">
		 	<tr>
		 		<th></th>
		 		<th>구매일자</th>
		 		<th>주문번호</th>
		 		<th>상품명</th>
		 		<th></th>
		 		<th>가격</th>
		 		<th>배송상태</th>
		 		<th></th>
		 	</tr>
		 	<tr>
		 		<td></td>
		 		<td>${ o.orderDate }</td>
		 		<td>${ o.oNo }</td>
		 		<td>${ o.pName }</td>
		 		<td></td>
		 		<td><fmt:formatNumber value="${ o.orderPay }" pattern="###,###,###"/>원</td>
		 		<td><input type="hidden" class="delivery_status_${ o.oNo }" name="orderDelivery" value="${ o.orderDelivery }">${ o.orderDelivery }
		 			<input type="hidden" class="order_State_${ o.oNo }" name="orderState" value="${ o.orderState }">
		 			<input type="hidden" class="order_delivery_${ o.oNo }" name="order_delivery" value="">
		 		</td>
		 		<td>
		 		<c:if test="${ o.orderState == '구매확정' }">
		 			<input type="button" id="detailBtn_${ o.oNo }" class="detailBtn" value="상세조회" onclick="orderInfoPop(${s.count});"><br>
		 			<input type="button" id="reviewBtn_${ o.oNo }" class="reviewBtn_${ s.count }" name="reviewBtn" value="후기작성" onclick="reviewPop(${s.count});">
		 		</c:if>
		 		<c:if test="${ o.orderState != '구매확정' and o.orderDelivery == '배송완료'}">
		 			<input type="button" id="detailBtn_${ o.oNo }" class="detailBtn" value="상세조회" onclick="orderInfoPop(${s.count});"><br>
		 			<input type="button" id="cancelBtn_${ o.oNo }" class="cancelBtn" value="주문취소" name="cancelBtn" onclick="cancelOrder('${o.oNo}', ${o.orderCount}, ${ o.pNo }, ${o.oId});"><br>
		 			<input type="button" id="successBtn_${ o.oNo }" class="successBtn_${ s.count }" name="successBtn" value="구매확정" onclick="orderSuccess_A('${o.oNo}', ${o.orderCount}, ${ o.pNo });">
		 		</c:if>
		 		<c:if test="${ o.orderState != '구매확정' and o.orderDelivery != '배송완료'}">
		 			<input type="button" id="detailBtn_${ o.oNo }" class="detailBtn" value="상세조회" onclick="orderInfoPop(${s.count});"><br>
		 			<input type="button" id="cancelBtn_${ o.oNo }" class="cancelBtn" value="주문취소" name="cancelBtn" onclick="cancelOrder('${o.oNo}', ${o.orderCount}, ${ o.pNo }, ${o.oId});"><br>
		 			<input type="button" id="successBtn_${ o.oNo }" class="successBtn_${ s.count }" name="successBtn" value="구매확정" onclick="orderSuccess_B('${o.oNo}', ${o.orderCount}, ${ o.pNo }, ${o.oId});">
		 		</c:if>
		 			<input type="hidden" class="oId_${ s.count }" value="${ o.oId }">
		 			<input type="hidden" class="oNo_${ s.count }" value="${ o.oNo }">
		 			<input type="hidden" class="pName_${ s.count }" value="${ o.pName }">
		 			<input type="hidden" class="price_${ s.count }" value="${ o.orderPay }">
		 		</td>
		 	</tr>
		 </table>
	 </c:forEach>
	 </c:if>
	 
	 <!-- 이전 -->
	    <div class="pagination">
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prev_btn"> < </a>
	    	</c:if>
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="memberOrderDetail.me">        
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
    				<c:url var="pagination" value="memberOrderDetail.me">
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
    			<c:url var="after" value="memberOrderDetail.me">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a href="${ after }" class="next_btn"> > </a>
    		</c:if>
		</div>
		
	 </section>
	</main>
    <%@ include file="../common/footer.jsp"%>

	<script>
		var myWindow;	// 자식창 : 후기 작성 창
		
		
		function orderInfoPop(a){
			var oId = $('.oId_' + a).val();
			
			var url = "orderInfoView.me?oId=" + oId;
			var name = "주문상세조회";
			var option = "width=750, height=800, top=110, left=480, location=no";
			window.open(url, name, option);
		};
	
		
		function cancelOrder(a, c, p, Id){
			swal({
				text: '해당 상품의 주문을 취소하시겠습니까?', 
				icon: 'info',
				buttons: ["아니오", "예"],
				dangerMode: true,
				closeOnClickOutside: false,
			}).then((ok) => {
				 if(ok){
					$.ajax({
						url: 'ordercancel.po',
						data: {'oNo': a, 'orderCount': c, 'pNo': p, 'oId': Id},
						success: function(data){
							if(data > 0){
								swal({
									text: '해당 상품의 주문이 취소되었습니다.',
									closeOnClickOutside: false,
								}).then((ok) => {
									if(ok){
										if(socket){
						    				let socketMsg = "ordercancel," + "admin" +","+ p;
						    				socket.send(socketMsg);
						    			}
										location.href = 'memberOrderDetail.me';
										
									}
								})
							}
						},
						error: function(data){
							swal('', '주문 취소에 실패하였습니다.', '');
						}
					})
				} else {
					swal.close();
				} 
			})
		};	 
		
		
		function orderSuccess_A(a, c, p){
			swal({
				text: '해당상품을 구매확정 하시겠습니까?', 
				icon: 'info',
				buttons: ["아니오", "예"],
				dangerMode: true,
				closeOnClickOutside: false,
			}).then((ok) => {
				 if(ok){
					$.ajax({
						url: 'ordersuccess_a.po',
						data: {'oNo': a, 'orderCount': c, 'pNo': p},
						success: function(data){
							 swal({
								text: '해당 상품의 구매가 확정되었습니다.',
								closeOnClickOutside: false,
							}).then((ok) => {
								if(ok){
									location.href = 'memberOrderDetail.me';
								}
							}) 
						},
						error: function(data){
							swal('', '구매 확정에 실패하였습니다.', '');
						}
					})
				} else {
					swal.close();
				} 
			})	
		}
		
		
		function orderSuccess_B(a, c, p){
			swal({
				text: '배송 미완료 상품입니다. 구매확정을 하시겠습니까?', 
				icon: 'info',
				buttons: ["아니오", "예"],
				dangerMode: true,
				closeOnClickOutside: false,
			}).then((ok) => {
				$('.order_delivery_' + a).val('배송완료');
				 if(ok){
					$.ajax({
						url: 'ordersuccess_b.po',
						data: {'oNo': a, 
							   'orderCount': c, 
							   'pNo': p, 
							   'delivery' : $('.order_delivery_' + a).val()},
						success: function(data){
							 swal({
								text: '해당 상품의 구매가 확정되었습니다.',
								closeOnClickOutside: false,
							}).then((ok) => {
								if(ok){
									location.href = 'memberOrderDetail.me';
								}
							}) 
						},
						error: function(data){
							swal('', '구매 확정에 실패하였습니다.', '');
						}
					})
				} else {
					swal.close();
				} 
			})	
		}		
			
	
		function reviewPop(a){
			var oId = $('.oId_' + a).val();
			var oNo = $('.oNo_' + a).val();
			
			$.ajax({
	        	url: 'reviewchk.po',
	        	data: {'oId':oId, 'oNo': oNo},
	        	success: function(data){
	        		if(data > 0){
	        			swal('', '이미 후기를 작성하였습니다.', '');
	        		} else {
	        			var url = "reviewInsertForm.me?oId=" + oId;
	    				var name = "리뷰작성";
	    				var option = "width=830, height=750, top=110, left=500";
	    				myWindow = window.open(url, name, option);	// 자식창 : 후기 작성 창
	    				window.name = "memberOrder";		// 부모창 : 물품 구매 정보창
	        		}
	        	},
	        	error: function(data){
	        		swal('', '후기 등록에 실패하였습니다.', '');
	        	}
	        });
			
		};
	</script>
</body>
</html>