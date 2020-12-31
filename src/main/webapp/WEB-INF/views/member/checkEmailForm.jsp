<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>함께 그린 - 이메일 인증</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/checkEmailForm.css" type="text/css">
</head>
<body>
	<div style="display: none;">
		<%@ include file="../common/header.jsp"%>
	</div>
	<h2>이메일 인증</h2>
	<form method="post" action="${ contextPath }/email/send.do" id="checkEmailForm">
		<input type="hidden" name="senderName" value="함께그린">
		<input type="hidden" name="senderMail" value="cjddnseo11@naver.com">
		<input type="hidden" name="subject" value="함께그린 인증 메일입니다"><br>
        <input type="hidden" id="receiveMail" name="receiveMail" value="${receiveMail}">
		<table class="mailTable" align="center">
		    <tr>
		        <td width="auto">이메일 주소</td>
		        <td width="auto">
		            <c:if test="${!empty receiveMail}">
			            <c:forTokens var="email" items="${ receiveMail }" delims="@" varStatus="status">
							<c:if test="${ status.index eq 0}">
								<c:set var="emailId" value="${ email }"/>
							</c:if>
							<c:if test="${ status.index eq 1 }">
								<c:set var="emailAddress" value="${ email }"/>
							</c:if>
						</c:forTokens>
		           		<input type="text" name="emailId" class="text_box" id="emailId" value="${ emailId }" readonly> @ 
               			<input type="text" name="emailAddress"  class="text_box" id="selectEmail" value="${ emailAddress }" readonly>
<!-- 	                    <span>     -->
<!-- 	                        <select class="email_box" id="email_select"  onchange="selectMail()"> -->
<!-- 	                            <option value="직접입력" selected >직접입력</option> -->
<!-- 	                            <option value="naver.com">naver.com</option> -->
<!-- 	                            <option value="hanmail.net">hanmail.net</option> -->
<!-- 	                            <option value="nate.com">nate.com</option> -->
<!-- 	                            <option value="gmail.com">gmail.com</option> -->
<!-- 	                            <option value="hotmail.com">hotmail.com</option> -->
<!-- 	                            <option value="lycos.co.kr">lycos.co.kr</option> -->
<!-- 	                            <option value="empal.com">empal.com</option> -->
<!-- 	                            <option value="korea.com">korea.com</option> -->
<!-- 	                        </select> -->
<!-- 	                   </span>      -->
		            </c:if>
		            <c:if test="${empty receiveMail}">
		           		<input type="text" name="emailId" class="text_box" id="emailId" value="${ emailId }"> @ 
               			<input type="text" name="emailAddress"  class="text_box" id="selectEmail" value="${ emailAddress }">
	                    <span>    
	                        <select class="email_box" id="email_select"  onchange="selectMail()">
	                            <option value="직접입력" selected >직접입력</option>
	                            <option value="naver.com">naver.com</option>
	                            <option value="hanmail.net">hanmail.net</option>
	                            <option value="nate.com">nate.com</option>
	                            <option value="gmail.com">gmail.com</option>
	                            <option value="hotmail.com">hotmail.com</option>
	                            <option value="lycos.co.kr">lycos.co.kr</option>
	                            <option value="empal.com">empal.com</option>
	                            <option value="korea.com">korea.com</option>
	                        </select>
	                   </span>     
		            </c:if>
		            <input id="emailCheck_btn" type="submit" value="인증"><br>
		        </td>
		    </tr>
		    <tr>
		    	<td>
		    		<input type="hidden">
		    	</td>
		    	<td>
		            <label id="emailResult"></label>
		    	</td>
		    </tr>
			<tr>
				<td>
		    		<input type="hidden">
		    	</td>
				<td>${message}</td>
			</tr>
			<tr>
<%-- 			<c:out value="${AuthenticationKey}"/> --%>
				<c:if test="${!empty AuthenticationKey}">
					<td width="auto">인증코드</td>
					<td width="auto"> 
						<input type="text" id="key" name="key"/>
					</td>
				</c:if>
			</tr>
	    </table>
	    <div class="btn_box">
			<input type="button" class="btn" id="cancel" value="취소" onclick="window.close();">
			<input type="button" class="btn" id="usedId" value="확인" onclick="checkKey();">
	    </div>
	</form>
	<script>
		let useEmail = false;
		$('#checkEmailForm').submit(function(event){ 
			// 자동 submit을 시키는 것을 막는다. 
			event.preventDefault();
			
			var idRegExp = /^[A-Za-z0-9_\.\-]/;
			var addRegExp = /^[A-Za-z0-9\-]+\.[A-Za-z]+/;
			var emailId = $("#emailId").val();
			var emailAddress = $("#selectEmail").val();
			if(idRegExp.test($("#emailId").val())&&addRegExp.test($("#selectEmail").val())){
				$("#emailResult").show();
				emailCheck(emailId,emailAddress);
			}else{
// 				alert("이메일이 올바르지 않습니다.");
// 				sweetAlert("이메일이 올바르지 않습니다.");
				$("#emailResult").text("이메일이 올바르지 않습니다.").css("color","red");
			}
			 if(useEmail){
				 event.currentTarget.submit();
			 }
		});
		function emailCheck(emailId,emailAddress){
			var orginalEmail = "${ loginUser.userEmail }";
			var email = emailId+"@"+emailAddress;
			 $.ajax({
				 	type: "POST",
		            url: '${ contextPath }/emailCheck.me',
		            dataType:'json',
		            data: {
		            	emailId:emailId,
		            	emailAddress:emailAddress
						},
		            async: false,
		            success: function(data){
		            	  if(data){
								useEmail = true;
				          }
				          else if(orginalEmail == email){
				        	  $("#emailResult").text("기존 이메일입니다.").css("color","red");
				        	  useEmail = false;	
				          }
				          else{
				        		$("#emailResult").text("등록된 이메일이 존재합니다.").css("color","red");
				        		useEmail = false;	
				          }
			            },
			            error: function(data){
			               alert("ajax 중복체크 에러 발생");
			            }
		    });
		            return useEmail;
		}
		function checkKey(){
			let key = $('#key').val();
			emailCheck($("#emailId").val(),$("#selectEmail").val());
			if(useEmail){
				if(key == "${sessionScope.AuthenticationKey }"){
// 					 alert("인증 되었습니다");
					sweetAlert("인증 되었습니다");
					var eamilStr = $("#receiveMail").val().split('@');
					if(opener.document.getElementById("updateForm")){//회원 정보수정
						opener.document.updateForm.emailId.value = eamilStr[0];
						opener.document.updateForm.emailAddress.value = eamilStr[1];
// 						console.log("emailId : " + opener.document.updateForm.emailId.value);
// 						console.log("emailAddress : " + opener.document.updateForm.emailAddress.value);
						self.close();
					}else{//회원가입
						opener.document.insertForm.emailId.value = eamilStr[0];
						opener.document.insertForm.emailAddress.value = eamilStr[1];
// 						console.log("emailId : " + opener.document.insertForm.emailId.value);
// 						console.log("emailAddress : " + opener.document.insertForm.emailAddress.value);
						self.close();
					}
				}else{
// 					 alert("인증코드가 틀렸습니다");
					 sweetAlert("인증코드가 틀렸습니다");
				}
			}else{
// 				alert("이메일이 올바르지 않습니다.");
				sweetAlert("이메일이 올바르지 않습니다.");
				}
		}
		//이메일 선택
	    function selectMail(){
	        var email = $("#email_select").val();
	        $("#emailResult").text("");
	        if(email == "직접입력"){
	            $("#selectEmail").val("");
	        }else{
	            $("#selectEmail").val(email);
	        }
	        
	    }
	    $('#selectEmail').on('click', function(){
	    	$("#emailResult").text("");
	    });
	    $('#emailId').on('click', function(){
	    	$("#emailResult").text("");
	    });
		
	</script>
</body>
</html>
