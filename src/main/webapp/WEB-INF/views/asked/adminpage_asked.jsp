<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/adminpage_asked.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
	<%@ include file="../common/admin-aside.jsp"%>
		<section>
		<p id="sectionTitle">문의사항 관리<p>
    	<hr id="askedhr">
    	
    	<div class="askedDiv">
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
				<c:if test ="${ q.recnt eq 0 }">
				<tr class="contentTR">
 				<!-- 문의사항 상세조회 -->				
					<td class="askedTtd">${ q.bNo }</td>
					<td class="askedTtd" id="categoryTd">[${ q.qCategory }]</td>
					<td class="askedTtd" id="state"></td>
					
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
				</c:if>	
				</c:forEach>
			</table>
			
		<!-- 페이징 처리 버튼 -->	
	    	<div class="pagination">
	    	
	    <!-- 이전 -->
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prevBtn"> < </a>
	    	</c:if> 	
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="adminAsked.ao">        
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
    				<c:url var="pagination" value="adminAsked.ao">
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
    			<c:url var="after" value="adminAsked.ao">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a class="nextBtn" href="${ after }"> > </a>	
    		</c:if>
		</div>
	</div>	
	</div>
    </section> 
    <script>
  	//글 제목 누르면 상세보기로 이동하는 스크립트
	$(function(){
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
				location.href="${pageContext.request.contextPath}/adminAsked.ao?categoryTab=" + categoryTab;
				console.log("$(this).text() : " + t.innerText);	// Html에서 text부분만 가져옴 --> '전체', '회원서비스' 등
		    	 } 
	</script>
    </main>		
</body>
<%@ include file="../common/footer.jsp"%>
</html>