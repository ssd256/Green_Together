<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage_memberDelete.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
	<%@ include file="../common/member-aside.jsp"%>
		<section>
	        <h2 align = center>회원 탈퇴</h2>
	        <div class="centerText">
		        <form action="memberDelete.me" method="post" id="deleteForm" name="deleteForm">
			        <input type="hidden" name="userId" id="userId"  value="${ loginUser.userId }">
			        <table>
			        	<tr>
			            	<td width="150px"><b/>비밀번호</td>
			                <td>
			                 <input type="password"  id="userPwd" maxlength="20" class="text_box" placeholder="비밀번호">
			                </td>
			            </tr>
					</table>
					<div class="btn_box">
						<input type="submit" class="box_height" id="submitBtn" value="탈퇴" >
			   	 	</div>
		        </form>
	        </div>
        </section>
    </main>
    <%@ include file="../common/footer.jsp"%>
    <script>
    $('#deleteForm').submit(function(event){
		// 자동 submit을 시키는 것을 막는다. 
		event.preventDefault();
		let isPwd = false;
		let pwd = $("#userPwd").val().trim();
		let id = "${ loginUser.userId }";
		var checkPwd = false;
			$.ajax({
				type: "POST",
		        url: 'checkPwd.me',
	            dataType:'json',
	            data: {
	            	userPwd:pwd,
	            	userId:id
					},
	            async: false,
	            success: function(data){
			        if(data){
// 			        	alert("탈퇴 되었습니다.");
// 			        	sweetAlert("탈퇴 되었습니다.");
			        	swal({
							title : '회원 탈퇴',
							text : '탈퇴하겠습니까?',
							icon : 'warning',
							buttons : ["아니오", "예"],
							dangerMode: true,
						}).then((ok) => {
// 							console.log(ok);
							if(ok){
								swal({
									title : '탈퇴되었습니다',
									text : '메인페이지로 이동합니다.',
									icon : 'success'
								}).then((ok) => {
									if(ok){
										event.currentTarget.submit();
									}
								});
							} else {
								isPwd = false;
							}
						});
			        }
			        else{
// 			        	alert("비밀번호가 다릅니다.");
			        	sweetAlert("비밀번호가 다릅니다.");
			        	isPwd = false;	
			        }
		        },
		        error: function(data){
		               	alert("ajax 중복체크 에러 발생");
		        		isPwd = false;	
		        }
			});
		if(isPwd){
			 event.currentTarget.submit();
		}
	});
    </script>
</body>
</html>