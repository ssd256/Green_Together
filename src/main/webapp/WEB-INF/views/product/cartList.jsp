<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/cartList.css" type="text/css">
</head>
<body>
  <%@ include file="../common/header.jsp"%>
    <section>
    <p id="sectionTitle">장바구니<p>
   	<hr id="carthr">
  
   	<div class="cartDiv">
	<c:if test="${ empty clist}">
		장바구니가 비었습니다.  
	</c:if>
	
	<c:if test="${ !(empty clist) }">
	<form id="cartOrderForm" action="cartOrderForm.po" onsubmit="return cartOrder();">
	<c:forEach var="c" items="${ clist }" varStatus="status">
	
	<c:url var="pdetail" value="pdetail.po">
		<c:param name="bNo" value="${ c.bNo }"/>
		<c:param name="pNo" value="${ c.pNo }"/>
	</c:url>
		
		<table class="cart_table">
			<c:if test="${ status.count == 1}">
			<tr>
				<th></th>
				<th colspan="2">상품정보</th>
				<th>상품금액</th>
				<th></th>
			</tr>
			</c:if>
			<tr>
				<td><input type="checkbox" class="chkBoxes" name="chkBox" value="${ c.cPrice }">
					&emsp;&emsp; ${ status.count }
				</td>
				<td class="img_area">
					<img name="fName" src="resources/product_uploadFiles/${c.fName}" alt="액박" onclick="location.href='${pdetail}'">
				</td>
				<td class="orderInfo">${ c.pName }, ${ c.cCount }개
									  <input type="hidden" class="pName" name="pName" value="${ c.pName }">
									  <input type="hidden" name="cCount" value="${ c.cCount }">	
									  <input type="hidden" name="pNo" value="${ c.pNo }">	
									  <input type="hidden" class="bNo" name="bNo" value="${ c.bNo }">
									  <input type="hidden" class="cNo" name="cNo" value="${ c.cNo }">	
				</td>
				<td class="price">
					<fmt:formatNumber value="${ c.cPrice }" pattern="###,###,###"/>원
				</td>
				<td><input type="button" class="selectDelete" value="상품 삭제" onclick="deleteForm(${ c.cNo });"></td>
			</tr>
		</table>
	</c:forEach>
		<table class="cart_table">
			<tr>			
				<td colspan=8 class="cartInfo">
				<input type="hidden" id="cItem" name="cItem" value="">
				<input type="hidden" id="bItem" name="bItem" value="">
				<input type="hidden" id="pItem" name="pItem" value="">
				<input type="hidden" id="price" value="" readonly> 
				총 결제 금액 : <input type="text" id="total" value="" readonly>원 (배송비 2,500원 포함)
				<input type="hidden" name="cPrice" value="">
				</td>
			</tr>
		</table>
		<div id ="inputBtns">
    	<input id="productListBtn" type="button" value="상품목록보기" onclick="location.href='plist.po'">
		<input id="submitBtn" type="submit" value="구매하기">
		</div>
	</form>
	</c:if>
	
	</div>
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    
    <script>
	    $('input[name="chkBox"]').click(function(){
			var chkVal = 0;
			var bItem = [];
			var cItem = [];
			var pItem = [];
			$('input[name="chkBox"]:checked').each(function(index){	// 체크된 체크박스의 개수
				chkVal += Number($(this).val());
				bItem.push($(this).parent().parent().children(".orderInfo").children(".bNo").val());	 // 체크된 bNo
				cItem.push($(this).parent().parent().children(".orderInfo").children(".cNo").val());     // 체크된 cNo
				pItem.push($(this).parent().parent().children(".orderInfo").children(".pNo").val());     // 체크된 pNo
			});
			
			var price = $('#price').val(chkVal);
			var total = 2500;
			total += Number($('#price').val());
			$('input[name="cPrice"]').val(total);
			
			totlaNum = numberWithCommas(total);
			$('#total').val(totlaNum);
			$('#bItem').val(bItem);
			$('#cItem').val(cItem);
	    });	
	    
	    
	    function numberWithCommas(x) {
	        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
		
	    
	    function cartOrder(){
	    	if($('#total').val().length == 0){
	    		swal({
					text : '구매하실 상품을 선택해주세요',
					icon : 'info',
					closeOnClickOutside: false,
					}).then((ok) => {
						if(ok){
							swal.close();
						} 
					})
	    				return false;
	 			} else{
	    			return true;
	 			}
	    	};
	    		
	    
    	function deleteForm(c){
			swal({
				text : '해당 상품을 장바구니에서 삭제하시겠습니까?',
				icon : 'warning',
				buttons : ["아니오", "예"],
				dangerMode: true,
				closeOnClickOutside: false,
				}).then((ok) => {
					if(ok){
						location.href='cartDelete.po?cNo=' + c;
					} 
				})
 			};
    </script>

</body>
</html>