<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" type="text/css">
<style>
</style>
</head>
<body>
	<img id="top" src="${pageContext.request.contextPath}/resources/images/top_button2.png"/>
    <footer>
    <div id="footerImageBox">
	    <div id="footerTextBox">
		  <br>  
		        기업인증번호 : 제 0234-2020-09028호 | 사회적기업인증번호 : 제 2020-123호<br>
		        주소 : 서울 강남구 역삼동 188 상일빌딩 4층 | 대표자 : 한그린<br>
		        사업자번호 : 100-00-00000 | 통신판매업 : 제 2020-서울강남-1234호<br>
		        전화 : 1588-9191 | 팩스 : 02-919-9191 | 정보보호최고책임자 : 한그린<br>
		        함께그린의 사전 서면 동의 없이 사이트의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.<br>
		    Copyright© reserved to 함께그린 2020<br>
		<br>	  
 		</div>
    </div>
    </footer>
    
    <script>
    	$(function(){
    		$(window).scroll(function(){
    			if($(this).scrollTop() < 200){
    				$('#top').fadeOut();
    			} else {
    				$('#top').fadeIn();
    			}
    		});
    		
    		$('#top').click(function(){
    			$('html, body').animate({
    				scrollTop : 0
    			}, 400);
    			return false;
    		});
    	});
    </script>		
</body>
</html>
