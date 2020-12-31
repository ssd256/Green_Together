<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/myPage_volunteer.css"
	type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<section>
		<div id="sectionDiv_1">
			<span id="h2Span">봉사활동 완료내역</span>
			<input type="button" value="봉사활동 후기 보러가기" id="vReviewListBtn">
			<div class="flex_div" id="flex_div_title">
				<div class="flex_div_2">
					<p>제목</p>
				</div>
				<div class="flex_div_3">
					<p>봉사지역</p>
				</div>
				<div class="flex_div_4">
					<p>작성여부</p>
				</div>
				<div class="flex_div_5">
					<p>후기작성</p>
				</div>
			</div>
			<div class="hrDiv">
				<hr>
			</div>
			<c:if test="${ empty pList }">
				<p>봉사활동 완료내역이 없습니다.</p>
			</c:if>
			<c:if test="${ not empty pList }">
				<c:forEach var="p" items="${ pList }">
						<div class="flex_div">
							<div class="flex_div_2">
								<p class="flex_div_2_p" onclick="detailB(this)">${ p.bTitle }</p>
								<input type="hidden" value="${ p.bNo }" class="bNo">
							</div>
							<div class="flex_div_3">
								<p>${ p.bLocation }</p>
							</div>
							<div class="flex_div_4">
								<p>${ p.vRStatus }</p>
							</div>
							<div class="flex_div_5">
								<c:choose>
									<c:when test='${ fn:contains(p.vRStatus, "N") }'>
										<button class="finishBtn">후기작성</button>
										<input type="hidden" value="${ p.bNo }" class="bNo">
									</c:when>
									<c:otherwise>
										<button class="writeVR">작성 후기 확인</button>
										<input type="hidden" value="${ p.bNo }" class="bNo">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="hrDiv">
							<hr>
						</div>
				</c:forEach>
			</c:if>
		</div>
		<script type="text/javascript">
			function detailB(t) {
				var bNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
				var url = "mVolunteerDetail.me?bNo=" + bNo;
				var name = "봉사활동 상세보기";
				var option = "width=1200, height=900, top=0, left=400, location=no";
				window.open(url, name, option);
			}
			$(function(){
				$('.finishBtn').click(function(){
					var bNo = $(this).siblings('.bNo').val();
					location.href = "vReviewInsertForm.vo?bNo=" + bNo;
				})
			})
			$(function(){
				$('.writeVR').click(function(){
					var bNo = $(this).siblings('.bNo').val();
					location.href = "vReviewDetail.vo?bNo=" + bNo;
				})
			})
			
			$(function(){
				$('#vReviewListBtn').click(function(){
					location.href = "vReview.vo";
				})
			})
		</script>

	</section>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>