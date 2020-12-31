<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_memberInfo.css" type="text/css">
	
	<!-- 카카오 API -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!-- 다음주소API -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
</head>
<body>
	<%@ include file="../common/header.jsp"%>
    <main>
    	<%@ include file="../common/member-aside.jsp"%>
        <section style="margin: 0px;">
			<h1 id="memberInfo">회원 정보</h1>
            <form action="memberUpdate.me" method="post" id="updateForm" name="updateForm"onsubmit="return checkUpdate();">
				<table align="center">
	                <tr>
	                    <td width="150px">아이디</td>
	                    <td width="auto">
	                        <input type="text" name="userId" class="text_box"  value="${ loginUser.userId }" readonly>
	                        <input type="hidden" name="userKakao" id="kakaoId"  value="${ loginUser.userKakao }">
	                    </td>
	                </tr>
	                <tr>
	                    <td>닉네임</td>
	                    <td><input class="text_box" name="userNickName" type="text" id=nickName value="${ loginUser.userNickName }" required>
	                    	<label id="nickNameResult"></label>
	                    </td>
	                    
	                </tr>
	                <tr>
	                    <td>이름 </td>
	                    <td><input type="text" name="userName" class="text_box" value="${ loginUser.userName }" readonly></td>
	                </tr>
	                <tr>
	                    <td>생년월일</td>
	                    <td><input type="date" name="userBirthday" class="text_box" value="${ loginUser.userBirthday }" readonly></td>
	                </tr>
					<tr>
						<td>성별</td>
						<input type="hidden" name="userGender" value="${ loginUser.userGender }"/>
						<c:if test="${ loginUser.userGender eq 'M'}">
							<td><input type="text" name="gender" class="text_box" value="남자" readonly></td>
						</c:if>
						<c:if test="${ loginUser.userGender eq 'F'}">
							<td><input type="text" name="gender" class="text_box" value="여자" readonly></td>
						</c:if>
					</tr>
	                <tr>
	                	<td>주소</td>
		                <c:forTokens var="addr" items="${ loginUser.userAddress }" delims="/" varStatus="status">
							<c:if test="${ status.index eq 0 && addr >= '0' && addr <= '99999' }">
								<c:set var="post" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 0 && !(addr >= '0' && addr <= '99999') }">
								<c:set var="address1" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 1 }">
								<c:set var="address1" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 2 }">
								<c:set var="address2" value="${ addr }"/>
							</c:if>
						</c:forTokens>
	                    <td>
	                    	<input type="text" name="post" class="text_box" id="sample6_postcode" value="${ post }" placeholder="우편번호" readonly>
	                    	<input type="button" id="post_btn" class="hide_item" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
	                    </td>
	                </tr>
	                <tr>
	                    <td></td><!--빈공간-->	
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
	                    <td>이메일</td>
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
	                        <input type="button" id="email_btn" class="hide_item" onclick="email_Check()" value="이메일 변경">
	                        <input type="button" id="kakao_btn" class="hide_item" onclick="loginFormWithKakao()" value="카카오 인증">
	                    </td>
	                </tr>
	                <c:forTokens var="phone" items="${ loginUser.userPhone }" delims="-" varStatus="status">
						<c:if test="${ status.index eq 0 }">
							<c:set var="phone1" value="${ phone }"/>
						</c:if>
						<c:if test="${ status.index eq 1 }">
							<c:set var="phone2" value="${ phone }"/>
						</c:if>
						<c:if test="${ status.index eq 2 }">
							<c:set var="phone3" value="${ phone }"/>
						</c:if>
					</c:forTokens>
	                <tr>
	                    <td>연락처</td>
	                    <td>
	                        <input type="tel" maxlength="3" name="phone1" class="text_box" value="${ phone1 }"> -
	                        <input type="tel" maxlength="4" name="phone2" class="text_box" value="${ phone2 }"> -
	                        <input type="tel" maxlength="4" name="phone3" class="text_box" value="${ phone3 }">
	                    </td>
	                </tr>
		                <c:forTokens var="interst" items="${ loginUser.userInterst }" delims="," varStatus="status">
							<c:if test="${ status.index eq 0}">
								<c:set var="interst0" value="${ interst }"/>
							</c:if>
							<c:if test="${ status.index eq 1 }">
								<c:set var="interst1" value="${ interst }"/>
							</c:if>
							<c:if test="${ status.index eq 2 }">
								<c:set var="interst2" value="${ interst }"/>
							</c:if>
							<c:if test="${ status.index eq 3 }">
								<c:set var="interst3" value="${ interst }"/>
							</c:if>
						</c:forTokens>
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
	                <input type="button" class="hide_item" id="cancleBtn" value="취소" onclick="cancle()">
	                <input type="submit" class="btn_memberUpdate" id="submitBtn" value="회원 수정" >
	                <input type="checkbox" id="checkBtn" hidden="hide">
	            </div>
	        </form>    
        </section>
    </main>
    <%@ include file="../common/footer.jsp"%>
    <script>
    	let isNickName=true;
	  //페이지 처음 들어올때 실행되는것들
	    (function init(){
	    	var interst0 = '<c:out value="${interst0}"/>';
	    	var interst1 = '<c:out value="${interst1}"/>';
	    	var interst2 = '<c:out value="${interst2}"/>';
	    	var interst3 = '<c:out value="${interst3}"/>';
	    	if(interst0 == "자연"){
	    		$('input[id="자연"]').prop("checked",true);
	    	}
	    	if(interst0 == "생물" || interst1 == "생물"){
	    		$('input[id="생물"]').prop("checked",true);
	    	}
	    	if( interst0 == "재생 에너지" || interst1 == "재생 에너지" || interst2 == "재생 에너지"){
	    		$('input[id="재생 에너지"]').prop("checked",true);
	    	}
	    	if( interst0 == "친환경 제품" || interst1 == "친환경 제품" || interst2 == "친환경 제품" || interst3 == "친환경 제품"){
	    		$('input[id="친환경 제품"]').prop("checked",true);
	    	}
	
			$('.text_box').attr("disabled",true); 
			$('input[type = "checkbox"]').attr("disabled",true); 
			$('#checkBtn').removeAttr("disabled");
			$('.hide_item').hide();
	    }());
	    //이메일 선택
	    function selectMail(){
	        var email = $("#email_select").val();
	        if(email == "직접입력"){
	            $("#selectEmail").val("");
	        }else{
	            $("#selectEmail").val(email);
	        }
	        
	    }
	    //정보 수정 버튼 눌렀을때
	    function checkUpdate(){
	    	$("#checkBtn").click();
	    	//submit
	    	if($("#checkBtn").is(":checked") != true){
	    		 var checkArr = [];     // 배열 초기화
	    		 if(isNickName){
	    		    $("input[name='userInterst']:checked").each(function(i){
	    		        checkArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
	    		    });
	    			return true;
	    		 }else{
// 	    			  alert("올바른 닉네임을 입력해주세요");
	    			  sweetAlert("올바른 닉네임을 입력해주세요");
	    			  $("#nickName").focus();
	    			   return false;
	    		 }
	    		 
	    	}
	    	else{
	    		//회원 정보 수정
	    		$('.text_box').removeAttr("disabled");
				$('input[type = "checkbox"]').removeAttr("disabled");
				$('.hide_item').show();
	    		return false;
	    	}
	    }
	    //취소했을때 새로고침
	  	function cancle(){
	  		location.reload();
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
// 	console.log(Kakao.isInitialized());
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
//					                console.log(response);
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
	  //닉네임 중복 체크
	  $('#nickName').focusout(function(){
			var nickName = $(this).val().trim();
			var orginalNcik = "${ loginUser.userNickName }";
			 $("#nickNameResult").show();
			 var regExp =  /^[가-힣a-zA-Z0-9]{3,10}$/;
// 			 console.log($(this).val());
			 if($(this).val()==""){
				$("#nickNameResult").text("");
				isNickName = false;
				return;
			}
			else if(!regExp.test($(this).val())){
				$("#nickNameResult").text("3~10자, 특수문자는 안됩니다.").css("color","red");
				$(this).focus();
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
	  //이메일 인증창
	  function email_Check(){
		  var targetTitle = "emailCheckForm";
		  var popupWidth = 580;
		  var popupHeight = 320;
	
		  // 듀얼 모니터 기준
		  var left = (screen.availWidth - popupWidth) / 2;
// 		  console.log("window.screenLeft : " + window.screenLeft);
// 		  console.log("window.screen.width*-1 : " + window.screen.width*-1);
// 		  console.log("window.screen.width : " + window.screen.width);
		  
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
	  	//카카오 이메일 중복확인
		function emailCheck(email){
			var useEmail = false;
			var eamilStr = email.split('@');
			var emailId = eamilStr[0];
			var emailAddress = eamilStr[1];
			var orginalEmail = "${ loginUser.userEmail }";
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
// 		        		alert("인증성공!");
		        		sweetAlert("인증성공!");
						useEmail = true;
		          	}
		          	else if(orginalEmail == email){
// 		        		alert("기존 이메일입니다.");
		        		sweetAlert("기존 이메일입니다.");
		        		useEmail = false;	
		          	}
		          	else{
// 		        	  	alert("등록된 이메일이 존재합니다.");
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
    </script>
</body>
</html>