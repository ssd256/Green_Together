<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/vReviewInsert.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp" />
	<section>
		<form action="vrUpdate.vo" method="post" enctype="multipart/form-data">
		<div id="bigDiv">
			<input type="hidden" value="${ v.bNo }" id="bNo_hi">
			<span id="h1Span">봉사활동명 : ${ v.bTitle }</span>
			<input type="hidden" value="${ vReview.bNo }" name="bNo">
			<input type="hidden" value="${ vReview.vrNo }" name="vrNo">
			<br>
			<br>
			<br>
			<div id="flexDiv">
				<div class="title_div" id="title_span">
					<span>후기제목</span>
				</div>
				<div class="content_div">
					<input type="search" id="vrTitle" name="vrTitle" required value="${ vReview.vrTitle }">
					<label id="vTitleResult"></label>
				</div>
			</div>
			<div id="flexDiv">
				<div class="title_div" id="content_span">
					<span>내용</span>
				</div>
				<div class="content_div">
					<textarea id='vrContentTextarea' name='vrContent' required>${ vReview.vrContent }</textarea>
				</div>
			</div>
			<c:if test="${ files != '[]' }">
				<div id="flexDiv">
					<div class="title_div">
						<span>이미지</span>
					</div>
					<div class="content_div">
						<div id="contentArea">
							<c:forEach var="f" items="${ files }" varStatus="status">
								<c:if test="${ status.count == 1 }">
									<c:if test="${ status.last }">
									<div id="contentImgArea1">
										<img id="contentImg1" width="100%" height="200px" src="resources/volunteerReview_uploadFiles/${ files.get(0).fChangeName }">
										<input type="hidden" name="fNum1" value="${ files.get(0).fNum }">
									</div>
									<div id="contentImgArea2">
										<img id="contentImg2" width="100%" height="200px">
										<input type="hidden" name="fNum2" value="0">
									</div>
									<div id="contentImgArea3">
										<img id="contentImg3" width="100%" height="200px">
										<input type="hidden" name="fNum3" value="0">
									</div>
									</c:if>
								</c:if>
								<c:if test="${ status.count == 2 }">
									<c:if test="${ status.last }">
									<div id="contentImgArea1">
										<img id="contentImg1" width="100%" height="200px" src="resources/volunteerReview_uploadFiles/${ files.get(0).fChangeName }">
										<input type="hidden" name="fNum1" value="${ files.get(0).fNum }">
									</div>
									<div id="contentImgArea2">
										<img id="contentImg2" width="100%" height="200px" src="resources/volunteerReview_uploadFiles/${ files.get(1).fChangeName }">
										<input type="hidden" name="fNum2" value="${ files.get(1).fNum }">
									</div>
									<div id="contentImgArea3">
										<img id="contentImg3" width="100%" height="200px">
										<input type="hidden" name="fNum3" value="0">
									</div>
									</c:if>
								</c:if>
								<c:if test="${ status.count == 3 }">
									<c:if test="${ status.last }">
									<div id="contentImgArea1">
										<img id="contentImg1" width="100%" height="200px" src="resources/volunteerReview_uploadFiles/${ files.get(0).fChangeName }">
										<input type="hidden" name="fNum1" value="${ files.get(0).fNum }">
									</div>
									<div id="contentImgArea2">
										<img id="contentImg2" width="100%" height="200px" src="resources/volunteerReview_uploadFiles/${ files.get(1).fChangeName }">
										<input type="hidden" name="fNum2" value="${ files.get(1).fNum }">
									</div>
									<div id="contentImgArea3">
										<img id="contentImg3" width="100%" height="200px" src="resources/volunteerReview_uploadFiles/${ files.get(1).fChangeName }">
										<input type="hidden" name="fNum3" value="${ files.get(2).fNum }">
									</div>
									</c:if>
								</c:if>
							</c:forEach>
						</div>
						<div id="fileArea">
							<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg1" onchange="LoadImg(this,1)"> 
							<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg2" onchange="LoadImg(this,2)"> 
							<input type="file" id="thumbnailImg3" multiple="multiple" name="thumbnailImg3" onchange="LoadImg(this,3)"> 
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${ files == '[]' }">
				<div id="flexDiv">
					<div class="title_div">
						<span>이미지</span>
					</div>
					<div class="content_div">
						<div id="contentArea">
							<div id="contentImgArea1">
								<img id="contentImg1" width="100%" height="200px">
								<input type="hidden" name="fNum1" value="0">
							</div>
							<div id="contentImgArea2">
								<img id="contentImg2" width="100%" height="200px">
								<input type="hidden" name="fNum2" value="0">
							</div>
							<div id="contentImgArea3">
								<img id="contentImg3" width="100%" height="200px">
								<input type="hidden" name="fNum3" value="0">
							</div>
						</div>
						<div id="fileArea">
							<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg1" onchange="LoadImg(this,1)"> 
							<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg2" onchange="LoadImg(this,2)"> 
							<input type="file" id="thumbnailImg3" multiple="multiple" name="thumbnailImg3" onchange="LoadImg(this,3)"> 
						</div>
					</div>
				</div>
			</c:if>
			<br>
			<hr>
			<div id="submitDiv">
				<button id="backList" onclick="location.href='volunteerEndList.vo'">목록</button>
				<input type="submit" value="등록" id='addBtn'>
			</div>
		</div>
		</form>
		<script>
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
		</script>
	</section>
	<c:import url="../common/footer.jsp" />
</body>
</html>