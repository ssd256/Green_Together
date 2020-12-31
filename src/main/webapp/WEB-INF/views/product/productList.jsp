<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productList.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp"/>
   <section>
        <div id="search_box">
        	<select>
        		<option value=0>카테고리 선택</option>
        		<option value="화장품">화장품</option>
        		<option value="주방용품">주방용품</option>
        		<option value="목욕용품">목욕용품</option>
        		<option value="비누/세제">비누/세제</option>
        		<option value="생활용품">생활용품</option>
        		<option value="기타">기타</option>
        	</select>
        	
        	<input id="search_text" type="text" placeholder="검색어를 입력하세요"/>
        	<input type="button" id="search_btn" class="btn" value="검 색">
        	<c:if test="${ !empty loginUser && loginUser.userId == 'admin'}">	
        		<input type="button" id="insert_btn" class="btn" value="등 록" onclick="location.href='${pageContext.request.contextPath}/pinsertForm.po';">	
        	</c:if>
        </div>
        
        <hr id="line">

		<div id="select_tap">        
        	<ul>
				<li>
					<a href="#" id="a1" class="select_btn">최신순&nbsp;</a>|
		            <a href="#" id="a3" class="select_btn">&nbsp;낮은가격순&nbsp;</a>|
		            <a href="#" id="a4" class="select_btn">&nbsp;높은가격순</a>
	            </li>    	
            </ul>
	   </div>
	   
	   	<c:if test="${ plist.isEmpty() || flist.isEmpty() }">
	   		등록된 상품이 없습니다.
	   	</c:if>
	   	<c:if test="${ !(empty plist) && !(empty flist) }">
			<div class="product_area">
		   	<c:forEach var="p" items="${ plist }">
				<c:url var="pdetail" value="pdetail.po">
					<c:param name="bNo" value="${ p.bNo }"/>
					<c:param name="pNo" value="${ p.pNo }"/>
				</c:url>
			<c:forEach var="f" items="${ flist }">
				<c:if test="${ p.bNo == f.bNo }">
					<div class="wrap">
					<div class="img" onclick="location.href = '${ pdetail }'">
						<img src="resources/product_uploadFiles/${ f.fChangeName }"/>
					</div>
					<div class="context">
						<p class="title">${ p.pName }</p>
						<p class="pay">가격 : <fmt:formatNumber value="${ p.pPrice }" pattern="###,###,###"/>원</p>
						<p class="date">${ p.bDate }</p>
					</div>
					</div>
				</c:if>
			</c:forEach>
			</c:forEach>
			</div>
		</c:if>
	    <br clear="all">
	    
	    <!-- 이전 -->
	    <div class="pagination">
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prev_btn"> < </a>
	    	</c:if>
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="plist.po">        
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
    				<c:url var="pagination" value="plist.po">
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
    			<c:url var="after" value="plist.po">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a href="${ after }" class="next_btn"> > </a>
    		</c:if>
		</div>
	    
    </section>
    <c:import url="../common/footer.jsp"/>
    
    <script>
 	   var searchText;
 	   var searchOption;
   		$('#search_btn').click(function(){
   			if($('#search_text').val().trim().length == 0){
   				swal({
   					text: '검색할 상품을 입력해주세요.',
   					icon: 'info',
   					closeOnClickOutside: false,
					}).then((ok) => {
					if(ok){
						swal.close();						
					}
				});
   			} else if($('#search_box option:selected').val() == 0) {
   				swal({
   					text: '검색할 카테고리를 선택해주세요.',
   					icon: 'info',
   					closeOnClickOutside: false,
					}).then((ok) => {
					if(ok){
						swal.close();						
					}
				});
   			} else {
   				searchText = $('#search_text').val().trim();
   				searchOption = $('#search_box option:selected').val();
   				console.log(searchText);
   				console.log(searchOption);
   				location.href="psearch.po?searchOption=" + searchOption + '&searchText=' + searchText;
   			}
   		});
   		
   		
   		var option;
   		$('#a1').click(function(){
   			option = '최신순';
   			location.href = 'poption.po?option=' + option;
   		});
   		
   		$('#a2').click(function(){
   			option = '판매순';
   			location.href = 'poption.po?option=' + option;
   		});
   		
   		$('#a3').click(function(){
   			option = '낮은가격순';
   			location.href = 'poption.po?option=' + option;
   		});
   		
   		$('#a4').click(function(){
   			option = '높은가격순';
   			location.href = 'poption.po?option=' + option;
   		});
    </script>
</body>
</html>
