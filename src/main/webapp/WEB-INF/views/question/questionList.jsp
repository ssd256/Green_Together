<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question/questionList.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<section>
		<div id="category_tab">
			
			<button class="category" id="전체" name="tab" onclick="categorySelect(this);">전체</button>
			<button class="category" id="회원서비스" name="tab" onclick="categorySelect(this);">회원서비스</button>
			<button class="category" id="상품판매문의" name="tab" onclick="categorySelect(this);">상품판매문의</button>
			<button class="category" id="물품나눔문의"  name="tab" onclick="categorySelect(this);">물품나눔문의</button>
			<button class="category" id="봉사활동문의" name="tab" onclick="categorySelect(this);">봉사활동문의</button>
			<input type="hidden" id="categoryTab" name="categoryTab" value="-">
			
			<c:if test="${ !empty loginUser && loginUser.userId == 'admin' }">
				<input type="button" id="delete_btn" class="btn" value="삭 제" onclick="deleteForm();">
			    <input type="button" id="update_btn" class="btn" value="수 정" onclick="updateForm();">
			    <input type="button" id="insert_btn" class="btn" value="등 록" onclick="location.href='${pageContext.request.contextPath}/qinsertForm.qo';">
			</c:if>
		</div>
       
      <div id="qna">
      
       <c:if test="${ !empty loginUser && loginUser.userId == 'admin' }">
	      	<table class="asked">
		       <c:forEach var="q" items="${ list }">
		      		<tr class="ask">
		      			<td class="a_td">
		      				<input type="radio" name="radio_btn" value="${ q.bNo }">
		      			</td>
		      			<td class="a_td">Q</td>
		      			<td class="a_td" name="content">[${ q.qCategory }] ${ q.bTitle }</td>
		      			<td class="a_td">
		      				<input class="ask_btn" name="ask_btn" type="button" value="∨" onclick="askBtn(${q.bNo});">
		      			</td>
		      		</tr>
		      		<tr>
		      			<td colspan="4"><hr></td>
		      		</tr>
		      		<tr id="answer_${q.bNo}" class="answer">
		      			<td></td>
		      			<td class="a_td">A</td>
		      			<td class="a_td" name="content">${ q.bContent }</td>
		      		</tr>
		      		<tr id="answer_${q.bNo}" class="answer_hr">
		      			<td colspan="5" ><hr></td>
		      		</tr>
	      		</c:forEach>
	      	</table>
		</c:if>
		
		<c:if test="${ empty loginUser || loginUser.userId != 'admin' }">
	      	<table class="asked">
				<c:forEach var="q" items="${ list }">
		      		 <tr class="ask">
		      			<td class="b_td">Q</td>
		      			<td class="b_td" name="title">[${ q.qCategory }] ${ q.bTitle }</td>
		      			<td class="b_td">
		      				<input class="ask_btn" name="ask_btn" type="button" value="∨" onclick="askBtn(${q.bNo});">
		      			</td>
		      		</tr>
		      		<tr>
		      			<td colspan="3"><hr></td>
		      		</tr>
		      		<tr id="answer_${q.bNo}" class="answer">
		      			<td class="b_td">A</td>
		      			<td class="b_td" name="content">${ q.bContent }</td>
		      		</tr>
		      		<tr id="answer_${q.bNo}" class="answer_hr">
		      			<td colspan="4" ><hr></td>
		      		</tr>
		    	</c:forEach>
	      	</table>
		      	
		</c:if>
		</div>
		
		<c:if test="${ pi.currentPage > 0 }">
		<!-- 페이징 처리 -->	
	    <div class="pagination">
	    
      	<!-- 이전 -->
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prev_btn"> < </a>
	    	</c:if>
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="qlist.qo">        
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
    				<c:url var="pagination" value="qlist.qo">
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
    			<c:url var="after" value="qlist.qo">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a href="${ after }" class="next_btn"> > </a>
    		</c:if>
	      </div>
	     </c:if>
    </section>
	<%@ include file="../common/footer.jsp" %>

	<script>
		$(document).ready(function(){	
			//////////////////////////////////////////// 카테고리 탭 누르면 배경색 바뀜 
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
		
		    function askBtn(a){
		    	$('.ask_btn').blur();
				if($('#answer_'+a).css('display') == 'none'){
					$('#answer_'+a).slideDown('slow');
					$('#answer_'+a).next().slideDown('slow');
				}else{
					$('#answer_'+a).slideUp('slow');
					$('#answer_'+a).next().slideUp('slow');
				}
		    };
		    
			
			function categorySelect(t){	// t : 클릭된 button 자기 자신의 html
 				var categoryTab = t.innerText;
				console.log("$(this).text() : " + t.innerText);	// Html에서 text부분만 가져옴 --> '전체', '회원서비스' 등 
 				location.href="${pageContext.request.contextPath}/qlist.qo?categoryTab=" + categoryTab;
			};
			
			
			function updateForm(){
				if(!$('input[name="radio_btn"]:checked').val()){
					swal({
						text: '수정할 항목을 선택해주세요.', 
						icon: 'info',
						closeOnClickOutside: false,
						}).then((ok) => {
						if(ok){
							swal.close();							
						}
					});
				} else {
					var radioVal = $('input[name="radio_btn"]:checked').val();	// radio_btn 중 선택된 라디오버튼
					location.href='${pageContext.request.contextPath}/qupdateForm.qo?bNo=' + radioVal;
				}
			}
			
			function deleteForm(){
				if(!$('input[name="radio_btn"]:checked').val()){
					swal({
						text: '삭제할 항목을 선택해주세요.', 
						icon: 'info',
						closeOnClickOutside: false,
						}).then((ok) => {
						if(ok){
							swal.close();							
						}
					});
				} else {
					var radioVal = $('input[name="radio_btn"]:checked').val();
					location.href='${pageContext.request.contextPath}/qdelete.qo?bNo=' + radioVal;
				}
			}
			
	</script>
</body>
</html>