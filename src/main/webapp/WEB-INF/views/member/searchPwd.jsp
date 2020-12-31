<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<style>
		table{
			border-spacing: 15px;
		}
		.searchbox{
		   width: 80%;
		   padding: 2% 10%;
		   margin : 30% auto;
		   margin-bottom : 10%;
		   text-align: center;
		   /* margin-top: 10%; */
		   background-color: rgb(248, 248, 248); ;
		}
		.btn_box{
		   	text-align: center;
		   	margin: 40px auto;
	   	}
	   	.btn{
		    display: inline-block;
			border: none;
			border-radius:5px;
			background: rgb(99, 165, 55);
			color: white;
			width: 100px; height: 40px;
			cursor: pointer;
			font-size: 20px;
	   	}
		#cancleBtn{
			background: rgb(193, 223, 135);
		}
	</style>
</head>
<body>
	<div style="display: none;">
		<%@ include file="../common/header.jsp"%>
	</div>
	<div class="searchbox">
		<c:if test="${empty message}">
			<h2 align="center">'${searchId }' 비밀번호 수정</h2>
			<div class="centerText">
				<form action="searchUpdatePwd.me" method="post" onsubmit="return confirmPwd();">
				<input type="hidden" name="id" value="${searchId }"/>
					<table>
						 <tr>
				        	<td width="150px"><b/>비밀번호</td>
				        	<td>
				        		<input type="password" maxlength="20" name="newPwd1" id="pwd1" class="text_box"  required>
								<label id="pwd1Result"></label>
				        	</td>
				        </tr>
				        <tr>
				        	<td width="150px"><b/>비밀번호 확인</td>
				        	<td>
				        		<input type="password" maxlength="20" name="newPwd2" id="pwd2" class="text_box"  required>
								<label id="pwd2Result"></label>
							</td>	
				        </tr>
					</table>
					<div class="btn_box">
						<input type="button" class="btn" id="cancleBtn" value="취소" onclick="window.close()();">
						<input type="submit" class="btn" value="수정하기">
			   	 	</div>
				</form>		
			</div>
		</c:if>
		<c:if test="${!empty message}">
			<h2>비밀번호 수정 완료</h2>
			<button type="button" class="btn" onclick="window.close()">확인</button>
		</c:if>
	</div>
	<script>
		function confirmPwd(){
			var newPwd1 =$( 'input[name=newPwd1]').val();
			var newPwd2 =$( 'input[name=newPwd2]').val();
			
			if(newPwd1 == newPwd2){
				return true;
			} else{
// 				alert('새 비밀번호와 새 비밀번호 확인이 맞지 않습니다.');
				sweetAlert('새 비밀번호와 새 비밀번호 확인이 맞지 않습니다.');
				$('input[name=newPwd2]').select();
				return false;
			}
		}
		 //비밀번호 정규표현식
	    $('#pwd1').change(function(){
			var id = $(this).val().trim();
			 $("#pwd1Result").show();
			 var regExp = /^[a-zA-Z]([a-zA-Z0-9\!\@\#\$\%\^\&\*]){7,20}$/;
// 			 console.log("pwd1 : " + $(this).val());
				if(!regExp.test($(this).val())){
					$("#pwd1Result").text("8자이상입니다").css("color","red");
					$(this).focus();
					isPwd1 = false;
				}else{
					$("#pwd1Result").hide();
					isPwd1 = true;
				}
		});
	</script>
</body>
</html>