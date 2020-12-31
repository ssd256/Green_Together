<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="UTF-8">
	<title>함께그린 - 로그인</title>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/loginView.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<form action="login.me" method="post" id="loginCheck">
		<div class="loginbox">
			<!--referer 이전 페이지 정보 -->
			<input type="hidden" name="referer" value=${ referer }>
            <h1 style="margin:0px;">로그인</h1>
            <table>
            	<tr>
                	<td><input type="text" name="userId" id="userId" class="logintext" placeholder="아이디를 입력해주세요" autofocus tabindex="1" required></td>
                  	<td rowspan="2"><button type="submit"id=loginButton autofocus tabindex="3">로그인</button></td>
               	</tr>
               	<tr>
                  	<td><input type="password" name="userPwd" id="userPwd" class="logintext" placeholder="비밀번호를 입력해주세요" autofocus tabindex="2" required></td>
               	</tr>
               	<tr>
	               	<td>
		           		<label id="loginResult"></label>
		    		</td>
               	</tr>
               	<tr>
               		<td>
		            	<input type="checkbox" name="loging" value="loging"/>로그인 유지
		            <td>
               	</tr>
            </table>
            <p align="center" id="ptag">
         		<input type="button" id="searchId_btn" class="btn" onclick="search('Id')" value="아이디 찾기"> |
            	<input type="button" id="searchPwd_btn" class="btn" onclick="search('Pwd')" value="비밀번호 찾기"> |
                <a href="signUp.me">회원가입</a>
            </p>
            <a id="login-form-btn" href="javascript:loginFormWithKakao()">
  				<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222"/>
			</a>
         </div>
	</form>
	<%@ include file="../common/footer.jsp"%>
	<script type="text/javascript">
		//--카카오 로그인 관련
		// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('653a6db0dc16539a4a75c733c770dfce');
		
		// SDK 초기화 여부를 판단합니다.
// 		console.log(Kakao.isInitialized());
		function loginFormWithKakao() {
			Kakao.Auth.loginForm({
				success: function(authObj) {
				//showResult(JSON.stringify(authObj))
		        	Kakao.API.request({
		            	url: '/v2/user/me',
		            	success: function(response) {
// 		                	console.log(response);
							//console.log(response.kakao_account.email);
							//console.log(response.properties.nickname);
		                	kakaoLogin(response.id,response.kakao_account.email);
		            	},
		            	fail: function(error) {
		                	console.log(error);
		            	}
		        	});
				},
		      	fail: function(err) {
		        	showResult(JSON.stringify(err))
		      	},
	    	})
		}
	  	function kakaoLogin(id,email){
	  		let referer = "${referer}";
		  location.href = '<%=request.getContextPath()%>/kakaoLogin.me?email='+ email +'&id=' + id + '&referer=' + referer;
	 	}
	    //카카오 로그인 관련--
	  	//이메일 인증창
	  	function search(search){
			var targetTitle = "searchIdForm";
			var popupWidth = 600;
			var popupHeight = 800;
		
			// 듀얼 모니터 기준
			var left = (screen.availWidth - popupWidth) / 2;
			
			if( window.screenLeft < 0){
				left += window.screen.width*-1;
			}
			else if ( window.screenLeft >= window.screen.width ){
				left += window.screen.width;
			}
		
			var top = (screen.availHeight - popupHeight) / 2 - 10;
			
			var url = search=="Id" ? "searchIdForm.me" : "searchPwdForm.me"; 
			var options = 'resizable=no,left=' + left + ',top=' + top +', width=' + popupWidth+ ',height=' + popupHeight +',menubar=no, status=no, toolbar=no, location=no, scrollbars=yes';
			window.open(url, targetTitle,options);
		}
	    
	  	//로그인전 아이디 비밀번호 체크
		$('#loginCheck').submit(function(event){
			// 자동 submit을 시키는 것을 막는다. 
			event.preventDefault();
			let isLogin = false;
			let userPwd = $("#userPwd").val();
			let userId = $("#userId").val();
			var checkPwd = false;
			$.ajax({
				type: "POST",
		        url: 'loginCheck.me',
		           dataType:'json',
		           data: {
		           	userPwd:userPwd,
		           	userId:userId
					},
		           async: false,
		           success: function(data){
			        if(data){
			        	isLogin = true;
			        }
			        else{
			        	$("#loginResult").show();
			        	$("#loginResult").text("잘못된 정보입니다.").css("color","red");
			        	isLogin = false;	
			        }
		        },
		        error: function(data){
		               	alert("ajax 에러 발생");
		               	isLogin = false;	
		        }
			});
			if(isLogin){
				 event.currentTarget.submit();
			 }
		});
		//아이디 및 비밀번호 수정시 에러메세지 숨김
		$('.logintext').click(function(){
			$("#loginResult").hide();
		});
	</script>
</body>
</html>