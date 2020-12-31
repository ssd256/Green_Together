<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question/questionUpdate.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
    <section>
    <form action="qupdate.qo" method="post" onsubmit="return updateForm();">
    	<div id="insert_area">
    		<table id="insert">
    			<tr>
    				<th>* 카테고리</th>
    				<td>
				    	<div id="kind">
				    		<input type="text" id="categorySelect" name="categorySelect" value="${ question.qCategory }" disabled="disabled">
				    		<input type="hidden" id="bNo" name="bNo" value="${ question.bNo }">
				    	</div>
    				</td>
    			</tr>
    			<tr>
    				<th>* Q 질문</th>
    				<td>
				    	<div id="quest">
				    		<textarea id="ask" name="title">${ question.bTitle }</textarea>
				    	</div>
    				</td>
    			</tr>
    			<tr>
    				<th>* A 답변</th>
    				<td>
				    	<div id="reply">
				    		<textarea id="answer" name="content">${ question.bContent }</textarea>
				    	</div>
    				</td>
    			</tr>
    		</table>
    		
	    </div>
	    <div id="btn_area">
	    	<input type="button" id="cancle" class="btn" value="취 소" onclick="location.href='${pageContext.request.contextPath}/qlist.qo';">
	    	<input type="submit" id="update" class="btn" value="수 정" />
	    </div>
	</form>
	</section>
	
	<script>
		function updateForm(){
			var ask = $('#ask').val();
			var answer = $('#answer').val()
			var askExp = /^[,.!@#$%&^*a-zA-Zㄱ-ㅎ]*$/;
			var answerExp = /^[!@#$%&^*a-zA-Zㄱ-ㅎ]*$/;
			
			/////////////////////////////////////// 정규화
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