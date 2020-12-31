<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
	<meta charset="UTF-8">
	<title>함께 그린 - 회원 정보 찾기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/searchUserForm.css" type="text/css">
	</head>
<body>
	<div style="display: none;">
		<%@ include file="../common/header.jsp"%>
	</div>
	<div class="tab_wrap">
		<div class="tab_menu_container">
			<button class="tab_menu_btn on" id="id_box"type="button">아이디 찾기</button>
	        <button class="tab_menu_btn off"id="pwd_box" type="button">비밀번호 찾기</button>
        </div>
        <div id ="tabHr"></div>
        <div class="tab_box_container">
        	<div class="tab_box on">
        	<form method="post" action="${ contextPath }/email/searchId.do" id="searchIdForm">
				<input type="hidden" name="senderName" value="함께그린">
				<input type="hidden" name="senderMail" value="cjddnseo11@naver.com">
				<input type="hidden" name="subject" value="함께그린 인증 메일입니다"><br>
	            <input type="hidden" id="receiveIdMail" name="receiveIdMail" value="${receiveIdMail}"/>
            	<table class="contentsTable">
            		<tr>
            			<td><input type="hidden"/></td>
            		</tr>
                	<tr>
				        <td>이메일 주소</td>
				        <td>
				            <c:if test="${!empty receiveIdMail}">
				            	<c:forTokens var="email" items="${ receiveIdMail }" delims="@" varStatus="status">
									<c:if test="${ status.index eq 0}">
										<c:set var="emailId" value="${ email }"/>
									</c:if>
									<c:if test="${ status.index eq 1 }">
										<c:set var="emailAddress" value="${ email }"/>
									</c:if>
								</c:forTokens>
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
				            <c:if test="${empty receiveIdMail}">
            					<input type="text" name="emailId" class="text_box" id="emailId"> @ 
	                			<input type="text" name="emailAddress"  class="text_box" id="selectEmail">
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
				            	<input id="emailCheck_btn" type="submit"  value="인증"/><br>
				        </td>
				    </tr>
	   				<tr>
						<td><input type="hidden"></td>
				    	<td>
				            <label id="emailIdResult"></label>
				    	</td>
				    </tr>
					<tr>
						<td><input type="hidden"></td>
						<td>${Idmessage}</td>
					</tr>
					<tr>
<%-- 					<c:out value="${AuthenticationKey}"/> --%>
						<c:if test="${!empty AuthenticationKey}">
							<td>인증코드</td>
							<td> 
								<input type="text" id="idKey" name="key"/>
							</td>
						</c:if>
					</tr>
                </table>
               	</form>
                <div class="btn_box">
					<input type="button" class="btn" id="cancleBtn" value="취소" onclick="window.close();">
					<input type="button" class="btn" id="usedId" value="확인" onclick="checkIdKey();">
			    </div>
            </div>
            <div class="tab_box">
	        	<form method="post" action="${ contextPath }/email/searchPwd.do" id="searchPwdForm">
					<input type="hidden" name="senderName" value="함께그린">
					<input type="hidden" name="senderMail" value="cjddnseo11@naver.com">
					<input type="hidden" name="subject" value="함께그린 인증 메일입니다"><br>
		            <input type="hidden" class="pwdbox" id="receivePwdMail" name="receivePwdMail" value="${receivePwdMail}">
	            	<table class="contentsTable">
	                	<tr>
					        <td>아이디</td>
					        <td>
						        <c:if test="${!empty searchId}">
					           		<input type="text" class="pwdbox" id="searchPwdId" name="searchPwdId" maxlength="10" value="${searchId}">
									<label id="idResult"></label>
						        </c:if>
						        <c:if test="${empty searchId}">
					           		<input type="text" class="pwdbox" id="searchPwdId" name="searchPwdId" maxlength="10" required>
									<label id="idResult"></label>
						        </c:if>
					        </td>
					    </tr>
	                	<tr>
					        <td>이메일 주소</td>
					        <td>
					            <c:if test="${!empty receivePwdMail}">
						            <c:forTokens var="email" items="${ receivePwdMail }" delims="@" varStatus="status">
										<c:if test="${ status.index eq 0}">
											<c:set var="pwdEmailId" value="${ email }"/>
										</c:if>
										<c:if test="${ status.index eq 1 }">
											<c:set var="pwdEmailAddress" value="${ email }"/>
										</c:if>
									</c:forTokens>
					           		<input type="text" name="pwdEmailId" class="text_box" id="pwdEmailId" value="${ pwdEmailId }"> @ 
		                			<input type="text" name="pwdEmailAddress"  class="text_box" id="pwdEmailAddress" value="${ pwdEmailAddress }">
				                    <span>    
				                        <select class="email_box" id="pwdEmail_select"  onchange="selectPwdMail()">
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
					            <c:if test="${empty receivePwdMail}">
					           		<input type="text" name="pwdEmailId" class="text_box" id="pwdEmailId"> @ 
		                			<input type="text" name="pwdEmailAddress"  class="text_box" id="pwdEmailAddress">
				                    <span>    
				                        <select class="email_box" id="pwdEmail_select"  onchange="selectPwdMail()">
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
					            	<input id="emailCheck_btn" type="submit"  value="인증"><br>
					        </td>
					    </tr>
		   				<tr>
		   					<td><input type="hidden"></td>
					    	<td>
					            <label id="emailPwdResult"></label>
					    	</td>
					    </tr>
						<tr>
							<td><input type="hidden"></td>
							<td>${Pwdmessage}</td>
						</tr>
						<tr>
<%-- 						<c:out value="${AuthenticationKey}"/> --%>
							<c:if test="${!empty AuthenticationKey}">
								<td>인증코드</td>
								<td> 
									<input type="text" id="pwdKey" name="key"/>
								</td>
							</c:if>
						</tr>
	                </table>
				</form>	
	            <div class="btn_box">
					<input type="button" class="btn" id="cancleBtn" value="취소" onclick="window.close()();">
					<input type="button" class="btn" id="usedId" value="확인" onclick="checkPwdKey();">
			    </div>
            </div>
        </div>
    </div>
	<script>
		let isId=true;
		//아이디 찾기  비밀번호 찾기 구별후 맞는 화면 나타내기
		function init(){
// 			console.log("${search}");
			if("${search}" != "Id"){
		         $('#id_box').addClass('off');
				 $('#id_box').removeClass('on');
		         $('#pwd_box').addClass('on');
		         $('#pwd_box').removeClass('off');
	
		         //컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
		         var idx = $('.tab_menu_btn on').index('.tab_menu_btn on');
	
		         $('.tab_box').hide();
		         $('.tab_box').eq(idx).show();
			}
		}
		init();
	 	$('.tab_menu_btn').on('click', function() {
        	//버튼 색 제거,추가
         	$('.tab_menu_btn').removeClass('on');
	        $('.tab_menu_btn').addClass('off');
	        $(this).addClass('on');
	        $(this).removeClass('off');

         	//컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
         	var idx = $('.tab_menu_btn').index(this);

   	      	$('.tab_box').hide();
         	$('.tab_box').eq(idx).show();
      	});
	 	function checkIdKey(){
			let idKey = $('#idKey').val();
			var regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
// 			console.log($("#receiveIdMail").val());
// 			if(regExp.test($("#receiveMail").val()) && useEmail){
			if(regExp.test($("#receiveIdMail").val())){
				if(idKey == "${sessionScope.AuthenticationKey }"){
// 					alert("인증 되었습니다");
// 					sweetAlert("인증 되었습니다");
					swal({
						title : '인증 확인',
						text : '인증되었습니다.',
						icon : 'success'
					}).then((ok) => {
						if(ok){
							location.href='${ contextPath }/searchId.me?userEmail='+"${receiveIdMail}";
						}
					});
				}else{
// 					 alert("인증코드가 틀렸습니다");
					 sweetAlert("인증코드가 틀렸습니다");
				}
			}else{
// 				alert("이메일이 올바르지 않습니다.");
				sweetAlert("이메일이 올바르지 않습니다.");
			}
		}
	 	function checkPwdKey(){
			let pwdKey = $('#pwdKey').val();
			var regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
// 			console.log($("#receivePwdMail").val());
// 			if(regExp.test($("#receiveMail").val()) && useEmail){
			if(regExp.test($("#receivePwdMail").val()) && isId){
				if(pwdKey == "${sessionScope.AuthenticationKey }"){
// 					alert("인증 되었습니다");
// 					sweetAlert("인증 되었습니다");
					swal({
						title : '인증 확인',
						text : '인증되었습니다.',
						icon : 'success'
					}).then((ok) => {
						if(ok){
							location.href='${ contextPath }/searchPwd.me?userEmail='+"${receivePwdMail}";
						}
					});
				}else{
// 					 alert("인증코드가 틀렸습니다");
					 sweetAlert("인증코드가 틀렸습니다");
				}
			}else{
// 				alert("아이디 또는 이메일이 올바르지 않습니다.");
				sweetAlert("아이디 또는 이메일이 올바르지 않습니다.");
			}
		}
	 	//아이디 확인
    	$('#searchPwdId').change(function(){
			var id = $(this).val().trim();
		 	$("#idResult").show();
		 	$.ajax({
	        	url: '${ contextPath }/idCheck.me',
	            data: {
 						userId:id,
				},
	            success: function(data){
	        		if(data){
		        		$("#idResult").text("아이디가 없음").css("color","red");
						$(this).focus().css("background","red");
						isId = false;	
		          	}
		          	else{
			        	$("#idResult").hide();
						isId = true;
		          	}
	            },
	            error: function(data){
	               alert("ajax 중복체크 에러 발생");
	            }
	    	});
		});
	 
  		//아이디 찾기 전 이메일 체크
		$('#searchIdForm').submit(function(event){
			// 자동 submit을 시키는 것을 막는다. 
			event.preventDefault();
			let isEmail = false;
			let emailId = $("#emailId").val();
			let emailAddress = $("#selectEmail").val();
			var checkPwd = false;
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
		        	if(!data){
		        		isEmail = true;
		        	}
		        	else{
			        	$("#emailIdResult").show();
			        	$("#emailIdResult").text("이메일이 존재하지 않습니다.").css("color","red");
			        	isEmail = false;	
		        	}
	        	},
	        	error: function(data){
	            	alert("ajax 에러 발생");
	               	isEmail = false;	
	        	}
			});
			if(isEmail){
				event.currentTarget.submit();
			}
		});
  	  	//이메일 텍스트 클릭시 에러메세지 숨김
	  	$('#receiveIdMail').click(function(){
			$("#emailIdResult").hide();
	  	});
  		//비밀번호 찾기 전 이메일 아이디 체크
		$('#searchPwdForm').submit(function(event){
			// 자동 submit을 시키는 것을 막는다. 
			event.preventDefault();
			let isEmail = false;
			let emailId = $("#pwdEmailId").val();
			let emailAddress = $("#pwdEmailAddress").val();
			let userId = $("#searchPwdId").val();
			var checkPwd = false;
			$.ajax({
				type: "POST",
	        	url: '${ contextPath }/searchPwdCheck.me',
	           	dataType:'json',
	           	data: {
	           		emailId:emailId,
	           		emailAddress:emailAddress,
	           		userId:userId
				},
	           	async: false,
	           	success: function(data){
			        if(data){
			        	isEmail = true;
			        }
		        	else{
		        		if(isId){
			        		$("#emailPwdResult").show();
			        		$("#emailPwdResult").text("이메일이 존재하지 않습니다.").css("color","red");
		        		}else{
			        		$("#emailPwdResult").show();
			        		$("#emailPwdResult").text("아이디를 확인해주세요").css("color","red");
		        		}
		        		isEmail = false;	
		        	}
	        	},
	        	error: function(data){
	            	alert("ajax 에러 발생");
	               	isEmail = false;	
	        	}
			});
			if(isEmail && isId){
				 event.currentTarget.submit();
			 }
			else if(!isId){
// 				alert("아이디를 확인해주세요");
				sweetAlert("아이디를 확인해주세요");
				return false;
			}else{
// 				alert("아이디 및 이메일을 확인해주세요");
				sweetAlert("아이디 및 이메일을 확인해주세요");
				return false;
			}
		});
  	  	//아이디 및 비밀번호 수정시 에러메세지 숨김
	  	$('#searchPwdId').click(function(){
			$("#idResult").hide();
	  	});
		$('#receivePwdMail').click(function(){
			$("#emailPwdResult").hide();
	  	});
		//이메일 선택
	    function selectMail(){
	        var email = $("#email_select").val();
	        if(email == "직접입력"){
	            $("#selectEmail").val("");
	        }else{
	            $("#selectEmail").val(email);
	        }
	        
	    }
		//비밀번호 찾기 이메일 선택
	    function selectPwdMail(){
	        var email = $("#pwdEmail_select").val();
	        if(email == "직접입력"){
	            $("#pwdEmailAddress").val("");
	        }else{
	            $("#pwdEmailAddress").val(email);
	        }
	        
	    }
	</script>
</body> 
</html>