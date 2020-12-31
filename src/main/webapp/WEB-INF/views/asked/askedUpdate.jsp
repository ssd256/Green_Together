<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/asked/askedUpdate.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <section>
        <p id="sectionTitle">문의사항 수정하기<p>
    	<hr id="updatehr">
    	
    	<div class="writeDiv">
    	<form action="aupdate.ao" method="post" onsubmit="return check()">
	    	<input type="hidden" name="page" value="${ page }">
			<input type="hidden" name="bNo" value="${ question.bNo }">
    		<table id="writeContent">
    		<tr>
    			<td class= "tableTitle" style="width: 150px;">카테고리</td>
    			<td colspan="3"><select id="categorySelect" name="categorySelect">
    								<option value="상품관련">상품관련</option>
    								<option value="물품나눔">물품나눔</option>
    								<option value="봉사활동">봉사활동</option>
    								<option value="회원서비스">회원서비스</option>
    							</select>
    							<input type="hidden" id="categoryChk" name="categoryChk" value="">
    			</td>
    		</tr>
    		<tr>
    			<td class= "tableTitle">제목</td>
    			<td colspan="3"><input type="text" id="titleText" name="title" value="${ question.bTitle }" maxlength="30"/></td>
    		</tr>
    		<tr>
    			<td colspan="4" rowspan="4"><textarea id="contentText" name="content" maxlength="500">${ question.bContent }</textarea></td>
    		</tr>	
    		</table>	
    		<input id="cancleBtn" type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/alist.ao';"/>
			<input id="submitBtn" type="submit" value="수정"/>
		</form>
    	</div>
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    
    <script>
  	//기존에 선택되있던(DB에 등록되있던) 카테고리 값 가져오기
	 $("#categorySelect > option[value="+'<c:out value="${ question.qCategory }"/>'+"]").attr("selected","selected");
     $("#categoryChk").val($("#categorySelect").val())
	 // 선택된 카테고리 값 hidden input에 넣음
 	$('select[name=categorySelect]').change(function(){
		if($(this).val() == 0){
			$('#categoryChk').val("");
		} else {
			$('#categoryChk').val($(this).val());
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
    	
    	//입력하지 않고 수정을 누를시 알람 창 띄움
    	function check(){
    		if($('#categoryChk').val() == 0){
    			alert("카테고리를 선택해 주세요.");
    			$('#categoryChk').focus();
    			return false;
    			
    		} else if($('#titleText').val() == ""){
    			alert("제목을 입력해 주세요.");
    			$('#titleText').focus();
    			return false;
    			
    		} else if($('#contentText').val() == ""){
    			alert("내용을 입력해 주세요.");
    			$('#contentText').focus();
    			return false;
    		}
    		
    		else return true;
    	}
    		
    </script>
</body>
</html>