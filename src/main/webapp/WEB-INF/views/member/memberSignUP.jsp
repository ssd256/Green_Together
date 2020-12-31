<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="utf-8">
	
	<title>함께 그린</title>
	<!-- 카카오 API -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!-- 다음주소API -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberSignUP.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<section>
		<h1 id="memberInfo">회원가입</h1>
		<form action="minsert.me" method="post" id="insertForm" name="insertForm">
<!-- 		<form action="minsert.me" method="post" id="insertForm" name="insertForm" onsubmit="return memberInsert();"> -->
		<table id="memberTable">
			<tr>
				<td width="150px">*아이디</td>
				<td width="auto">
					<input type="hidden" name="userKakao" id="kakaoId" value="0">
					<input type="text" name="userId" id="userId" class="text_box" maxlength="10" placeholder="5~10자의 영문,숫자" required>
					<label id="idResult"></label>
				</td>
	        </tr>
	        <tr>
	        	<td width="150px">*비밀번호</td>
	        	<td>
	        		<input type="password" maxlength="20" name="userPwd" id="pwd1" class="text_box" placeholder="8자이상 영문,숫자,!@#$%^&*" required>
					<label id="pwd1Result"></label>
	        	</td>
	        </tr>
	        <tr>
	        	<td width="150px">*비밀번호 확인</td>
	        	<td>
	        		<input type="password" maxlength="20" name="userPwdCheck" id="pwd2" class="text_box" required>
					<label id="pwd2Result"></label>
				</td>	
	        </tr>
	        <tr>
				<td>*닉네임</td>
	            <td>
	            	<input class="text_box" name="userNickName" type="text" id=nickName placeholder="3~10자 특수문자 제외" required>
	              	<label id="nickNameResult"></label>
	            </td>
			</tr>
	        <tr>
				<td>*이름 </td>
	            <td>
	            	<input type="text" name="userName" id="userName" class="text_box" placeholder="2자이상 한글" required>
	            	<label id="nameResult"></label>
	            </td>
			</tr>
	        <tr>
				<td>*생년월일</td>
	            <td><input type="date" id="userBirthday" name="userBirthday" class="text_box" required></td>
			</tr>
			<tr>
				<td>*성별</td>
				<td>
					<input type="radio" name="userGender" value="M" required>남자
					<input type="radio" name="userGender" value="F" required>여자
				</td>
			</tr>
	        <tr>
				<td>*주소</td>
	              <td><input type="text" name="post" class="text_box" id="sample6_postcode" value="${ post }" placeholder="우편번호" readonly>
	              <input type="button" id="post_btn" class="hide_item" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
	        </tr>
	        <tr>
				<td><!--빈공간--></td>	
	            <td><input type="text" name="address1" id="sample6_address" class="text_box" value="${ address1 }" placeholder="주소" readonly>
	            	<input type="text" name="address2" id="sample6_detailAddress" class="text_box" value="${ address2 }" placeholder="상세주소"></td>
	        </tr>
			<c:forTokens var="email" items="${ loginUser.userEmail }" delims="@" varStatus="status">
				<c:if test="${ status.index eq 0}">
					<c:set var="emailId" value="${ email }"/>
				</c:if>
				<c:if test="${ status.index eq 1 }">
					<c:set var="emailAddress" value="${ email }"/>
				</c:if>
			</c:forTokens>
	        <tr>
				<td>*이메일</td>
				<td>
					<input type="text" name="emailId" class="text_box" id="emailId" value="${ emailId }" readonly> @ 
	                <input type="text" name="emailAddress"  class="text_box" id="emailAddress" id="selectEmail" value="${ emailAddress }" readonly>
	<!-- 	                    <span class="hide_item">     -->
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
	                <input type="button" id="email_btn" class="hide_item" onclick="email_Check()" value="이메일 인증">
	                <input type="button" id="kakao_btn" class="hide_item" onclick="loginFormWithKakao()" value="카카오 인증">
	        	</td>
	        </tr>
	        <tr>
		        <td>*연락처</td>
		        <td>
		            <input type="tel" maxlength="3" name="phone1" id="tel1" class="text_box"> -
		            <input type="tel" maxlength="4" name="phone2" id="tel2" class="text_box"> -
		            <input type="tel" maxlength="4" name="phone3" id="tel3" class="text_box">
		        </td>
	        </tr>
	        <tr>
		        <td>관심분야</td>
		        <td>
		         <input type="checkbox" name="userInterst" id="자연" value="자연">자연 
		         <input type="checkbox" name="userInterst" id="생물" value="생물">생물
		         <input type="checkbox" name="userInterst" id="재생 에너지" value="재생 에너지">재생 에너지 
		         <input type="checkbox" name="userInterst" id="친환경 제품" value="친환경 제품">친환경 제품 
		        </td>
	        </tr>
			<tr>
	       		<td>직업</td>
	            <td><input type="text" name="userJob" class="text_box" value="${ loginUser.userJob }"></td>
	       </tr>
	      </table>
	      <div id="btn_box">
	          <input type="submit" id="submitBtn" value="회원 가입" >
	      </div>
	  </form>    
  </section>
    <%@ include file="../common/footer.jsp"%>
    <script>
	    let isId=false;
	    let isPwd1=false;
	    let isPwd2=false;
	    let isName=false;
	    let isNickName=false;
	    //아이디 정규표현식 및 중복 검사
	    $('#userId').focusout(function(){
			var id = $(this).val().trim();
			 $("#idResult").show();
			 var regExp =  /^[a-zA-Z0-9]{5,10}$/;
// 			 console.log("id : " + $(this).val());
			if($(this).val()==""){
				$("#idResult").text("");
				isId = false;
				return;
			}
			else if(!regExp.test($(this).val())){
				$("#idResult").text("5~10자, 영어만 가능합니다").css("color","red");
				isId = false;
			}else{
				 $.ajax({
		            url: 'idCheck.me',
		            data: {
	 						userId:id,
					},
		            success: function(data){
			          if(data){
			        		$("#idResult").text("사용 가능한 아이디 입니다").css("color","green");
							$(this).css("background","initial");
							isId = true;
			          }
			          else{
			        		$("#idResult").text("아이디 중복입니다.").css("color","red");
							$(this).focus().css("background","red");
							isId = false;	
			          }
		            },
		            error: function(data){
		               alert("ajax 중복체크 에러 발생");
		            }
			    });
// 				 console.log("isId : " + isId);
			}
		});
	    //비밀번호 정규표현식
	    $('#pwd1').focusout(function(){
			var id = $(this).val().trim();
			$("#pwd1Result").show();
			var regExp = /^[a-zA-Z0-9\!\@\#\$\%\^\&\*]{7,20}$/;
// 			console.log("pwd1 : " + $(this).val());
			if($(this).val()==""){
				$("#pwd1Result").text("");
				isPwd1 = false;
				return;
			}
			else if(!regExp.test($(this).val())){
				$("#pwd1Result").text("8자이상 영문,숫자,!@#$%^&*").css("color","red");
// 				$(this).focus();
				isPwd1 = false;
			}else{
				$("#pwd1Result").hide();
				isPwd1 = true;
			}
		});
	    //비밀번호 확인
	    $('#pwd2').focusout(function(){
	    	if($(this).val()==""){
				$("#pwd2Result").text("");
				isPwd2 = false;
				return;
			}
			else if($("#pwd1").val() != $(this).val()){
				$("#pwd2Result").text("비밀번호 불일치").css("color","red");
				isPwd2 = false;
			}else{
				$("#pwd2Result").html("비밀번호가 일치합니다.").css("color","green");
				isPwd2 = true;
			}
// 	    	console.log($("#pwd1").val() + ':' + $(this).val());
		});
	  	//닉네임 정규표현식 & 닉네임 중복검사
		$('#nickName').focusout(function(){
			var nickName = $(this).val().trim();
			var orginalNcik = "${ loginUser.userNickName }";
			$("#nickNameResult").show();
			var regExp =  /^[가-힣a-zA-Z0-9]{3,10}$/;
// 			console.log($(this).val());
			if($(this).val()==""){
				$("#nickNameResult").text("");
				isNickName = false;
				return;
			}
			else if(!regExp.test($(this).val())){
					$("#nickNameResult").text("3~10자, 특수문자는 안됩니다.").css("color","red");
// 					$(this).focus();
					isNickName = false;
				}else{
					 $.ajax({
				     	url: 'nickNameCheck.me',
			            data: {
		 						userNickName:nickName,
						},
			            success: function(data){
				        	if(data){
				        		$("#nickNameResult").text("사용 가능한 닉네임 입니다").css("color","green");
								$(this).css("background","initial");
								isNickName = true;
				          	}
				          	else if(orginalNcik == nickName){
				        		$("#nickNameResult").hide();
				        	  	isNickName = true;
				          	}
				          	else{
				        		$("#nickNameResult").text("닉네임 중복입니다.").css("color","red");
								$(this).focus().css("background","red");
								isNickName = false;	
				          	}
			            },
				        error: function(data){
				        		alert("ajax 중복체크 에러 발생");
				        }
				    });
				}
			});
			//이름 정규표현식
		    $('#userName').focusout(function(){
				var id = $(this).val().trim();
				$("#nameResult").show();
				var regExp = /^[가-힣]{2,6}$/;
// 				console.log("userName : " + $(this).val());
				if($(this).val()==""){
					$("#nameResult").text("");
					isName = false;
					return;
				}
				else if(!regExp.test($(this).val())){
					$("#nameResult").text("2자이상 한글만 가능합니다").css("color","red");
// 					$(this).focus();
					isName = false;
				}else{
					$("#nameResult").hide();
					isName = true;
				}
			});
		    var sysdate = new Date().toISOString().substring(0, 10); 
			$('#userBirthday').attr('max', sysdate);
		    //이메일 선택
		    function selectMail(){
		        var email = $("#email_select").val();
		        if(email == "직접입력"){
		            $("#selectEmail").val("");
		        }else{
		            $("#selectEmail").val(email);
		        }
		    }
			//주소 API
		    function sample6_execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var addr = ''; // 주소 변수
		            var extraAddr = ''; // 참고항목 변수
		
		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }
		
		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		            } 
		
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('sample6_postcode').value = data.zonecode;
		            document.getElementById("sample6_address").value = addr;
		            document.getElementById("sample6_detailAddress").value = "";
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById("sample6_detailAddress").focus();
		        }
		    }).open();
		}
	  //카카오
		// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('653a6db0dc16539a4a75c733c770dfce');
		// SDK 초기화 여부를 판단합니다.
// 		console.log(Kakao.isInitialized());
		  function loginFormWithKakao() {
			  var result = false;
			  swal({
					text: "전체동의 하셔야 인증됩니다.",
				}).then((ok) => {
					if(ok){
						Kakao.Auth.loginForm({
					      success: function(authObj) {
					      	Kakao.API.request({
					        	url: '/v2/user/me',
					            success: function(response) {
// 					                console.log(response);
					                if(emailCheck(response.kakao_account.email)){
										var eamilStr = response.kakao_account.email.split('@');
										$("#emailId").val(eamilStr[0]);
										$("#emailAddress").val(eamilStr[1]);
										$('#kakaoId').val(response.id);
					                }else{
					                	return false;
					                }
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
				})
		  }
		//카카오 이메일 중복확인
		function emailCheck(email){
			var useEmail = false;
			var eamilStr = email.split('@');
			var emailId = eamilStr[0];
			var emailAddress = eamilStr[1];
		 	$.ajax({
				type: "POST",
	            url: 'emailCheck.me',
	            dataType:'json',
	            data: {
	            	emailId:emailId,
	           		emailAddress:emailAddress
				},
	            async: false,
	            success: function(data){
		        	if(data){
		        		sweetAlert("인증성공!");
						useEmail = true;
		          	}else{
		        	  	sweetAlert("등록된 이메일이 존재합니다.");
		        		useEmail = false;	
		          	}
	            },
	            error: function(data){
	               alert("ajax 중복체크 에러 발생");
	            }
	    	});
	        return useEmail;
		}
		//이메일 인증 창 띄우기
		function email_Check(){
			var targetTitle = "emailCheckForm";
			var popupWidth = 580;
			var popupHeight = 320;
		
			// 듀얼 모니터 기준
			var left = (screen.availWidth - popupWidth) / 2;
// 			console.log("window.screenLeft : " + window.screenLeft);
// 			console.log("window.screen.width*-1 : " + window.screen.width*-1);
// 			console.log("window.screen.width : " + window.screen.width);
			  
			if( window.screenLeft < 0){
				left += window.screen.width*-1;
			}
			else if ( window.screenLeft >= window.screen.width ){
				left += window.screen.width;
			}
		
		  	var top = (screen.availHeight - popupHeight) / 2 - 10;
		
			var url = "checkEmailForm.me"; 
			var options = 'resizable=no,left=' + left + ',top=' + top +', width=' + popupWidth+ ',height=' + popupHeight +',menubar=no, status=no, toolbar=no, location=no, scrollbars=yes';
			window.open(url, targetTitle,options);
		}
		//가입전 체크
		$(document).on('click', '#submitBtn', function(e) {
    		e.preventDefault();
			var regExp = /^[0-9]/;
			let addr = $("#sample6_address").val();
			let email = $("#emailId").val();
			let userBirthday = $("#userBirthday").val();
			let userGender = $('input[name=userGender]:checked').val();
// 			console.log("userBirthday :" + userBirthday);
// 			console.log("userGender :" + userGender);
// 			console.log("addr.length :" + addr.length);
// 			console.log("email.length :" + email.length);
			if(!isId){
				sweetAlert("올바른 ID를 입력해주세요");
				$("#userId").focus();
			}else if(!isPwd1){
				sweetAlert("올바른 비밀번호를 입력해주세요");
				$("#pwd1").focus();
			}else if(!isPwd2){
				sweetAlert("올바른 비밀번호를 입력해주세요");
				$("#pwd2").focus();
			}else if(!isNickName){
				sweetAlert("올바른 닉네임을 입력해주세요");
				$("#nickName").focus();
			}else if(!isName){
				sweetAlert("올바른 이름을 입력해주세요");
				$("#userName").focus();
			}else if(userBirthday == ""){
				sweetAlert("생년월일을 선택 해주세요");
			}else if(userGender == null || userGender == 'undefined'){
				sweetAlert("성별을 선택 해주세요");
			}else if(addr.length == 0){
				sweetAlert("주소를 입력해주세요");
			}else if(email.length == 0){
				sweetAlert("이메일를 입력해주세요");
			}else if(!regExp.test($("#tel1").val()) &&
					 !regExp.test($("#tel2").val()) &&
					 !regExp.test($("#tel3").val())){
				sweetAlert("올바른 번호를 입력해주세요");
				$("#tel1").focus();
			}
			else{
				swal({
					text: '회원가입이 완료되었습니다. 로그인 해주세요!',
				}).then((ok) => {
					if(ok){
						  $('#insertForm').submit();
					}
				})
			}
		});
		
    </script>
</body>
</html>