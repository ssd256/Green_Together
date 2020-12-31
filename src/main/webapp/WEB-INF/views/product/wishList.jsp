<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/wishList.css" type="text/css">
</head>
<body>
   <%@ include file="../common/header.jsp"%>
    <section>
        <p id="sectionTitle">찜 목록<p>
    	<hr id="wishhr">
    	
    	<div class="wishDiv">
		<c:if test="${ empty wlist }">
			찜하기가 비었습니다.  
		</c:if>
		
    	<form>
    	<c:forEach var="w" items="${ wlist }" varStatus="status">	
    	<c:url var="pdetail" value="pdetail.po">
			<c:param name="bNo" value="${ w.bNo }"/>
			<c:param name="pNo" value="${ w.pNo }"/>
		</c:url>
		
		<c:if test="${ !(empty wlist) }">
    	<table>
    		<c:if test="${ status.count == 1}">
			<tr>
				<th>개수</th>
				<th colspan="2">상품 정보</th> 
				<th colspan="2">상품 금액</th>
			</tr>
			</c:if>
			<tr>
				<td>${ status.count }<input type="hidden" class="cCount_${ status.count }" value="1"></td>
				<td class="img_area">
					<img src="resources/product_uploadFiles/${w.fName}" alt="액박" onclick="location.href='${pdetail}'">
					<input type="hidden" name="fName" class="fName_${ status.count }" value="${w.fName}">
				</td>
				<td class="wishInfo">${ w.pName }
					<input type="hidden" class="pName_${ status.count }" name="pName" value="${ w.pName }"><input type="hidden" class="pName_${ status.count }" name="count" value="${ w.cCount }">
				</td>
				<td class="price"><input type="hidden" name="cPrice" class="cPrice_${ status.count }" value="${ w.cPrice }">
					<fmt:formatNumber value="${ w.cPrice }" pattern="###,###,###"/>원
				</td>
				<td>
					<input type="hidden" name="chk_bNo" class="bNo_${ status.count }" value="${ w.bNo }">
					<input type="hidden" name="chk_pNo" class="pNo_${ status.count }" value="${ w.pNo }">
					<input type="button" name="cartInput" value="장바구니" onclick="cartForm(${ status.count });">
					<input type="button" name="del" value="삭제하기" onclick="deleteForm(${ status.count });">
				</td>
			</tr>
		</table>
		</c:if>
		</c:forEach>
		</form>
    	</div>
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    
    <script>
    
	    function cartForm(s){
		    var bNo = $('.bNo_' + s).val();
			var pNo = $('.pNo_' + s).val();
			var cCount = $('.cCount_' + s).val();
			var cPrice = $('.cPrice_' + s).val();
			var fName = $('.fName_' + s).val();
			var pName = $('.pName_' + s).val();
			
			$.ajax({
				url: 'cartWishInsert.po',
				data: {	
						'bNo' : bNo, 
						'pNo' : pNo,
						'cCount': cCount,
						'cPrice' : cPrice,
						'fName' : fName,
						'pName' : pName 	
					  },
				success: function(data){
						swal({
						text: '장바구니로 이동하시겠습니까?',
						icon: 'info',
						buttons: ["쇼핑 계속하기", "장바구니로 이동"],
						closeOnClickOutside: false
						}).then((ok) => {
							if(data == 'fail'){
								swal('', '이미 장바구니에 존재합니다', '');
							} else {
								swal.close();
								location.href='cartList.po';
							}
						});
				},
				error: function(data){
					swal({
						text: '더 이상 장바구니에 담을 수 없습니다.',
						icon: 'error',
						closeOnClickOutside: false,
					})
				}
			});
	    };
	    
	    function deleteForm(p){
				var chkVal = $('.pNo_' + p).val();
				console.log(chkVal);
					swal({
						text : '해당 상품을 찜하기에서 삭제하시겠습니까?',
						icon : 'warning',
						buttons : ["아니오", "예"],
						dangerMode: true,
						closeOnClickOutside: false,
					}).then((ok) => {
						if(ok){
	 					location.href='wishDelete.po?pNo=' + chkVal;
						} 
					})
			};
    
    </script>
</body>
</html>