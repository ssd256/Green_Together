<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productOrder.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<!-- 다음 API  -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <br clear="all">
    <section>
           <p id="sectionTitle">주문 / 결제<p>
    	<hr id="productOderhr">
		
		<!-- 전체 다이브  --><!-- action="orderInsert.po" -->
		<form id="orderForm" onsubmit="return order();">
		<c:set var="o" value="${ order }"/>
		<c:set var="u" value="${ sessionScope.loginUser }"/>
		<input type="hidden" name="mId" value="${ u.userId }">
		<input type="hidden" name="pNo" value="${ pNo }">
		<input type="hidden" name="bNo" value="${ bNo }">
				
		<div id="orderDiv">
			
			
			<div id="orderInfo">
			<p>구매자 정보</p>	
				<table>
					<tr>
						<td class="title">이름</td>	
						<td class="content"><input type="text" class="orderText" name="userName"  value="${ u.userName }" disabled="disabled" ></td>
					</tr>
					<tr>
						<td class="title">이메일</td>
						<td class="content"><input type="text" class="orderText" name="userEmail"  value="${ u.userEmail }" disabled="disabled"></td>
					</tr>
					<tr>
						<td class="title">휴대폰 번호</td>
						<td class="content"><input type="text" class="orderText" name="userhone" value="${ u.userPhone }" disabled="disabled"></td>
					</tr>
				</table>
			</div>
			
			
			<div id="receiverInfo">
			<p>받는사람 정보 <input type="button" class="address_Btn" id="addressBtn" value="배송지 변경하기" onclick="adressUpdate();"></p> 
				<table>
					<tr>
						<td class="title">이름</td>
						<td class="content" colspan="2"><input type="text" id="recipientName" class="addressText" value="${ u.userName }" disabled="disabled" >
														<input type="hidden" name="recipient" value="">
						</td>
					</tr>
					<tr>
						<td class="title">배송주소
							<input type="hidden" id="addr" value="${ u.userAddress }">
							<input type="hidden" name="orderAddr" value="">
						</td>
						<c:forTokens var="addr" items="${ u.userAddress }" delims="/" varStatus="status">
							<c:if test="${ status.index eq 0 && addr >= '0' && addr <= '99999' }">
								<c:set var="post" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 0 && !(addr >= '0' && addr <= '99999') }">
								<c:set var="address1" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 1 }">
								<c:set var="address1" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 2 }">
								<c:set var="address2" value="${ addr }"/>
							</c:if>
						</c:forTokens>
						<td class="content"><input type="text" name="post" class="addressText" id="sample6_postcode" value="${ post }" placeholder="우편번호" disabled="disabled">
	                    					<input type="button" class="address_Btn" id="post_btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
	                    </td>
	                    <td class="content"><input type="text" name="address1" id="sample6_address" class="addressText" value="${ address1 }" placeholder="주소" disabled="disabled">
	                   						<input type="text" name="address2" id="sample6_detailAddress" class="addressText" value="${ address2 }" placeholder="상세주소" disabled="disabled">	          
	                    </td>
					</tr>
					<tr>
						<td class="title">연락처</td>
						<td class="content" colspan="2"><input type="text" class="addressText" id="orderPhone" value="${u.userPhone }" disabled="disabled">
														<input type="hidden" name="reciPhone" value="">				
						</td>
					</tr>
					<tr>
						<td class="title">배송 요청사항</td>
						<td class="content" colspan="2"><input type="text" class="addressText" name="orderMsg" value=""></td>
					</tr>
				</table>
			
			</div>
			
			
			<div id="payInfo">
			<p>결제 정보</p>
			<table>
				<tr>
					<td class="title">구매상품정보</td>
					<td class="content"><input type="text" class="orderText" value="${ pName }, ${ o.orderCount }개" disabled="disabled">
										<input type="hidden" name="orderCount" value="${ o.orderCount }">
										<input type="hidden" name="pName" value="${ pName }">
					</td>	
				</tr>
				<tr>
					<td class="title">총 상품가격</td>
					<td class="content">
						<input type="text" class="orderText" name="orderPrice" value="<fmt:formatNumber value="${ o.orderPay * o.orderCount }" pattern="###,###,###"/>" disabled="disabled"> 원
					</td>	
				</tr>
				<tr>
					<td class="title">배송비</td>
					<td class="content">2,500원</td>	
				</tr>
				<tr>
					<td class="title">총 결제금액</td>
					<td class="content"><input type="text" class="orderText" value="<fmt:formatNumber value="${ o.orderPay * o.orderCount + 2500}" pattern="###,###,###"/>" disabled="disabled">원	
										<input type="hidden" name="totalPay" value="${ o.orderPay * o.orderCount + 2500 }"> 
					</td>
				</tr>
			</table>
			</div>
			
				<p id="message">위 주문 내용을 확인 하였으며, 회원 본인은 결제에 동의합니다.</p>
				
				<input id="cancleBtn" type="button" value="취소" onclick="canclePay();">
				<input id="submitBtn" type="button" value="결제" onclick="Pay();">
		</div>
	</form>
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    
    <script>
	   var bNo = $('input[name="bNo"]').val();
	   var pName = $('input[name="pName"]').val();
	   
    	$(function(){
    		/* disable걸기 */
			/* 첫 화면에서는 우편번호 찾기 버튼숨기기 */
			$('#post_btn').hide();
    		
    		var recipient = $('#recipientName').val();
    		$('input[name="recipient"]').val(recipient);	
    		
    		var orderAddr = $('#addr').val();
    		$('input[name="orderAddr"]').val(orderAddr);
    		
    		var reciPhone = $('#orderPhone').val();
    		$('input[name="reciPhone"]').val(reciPhone);
    		
    		$('input[name="orderMsg"]').on("keyup", function(){
				if($('input[name="orderMsg"]').val().length > 15){
					swal('', '15글자수를 초과하였습니다.', '');	
				}
			});
    		
    	});
    	
    	
		// 결제 API
        function Pay(){
           var orderArray = [];
 			orderArray = [$('input[name="mId"]').val(), 
       			   		 $('input[name="pNo"]').val(), 
       			   		 $('input[name="orderCount"]').val(), 
       			   		 $('#recipientName').val(),
       			   		 $('#orderPhone').val(), 
       			   		 $('#addr').val(), 
	        			 $('input[name="totalPay"]').val(),
       			   		 '결제', 
       			   		 $('input[name="orderMsg"]').val(),
       			   		 $('input[name="pName"]').val()];
 			
       	   console.log($('input[name="totalPay"]').val());
       	   
           IMP.init('imp01839180'); // 아임포트 관리자 페이지의 "시스템 설정" > "내 정보" 에서 확인 가능
           IMP.request_pay({
               pg : 'inicis',
               pay_method : 'card',
               merchant_uid : 'merchant_' + new Date().getTime(),
               name : '주문명:결제테스트',
               amount : Number($('input[name="totalPay"]').val()),
               buyer_email : 'iamport@siot.do',
               buyer_name : '구매자이름',
               buyer_tel : '010-1234-5678',
               buyer_addr : '서울특별시 강남구 삼성동',
               buyer_postcode : '123-456'
           }, function(rsp) {
               if (rsp.success) {
                  //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                  jQuery.ajax({
                     url: "orderInsert.po",
                     type: 'POST',
                     dataType: 'json',
                     data: {
                        //기타 필요한 데이터가 있으면 추가 전달
                        'imp_uid' : rsp.imp_uid,
                        'orderArray' : orderArray
                     }, 
                     success: function(data){
                    	 if (data > 0) {
							console.log('success');
                    	 }
                     },
                     error: function(data){
                    	 console.log('fail');
                     }
                  })
                  .done(function(data) {
                     //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        var msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\n결제 금액 : ' + rsp.paid_amount;

                        alert(msg);
                        location.href='plist.po';   
                  });
               } else {
                   var msg = '결제에 실패하였습니다.';
                   msg += '에러내용 : ' + rsp.error_msg;

                   alert(msg);
               }
           });
        }
        
    
    	function canclePay(){
    		var bNo = $
    		swal('결제 취소', '결제를 취소합니다', 'info')			
			.then((ok) => {
				if(ok){
					location.href='plist.po';
				}
			});
		}
    	
    	
    	//배송지 변경하기 버튼 눌렀을때
    	function adressUpdate(){
			/* disable 해제시키기 */
    		$('.addressText').removeAttr("disabled");
    		/* 첫 화면에서는 우편번호 찾기 버튼 보이기 */
			$('#post_btn').show();
    	}
    	
    	
    	//주소 api
    	 function sample6_execDaumPostcode() {
    		new daum.Postcode({
    		        oncomplete: function(data) {
    		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    		
    		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
    		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
    		            var addr = ''; // 주소 변수
    		            var extraAddr = ''; // 참고항목 변수
    		
    		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
    		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
    		                addr = data.roadAddress;
    		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
    		                addr = data.jibunAddress;
    		            }
    		
    		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
    		            if(data.userSelectedType === 'R'){
    		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
    		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
    		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
    		                    extraAddr += data.bname;
    		                }
    		                // 건물명이 있고, 공동주택일 경우 추가한다.
    		                if(data.buildingName !== '' && data.apartment === 'Y'){
    		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
    		                }
    		            } 
    		
    		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
    		            document.getElementById('sample6_postcode').value = data.zonecode;
    		            document.getElementById("sample6_address").value = addr;
    		            document.getElementById("sample6_detailAddress").value = "";
    		            // 커서를 상세주소 필드로 이동한다.
    		            document.getElementById("sample6_detailAddress").focus();
    		        }
    		    }).open();
    			}
    	
    	
    	
    </script>
</body>
</html>