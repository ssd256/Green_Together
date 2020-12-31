<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/vReviewInsert.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp" />
	<section>
		<form action="vrInsert.vo" method="post" enctype="multipart/form-data">
			<div id="bigDiv">
				<h1>봉사활동명 : ${ v.bTitle }</h1>
				<input type="hidden" value="${ v.bNo }" name="bNo">
				<div id="flexDiv">
					<div class="title_div" id="title_span">
						<span>후기제목</span>
					</div>
					<div class="content_div">
						<input type="search" placeholder="후기 제목 입력(20자 내외 특수문자 불가)" id="vrTitle" name="vrTitle" required>
						<label id="vTitleResult"></label>
					</div>
				</div>
				<div id="flexDiv">
					<div class="title_div" id="content_span">
						<span>내용</span>
					</div>
					<div class="content_div">
						<textarea placeholder="활동내용을 입력하세요." id='vrContentTextarea' name='vrContent' required></textarea>
						<span id = 'limitNum'>0/500</span>
					</div>
				</div>
				<div id="flexDiv">
					<div class="title_div">
						<span>이미지</span>
					</div>
					<div class="content_div">
						<div id="contentArea">
							<div id="contentImgArea1">
								<img id="contentImg1" width="100%" height="200px">
							</div>
							<div id="contentImgArea2">
								<img id="contentImg2" width="100%" height="200px">
							</div>
							<div id="contentImgArea3">
								<img id="contentImg3" width="100%" height="200px">
							</div>
						</div>
						<div id="fileArea">
							<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg1" onchange="LoadImg(this,1)"> 
							<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg2" onchange="LoadImg(this,2)"> 
							<input type="file" id="thumbnailImg3" multiple="multiple" name="thumbnailImg3" onchange="LoadImg(this,3)"> 
						</div>
					</div>
				</div>
				<br>
				<hr>
				<div id="submitDiv">
					<button id="backList" onclick="location.href='volunteerEndList.vo'">취소</button>
					<input type="submit" value="등록" id='addBtn'>
				</div>
			</div>
		</form>
		<script type="text/javascript">
			// 내용 500자
			$('#vrContentTextarea').keyup(function(e) {
				var content = $(this).val();
				$('#limitNum').html(content.length + "/500");

				if (content.length > 500) {
					sweetAlert("봉사활동 내용은 최대 500자");
					var con = $(this).val(content.substring(0, 500));
					$('#limitNum').html("500/500");
				}
			});
			
			$(function() {
				$("#fileArea").hide();

				$("#contentImgArea1").click(function() {
					$("#thumbnailImg1").click();
				});
				$("#contentImgArea2").click(function() {
					$("#thumbnailImg2").click();
				});
				$("#contentImgArea3").click(function() {
					$("#thumbnailImg3").click();
				});
			});

			function LoadImg(value, num) {
				if (value.files && value.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						switch (num) {
						case 1:
							$("#contentImg1").attr("src", e.target.result);
							break;
						case 2:
							$("#contentImg2").attr("src", e.target.result);
							break;
						case 3:
							$("#contentImg3").attr("src", e.target.result);
							break;
						}
					}
					reader.readAsDataURL(value.files[0]);
				}
			}
			
			let isvrTitle=false;
			
			// 제목 20자
    		$('#vrTitle').change(function(){
    			$("#vTitleResult").show();
    			var regExp = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\s\.]{1,20}$/;
    			if(!regExp.test($(this).val())){
    				$("#vTitleResult").text("***** 글자수 20자 이내").css("color", "red");
    				$('#vrTitle').focus();
    				isVTitle = false;
    			} else {
    				$("#vTitleResult").hide();
    				isVTitle = true;
    			}
    		});
			
		</script>
	</section>
	<c:import url="../common/footer.jsp" />
</body>
</html>