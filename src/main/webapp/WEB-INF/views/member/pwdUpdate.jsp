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
		#divbox{
		   width: 80%;
		   padding: 2% 10%;
		   text-align: center;
		   /* margin-top: 10%; */
		   background-color: rgb(248, 248, 248); ;
		}
		.loginbtn{
		display:block;
		border-radius:5px;
		background: rgb(99, 165, 55);
		color: white;
		width: 150px; height: 50px;
		cursor: pointer;
		font-size: 20px;
		margin: 10px auto;
		}
	</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<section>
		<div id="divbox" style="text-align: center;">
	      	<h1>비밀번호가 변경되었습니다.<br>다시 로그인해주세요</h1>
	      	<c:url var="loginView" value="loginView.me"/>
			<button class="loginbtn" onclick="location.href='home.do'">확인</button>
	   </div>
	</section>
	 <%@ include file="../common/footer.jsp"%>
	<script>
	</script>
</body>
</html>