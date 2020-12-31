<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage_pwdUpdate.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
	<%@ include file="../common/member-aside.jsp"%>
	<section>
		<h2 align="center">'${loginUser.userId }' 비밀번호 수정</h2>
		<div class="centerText">
			<form action="mPwdUpdate.me" method="post" onsubmit="return confirmPwd();">
			<input type="hidden" name="id" value="${loginUser.userId }"/>
				<table id="pwdUpdateTable">
					 <tr>
			        	<td width="150px"><b/>기존 비밀번호</td>
			        	<td>
			        		<input type="password" maxlength="20" name="pwd" id="pwd" class="text_box"  required>
			        	</td>
			        </tr>
					 <tr>
			        	<td width="150px"><b/>새 비밀번호</td>
			        	<td>
			        		<input type="password" maxlength="20" name="newPwd1" id="pwd1" class="text_box" placeholder="8자이상 영문,숫자,!@#$%^&*"  required>
			        	</td>
			        	<td>
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
					<input type="submit" class="btn" value="비밀번호 변경">
		   	 	</div>
			</form>		
		</div>
	</section>
	</main>
	 <%@ include file="../common/footer.jsp"%>
	<script>
		let isPwd=false;
		function confirmPwd(){
			var newPwd1 =$( 'input[name=newPwd1]').val();
			var newPwd2 =$( 'input[name=newPwd2]').val();
				if(!isPwd){
					sweetAlert("기존 비밀번호 확인","기존 비밀번호가 맞지 않습니다.","error");
					$('input[name=pwd]').select();
					return false;
				}else{
					if(newPwd1 == newPwd2){
						return true;
					} else{
						sweetAlert("변경 비밀번호 확인","새 비밀번호와 새 비밀번호 확인이 맞지 않습니다.","error");
						$('input[name=newPwd2]').select();
						return false;
					}
				}
		}
		 //비밀번호 정규표현식
	    $('#pwd1').focusout(function(){
			var id = $(this).val().trim();
			 $("#pwd1Result").show();
			 var regExp = /^[a-zA-Z0-9\!\@\#\$\%\^\&\*]{7,20}$/;
			 if($(this).val()==""){
					$("#pwd1Result").text("");
					isPwd1 = false;
					return;
			}
			else if(!regExp.test($(this).val())){
				$("#pwd1Result").text("8자이상 영문,숫자,!@#$%^&*").css("color","red");
				isPwd1 = false;
			}else{
				$("#pwd1Result").hide();
				isPwd1 = true;
			}
// 			console.log("pwd1 : " + $(this).val());
		});
	    $('#pwd').focusout(function(){
			var pwd=$('#pwd').val();
			 if($(this).val()==""){
					return;
			}else{
				$.ajax({
		            url: 'pwdCheck.me',
		            data: {
		            	pwd:pwd,
						},
		            success: function(data){
			        	if(data){
							isPwd = true;
			          	}
			          	else{
			        	   isPwd = false;	
			         	}
			        	
// 						console.log("pwd : " + pwd);
// 						console.log("isPwd : " + isPwd);
		            },
		            error: function(data){
		               alert("ajax 에러 발생");
		            }
		    	});
			}
		});
	</script>
</body>
</html>