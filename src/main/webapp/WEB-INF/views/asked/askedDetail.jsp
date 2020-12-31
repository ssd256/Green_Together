<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/asked/askedDetail.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <section>
          <p id="sectionTitle">문의사항 상세보기<p>
    	<hr id="Detailhr">
    	
    	<div class="detailDiv">
    		<table id="detailContent">
    		<tr>
    			<td class= "tableTitle">카테고리</td>
    			<td colspan="4" style="text-align: left; font-weight: bold;">[${ question.qCategory }]</td>
    		</tr>
    		<tr>
    			<td class= "tableTitle">제목</td>
    			<td colspan="2" style="text-align: left;">${ question.bTitle }</td>
    			<td class= "tableTitle">작성자</td>
    			<td colspan="2" style="text-align: left;">${ question.mNickname }</td>
    		</tr>
    		<tr>
    			<td class= "tableTitle">최초작성일</td>
    			<td colspan="2" style="text-align: left;">${ question.bDate }</td>
    			<td class= "tableTitle">수정일</td>
    			<td colspan="2" style="text-align: left;">${ question.bModifyDate }</td>
    		</tr>
    		<tr>
    			<td colspan="6" rowspan="4">${ question.bContent }</td>
    		</tr>	
    		</table>
    	<br>	
    	<button id="listBtn" onclick="location.href='alist.ao'">목록</button> 
    	<!-- 게시글 삭제 -->
    		<c:url var="adelete" value="adelete.ao">
    				<c:param name="bNo" value="${ question.bNo }"/>
    		</c:url>
    	<!-- 게시글 수정 -->	
    		<c:url var="aupdateView" value="aupdateView.ao">
    			<c:param name="bNo" value="${ question.bNo }"/>
    			<c:param name="page" value="${ pi.currentPage }"/>
    		</c:url>
    		
    
    	<c:if test="${ loginUser.userNickName eq question.mNickname }">
    	<button class="detailBtn" id="deleteBtn" onclick="deleteChk();">삭제</button> 
    	<button class="detailBtn" id="editBtn" onclick="location.href='${ aupdateView }'">수정</button>	
    	</c:if>
    	
    	    	<!-- 이전글, 다음글 -->
    			<!-- 다음글  -->
    			<br><br>
    			<table id="npTable">
    			<tr id="nextTr">
    						<td class="nextTitle">⋀&nbsp;&nbsp;다음글</td>
    				<c:choose>
    				<c:when test="${ question.nextNo == null || question.nextNo == ''}">
    				    	<td colspan="6">다음글이 존재하지 않습니다.</td>
    				    	<input type="hidden" value ="${ question.nextNo }" id="next_hi">
    				</c:when>
    				<c:when test="${ question.nextNo != null || question.nextNo != 0 }">
	    					<td style="font-weight: bold; width: 100px;">${ question.nextCate }</td>
    						<td class="askedtitle" colspan="3">${ question.nextTitle }</td>
	    					<td>${ question.nextNickname }</td>
	    					<td>${ question.nextDate }</td>
	    		    		<input type="hidden" value ="${ question.nextNo }" id="next_hi">
    				</c:when>
    				</c:choose>
    			</tr>
    			<!-- 이전글 -->
    			<tr id="prevTr">
    						<td class="nextTitle">⋁ &nbsp;이전글 </td>
    				<c:choose>
    				<c:when test="${ question.prevNo == null || question.prevNo == ''}">
	    					<td colspan="6">이전글이 존재하지 않습니다.</td>
	    					<input type="hidden" value ="${ question.prevNo }" id="prev_hi">
	    			</c:when>
    				<c:when test="${ question.prevNo != null || question.prevNo != 0 }">
	    				<td style="font-weight: bold; width: 100px;" >${ question.prevCate }</td>
	    				<td class="askedtitle" colspan="3">${ question.prevTitle }</td>
	    				<td>${ question.prevNickname }</td>
	    				<td>${ question.prevDate }</td>
	    				<input type="hidden" value ="${ question.prevNo }" id="prev_hi">
    				</c:when>
    				</c:choose>
    			</tr>
    		</table>
    	<br>
    	<!-- 댓글 입력-->
	    <c:if test="${ loginUser.userId eq 'admin' }">
		    <div class="container">
		        <div class="containerDiv">
		        <label for="content">답변</label>
		        <form id="commentInsertForm" name="commentInsertForm">
		               <input type="hidden" name="bNo" value=" ${question.bNo} "/>
		               <input type="hidden" name="userId" value=" ${userId} "/>
		               <input type="hidden" name="mNickname" value=" ${question.mNickname} "/>
		               <textarea class="form-control" name="content" placeholder="답변을 입력해주세요" maxlength="300"></textarea>
		               <span class="input-group-btn">
		                <button class="btn-default" type="button" name="commentInsertBtn">등록</button>
		               </span>
		        </form>
		        </div>
		    </div>
	    </c:if>
	    
	    <!-- 댓글 영역 -->
	    <div class="container">
	    <div class="commentList"></div>
	    </div>
		<%@ include file="askedAnswerd.jsp" %>


    	</div>
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    			
    <script>
    
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
    	
    	//내가 쓴 문의사항 삭제시 알림창
    	function deleteChk(){
       		if(confirm("게시물을 정말로 삭제하시겠습니까?\n삭제한 게시물은 복구가 불가능합니다.")){
       			location.href='${ adelete }'
    		} else {
    			return;
    		}
    	}
    	
    	//이전글 다음글
    	//이전글
			$('#prevTr').mouseenter(function(){
				$(this).css("cursor", "pointer");
			}).click(function(){
				var bNo = $('#prev_hi').val();
				console.log("이전글 : " + bNo);
				if(bNo == 0){
					sweetAlert("문의사항", "이전글이 존재하지 않습니다.","error");
				}  else {
					location.href = "adetail.ao?bNo=" + bNo + "&page=" + "${pi.currentPage}";
				} 
			});
			
			// 다음글
			$('#nextTr').mouseenter(function(){
				$(this).css("cursor", "pointer");
			}).click(function(){
				var bNo = $('#next_hi').val();
				console.log("다음글 : " + bNo);
				if(bNo == 0){
					sweetAlert("문의사항", "다음글이 존재하지 않습니다.","error");
				} else {
					location.href = "adetail.ao?bNo=" + bNo + "&page=" + "${pi.currentPage}";
				}
			});
     	
    </script>
</body>
