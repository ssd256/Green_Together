<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/asked/askedList.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
  <%@ include file="../common/header.jsp"%>
    <section>
    <p id="askedtitle">문의사항 목록<p>
    	<hr id="titlehr">
		<c:if test="${ loginUser.userId eq 'admin' }">
		<button id="adminBtn" name="adminBtn" onclick="location.href='adminAsked.ao';">문의사항관리 바로가기</button>
		</c:if>	
        <div class="category_tab">
			<button class="category" id="전체" name="tab" onclick="categorySelect(this);">전체</button>
			<button class="category" id="회원서비스" name="tab" onclick="categorySelect(this);">회원서비스</button>
			<button class="category" id="상품관련" name="tab" onclick="categorySelect(this);">상품관련</button>
			<button class="category" id="물품나눔" name="tab" onclick="categorySelect(this);">물품나눔</button>
			<button class="category" id="봉사활동" name="tab" onclick="categorySelect(this);">봉사활동</button>
		<input type="hidden" id="categoryTab" name="categoryTab" value="-">
		</div>
		<div class="askedList_div">
			<table id="askedTable">
				<tr>
					<th class="askedTtr">번호</th>
					<th class="askedTtr">카테고리</th>
					<th class="askedTtr" id="state"></th>
					<th class="askedTtr">제목</th>
					<th class="askedTtr">작성자[닉네임]</th>
					<th class="askedTtr">작성일</th>
				</tr>
				<c:forEach var="q" items="${ list }">
				
				<tr class="contentTR">
 				<!-- 문의사항 상세조회 -->					
					<td class="askedTtd">${ q.bNo }</td>
					<td class="askedTtd" id="categoryTd">[${ q.qCategory }]</td>
					<td class="askedTtd" id="state"><!-- 댓글이 있으면 답변완료라고 표시되기 -->
								<c:if test ="${ q.recnt > 0 }">
								<span id="answerOk">답변완료</span>
								</c:if>
					</td>
					
					<td class="askedTtd" id="title"> 
							<c:url var="adetail" value="adetail.ao">	
								<c:param name="bNo" value="${ q.mId }"/>
								<c:param name="page" value="${ pi.currentPage }"/>
							</c:url>
								${ q.bTitle }  
					</td>				
					<td class="askedTtd"> ${ q.mNickname }</td>
					<td class="askedTtd"> ${ q.bDate }</td>
				</tr>
				</c:forEach>
			</table>
			
			<c:if test="${ loginUser.userId ne 'admin' }">
			<button id="writeBtn" onclick="location.href='ainsertView.ao';">문의하기</button>
			</c:if>
			
		<!-- 페이징 처리 버튼 -->	
	    	<div class="pagination">
	    	
	    <!-- 이전 -->
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prevBtn"> < </a>
	    	</c:if> 	
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="alist.ao">        
    				<c:param name="page" value="${ pi.currentPage - 1 }" />
 	          	</c:url>
          		<a class="prevBtn" href="${ before }"> < </a>
            </c:if>
	    	
    		<!-- 페이지총 수 보이기 -->
    		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
    			<c:if test="${ p eq pi.currentPage }">
    				<span class="page no">${ p }</span>
    			</c:if>
    			
    			<c:if test="${ p ne pi.currentPage }">
    				<c:url var="pagination" value="alist.ao">
    					<c:param name="page" value="${ p }"/>
					</c:url>	
					<a class="page no" href="${ pagination } ">${ p }</a>
				</c:if>
    		</c:forEach>		
    		
    		<!-- 다음버튼 -->
    		<c:if test="${ pi.currentPage >= pi.maxPage }">
				<a class="nextBtn"> > </a>
				</c:if>
    		<c:if test="${ pi.currentPage < pi.maxPage }">
    			<c:url var="after" value="alist.ao">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a class="nextBtn" href="${ after }"> > </a>	
    		</c:if>
		</div>
	</div>	
		
		<!-- 검색 -->
	 <div id="askedSearch">
        	<select id="searchOption" name="searchOption">
        		<option value=0>카테고리 선택</option>
        		<option value="title">제목</option>
        		<option value="content">내용</option>
        		<option value="tAndC">제목+내용</option>
        	</select>
        	
        	<input id="searchText" type="text" name="searchText" placeholder="검색어를 입력하세요"/>
        	<input type="button" id="searchBtn" class="searchBtn" value="검 색">
        </div>	
        	
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    
    <script>
	    $('#searchBtn').click(function(){
			if($('#searchText').val().trim().length == 0){
				swal({
					text: '검색할 내용을 입력해주세요.',
					icon: 'info',
					closeOnClickOutside: false,
					}).then((ok) => {
					if(ok){
						swal.close();						
					}
				});
			} else if($('#askedSearch option:selected').val() == 0) {
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
				var searchText = $('#searchText').val();
				var searchOption = $('#searchOption').val();
				console.log(searchText);
				console.log(searchOption);
				location.href="aSearch.ao?searchOption=" + searchOption + '&searchText=' + searchText; 
			}
		});
	    
    	$(function(){
    		$(window).scroll(function(){
    			if($(this).scrollTop() < 200){
    				$('#top').fadeOut();
    			} else {
    				$('#top').fadeIn();
    			}
    		});
    		
    		$('#top').click(function(){
    			$('html, body').animate({
    				scrollTop : 0
    			}, 400);
    			return false;
    		});
    	});
    	
    	//글 제목 누르면 상세보기로 이동하는 스크립트
		$(function(){
			$('#adminBtn').mouseenter(function(){
				$(this).css({'background':'yellowgreen','font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function(){
				$(this).css({'background':'rgb(99, 165, 55)','font-weight':'bold'});
			});
			
			$('.contentTR').mouseenter(function(){
				$(this).css({'background':'yellowgreen','font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function(){
				$(this).css({'background':'white', 'font-weight':'normal'});
			}).click(function(){
				var bNo = $(this).children('td').eq(0).text();
				location.href = "adetail.ao?bNo=" + bNo + "&page=" + ${pi.currentPage};
			});
		});
    	
    	// 카테고리 선택 시 url 이용해서 컨트롤러로 값 넘겨줌
		function categorySelect(t){	// t : 클릭된 button 자기 자신의 html
			var categoryTab = t.innerText;
			console.log("$(this).text() : " + t.innerText);	// Html에서 text부분만 가져옴 --> '전체', '회원서비스' 등 
			location.href="${pageContext.request.contextPath}/alist.ao?categoryTab=" + categoryTab;
		};
    	
		$(document).ready(function(){	
			/* 클릭한 카테고리 색 변경하는 스크립트 */
			var category = document.getElementsByClassName('category');
			var categoryTab = document.getElementById("${category}");
				console.log(categoryTab);
				 for(var i = 0; i < category.length; i++){
			        for(var j = 0; j < category.length; j++){
			          category[j].style.background = "rgb(153, 203, 56)";
			        }
			        categoryTab.style.background = "rgb(99, 165, 55)";
			    }
			    
			}); 
			 
			    function categorySelect(t){	
					var categoryTab = t.innerText;
					location.href="${pageContext.request.contextPath}/alist.ao?categoryTab=" + categoryTab;
					console.log("$(this).text() : " + t.innerText);	// Html에서 text부분만 가져옴 --> '전체', '회원서비스' 등
			    	 } 
    </script>
</body>
</html>