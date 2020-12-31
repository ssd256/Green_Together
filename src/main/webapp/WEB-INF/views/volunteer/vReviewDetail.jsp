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
		<div id="bigDiv">
			<input type="hidden" value="${ keywordInput }" id="key_hi">
			<input type="hidden" value="${ v.bNo }" id="bNo_hi">
			<span id="h1Span">봉사활동명 : ${ v.bTitle }</span>
			<input type="hidden" value="${ vReview.bNo }" name="bNo">
			<input type="hidden" value="${ vReview.vrNo }" name="vrNo" id="vrNo_hi">
			<c:if test="${ !empty sessionScope.loginUser }">
				<c:if test="${ loginUser.userId == vReview.mId }">
				<button id="updateBtn">수정</button>
				<button id="deleteBtn">삭제</button>
				</c:if>
			</c:if>
			<br>
			<br>
			<br>
			<div id="flexDiv">
				<div class="title_div" id="title_span">
					<span>후기제목</span>
				</div>
				<div class="content_div">
					<input type="search" id="vrTitle" name="vrTitle" required value="${ vReview.vrTitle }" readonly="readonly">
					<label id="vTitleResult"></label>
				</div>
			</div>
			<div id="flexDiv">
				<div class="title_div" id="content_span">
					<span>내용</span>
				</div>
				<div class="content_div">
					<textarea id='vrContentTextarea' name='vrContent' required readonly="readonly">${ vReview.vrContent }</textarea>
				</div>
			</div>
			<c:if test="${ files != '[]' }">
				<div id="flexDiv">
					<div class="title_div">
						<span>이미지</span>
					</div>
					<div class="content_div">
						<div id="contentArea">
							<div class="contentImg_detail">
								<c:forEach var="f" items="${ files }">
									<img width="230px" height="199px" src="resources/volunteerReview_uploadFiles/${ f.fChangeName }">
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<br>
			<hr>
			<div id="submitDiv">
				<c:if test="${ category eq 1 }">
					<button id="backList" onclick="location.href='volunteerEndList.vo'">목록</button>
				</c:if>
				<c:if test="${ category eq 2 }">
					<button id="backList2">목록</button>
				</c:if>
			</div>
		</div>
		<script type="text/javascript">
			var bNo = $('#bNo_hi').val();
			
			$('#updateBtn').click(function(){
				location.href = "vrUpdateVeiw.vo?bNo=" + bNo;
			});
			
			
			$('#deleteBtn').click(function(){
				var vrNo = $('#vrNo_hi').val();
				var bNo = $('#bNo_hi').val();
				swal({
					text: '해당 상품을 삭제하시겠습니까?', 
					icon : 'warning',
					buttons: ["아니오", "예"],
					dangerMode: true,
					closeOnClickOutside: false,
					}).then((ok) => {
					if(ok){
						location.href='${pageContext.request.contextPath}/vrdelete.vo?vrNo=' + vrNo +"&bNo=" + bNo;							
					}
				});
			})
			
			$('#backList2').click(function(){
				var keywordInput = $('#key_hi').val();
				location.href="vReviewList.vo?bNo=" + bNo + "&keywordInput=" + keywordInput;
			})
		</script>
	</section>
	<c:import url="../common/footer.jsp" />
</body>
</html>