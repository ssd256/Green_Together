<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<style>
		.searchbox{
		   width: 80%;
		   padding: 2% 10%;
		   margin : 40% auto;
		   margin-bottom : 10%;
		   text-align: center;
		   /* margin-top: 10%; */
		   background-color: rgb(248, 248, 248); ;
		}
		.btn_box{
		   	text-align: center;
	   }
	   .btn{
	    display: inline-block;
		border: none;
		border-radius:5px;
		background: rgb(193, 223, 135);
		color: white;
		width: 100px; height: 40px;
		cursor: pointer;
		font-size: 20px;
	   }
	</style>
</head>
<body>
	<div class="searchbox">
		<h2>찾으시는 아이디는 '${searchId }' 입니다.</h2>
	</div>
	 <div class="btn_box">
		<input type="button" class="btn" id="cancel" value="창 닫기" onclick="window.close();">
    </div>
</body>
</html>