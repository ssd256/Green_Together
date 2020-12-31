<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린 - 사이트 소개</title>
<style>
	section{
		height: auto;
	}
	#imgDiv{
		text-align: center;
		margin-top: 30px;
	}
</style>
</head>
<body>
	<c:import url="../common/header.jsp"/>
	<section>
		<div id="imgDiv">
		<img src="${pageContext.request.contextPath}/resources/images/사이트소개_1.PNG">
		</div>
	</section>	
	<c:import url="../common/footer.jsp"/>
</body>
</html>