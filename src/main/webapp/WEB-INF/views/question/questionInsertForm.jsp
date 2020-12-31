<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question/questionInsert.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<section>
	<form action="qinsert.qo" method="post" onsubmit="return insertFrom();">
	<div id="insert_area">
    		<table id="insert">
    			<tr>
    				<th>* 카테고리</th>
    				<td>
				    	<div id="kind">
				    		<select id="categorySelect" name="categorySelect">
				    			<option value="0">카테고리 선택</option>
				    			<option value="회원서비스">&nbsp;&nbsp;회원서비스</option>
				    			<option value="상품판매문의">&nbsp;&nbsp;상품판매문의</option>
				    			<option value="물품나눔문의">&nbsp;&nbsp;물품나눔문의</option>
				    			<option value="봉사활동문의">&nbsp;&nbsp;봉사활동문의</option>
				    		</select>
				    		<input type="hidden" id="categoryChk" name="categoryChk" value="">
				    	</div>
    				</td>
    			</tr>
    			<tr>
    				<th>* Q 질문</th>
    				<td>
				    	<div id="quest">
				    		<textarea id="ask" name="title" placeholder="질문은 특수문자를 제외한 20글자까지 가능합니다."></textarea>
				    	</div>
    				</td>
    			</tr>
    			<tr>
    				<th>* A 답변</th>
    				<td>
				    	<div id="reply">
				    		<textarea id="answer" name="content" placeholder="답변은 특수문자를 제외한 500글자까지 가능합니다."></textarea>
				    	</div>
    				</td>
    			</tr>
    		</table>
    		
	    </div>
	    <div id="btn_area">
	    	<input type="button" id="cancle" class="btn" value="취 소" onclick="location.href='${pageContext.request.contextPath}/qlist.qo';"/>
	    	<input type="submit" id="okay" class="btn" value="등 록"/>		
	    </div>
    </form>
	</section>
	
	<script>
		$('select[name=categorySelect]').change(function(){
			if($(this).val() == 0){
				$('#categoryChk').val("");
			} else {
				$('#categoryChk').val($(this).val());
			}
		});
	
		function insertFrom(){
			var ask = $('#ask').val();
			var answer = $('#answer').val()
			var askExp = /^[,.!@#$%&^*|a-z|A-Z|ㄱ-ㅎ]*$/;
			var answerExp = /^[!@#$%&^*|a-z|A-Z|ㄱ-ㅎ]*$/;
			
			/////////////////////////////////////// 정규화
			if($('#categorySelect option:selected').val() == 0){
   				swal({
   					text: '카테고리를 선택해주세요.',
   					icon: 'info',
   					closeOnClickOutside: false,
    				}).then((ok) => {
	    				if(ok){
	    					swal.close();						
	    				}
    				})
   				$('#categorySelect').focus();
   				return false;
   			} 
			
			if(ask.length == 0 ){
   				swal({
   					text: '질문이 비었습니다.',
   					icon: 'info',
   					closeOnClickOutside: false,
    				}).then((ok) => {
	    				if(ok){
	    					swal.close();						
	    				}
    				})
   				$('#ask').focus();
 				return false;
   				
   			} else if(askExp.test(ask)) {
   				swal({
   					text: '특수문자나 영어를 제외한 올바른 문장을 입력하세요',
   					icon: 'info',
   					closeOnClickOutside: false,
    				}).then((ok) => {
	    				if(ok){
	    					swal.close();						
	    				}
    				})
    			$('#ask').focus();
 				return false;
   			}
		
			if(answer.length == 0 ){
   				swal({
   					text: '답변이 비었습니다.',
   					icon: 'info',
   					closeOnClickOutside: false,
    				}).then((ok) => {
	    				if(ok){
	    					swal.close();						
	    				}
    				})
   				$('#answer').focus();
   				return false;
   				
   			} else if(answerExp.test(answer)) {
   				swal({
   					text: '특수문자나 영어를 제외한 올바른 문장을 입력하세요',
   					icon: 'info',
   					closeOnClickOutside: false,
    				}).then((ok) => {
	    				if(ok){
	    					swal.close();						
	    				}
    				})
   				$('#answer').focus();
   				return false;	
   			}
			
			return true;
			
		};
	</script>

	<%@ include file="../common/footer.jsp" %>
</body>
</html>