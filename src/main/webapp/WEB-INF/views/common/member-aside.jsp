<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member-aside.css" type="text/css">
</head>
<body>
	<aside>
	<script>
		function orderInfoPop(){
			var url = "orderInfoView.me";
			var name = "주문 상세 조회";
			var option = "width=1000, height=550, top=0, left=500, location=no";
			window.open(url, name, option);
		}
	</script>	
            <h1>마이페이지</h1>
            <a href="memberOrderDetail.me">
                <h2>물품 구매 정보</h2>
            </a>
<!--             <a href="javascript:orderInfoPop()"> -->
            <a href="memberSharesList.me">
                <h2>물품 나눔 정보</h2>
            </a>
            <a href="memberVolunteerList.me">
                <h2>봉사 신청 정보</h2>
            </a>
            <a href="memberAskedList.me">
                <h2>나의 문의 내역</h2>
            </a>
            <a href="memberInfo.me">
                <h2>정보 수정하기</h2>
            </a>
            <a href="memberPwdUpdate.me">
                <h2>비밀번호 수정</h2>
            </a>
            <a href="memberDeleteForm.me">
                <h2>회원 탈퇴</h2>
            </a>
        </aside>
</body>
</html>