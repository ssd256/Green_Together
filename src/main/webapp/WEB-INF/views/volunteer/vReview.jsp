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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/vReview.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp" />
	<section>
		<input type="button" value="봉사활동 후기 작성하기" id="reviewAdd">
		<div id="serarchDiv">
			<div>
				<span>봉사활동명 : </span> <input type="search" id="keywordInput">
				<button type="submit" id="searchBtn">검색</button>
			</div>
		</div>
		<input type="hidden" value="${ keywordInput }" id="key_hi">
		<div id="dataDiv">
			<div class='yellowGreenDiv'></div>
			<!-- 실질적 데이터 -->
			<c:url var="vReview" value="vReview.vo">
				<c:param name="bNo" value="${ v.bNo }"/>
				<c:param name="page" value="${ pi.currentPage }"/>
			</c:url>
			<c:if test="${ not empty vList }">
			<c:forEach var="v" items="${ vList }">
				<div class="dataList">
					<input type="hidden" class="vBNo" value="${ v.bNo }">
					<!-- 위치 -->
					<div class="data1">
						<strong class="data1_lo">[${ fn:substring(v.vLocation, 0, 2) }]</strong>
					</div>
					<!-- 내용 -->
					<div class="data2">
						<h3 class="data2_hr">${ v.bTitle }</h3>
						<div class="data2_div">
							<div class="data2_div1">
								<span class="data2_div1_span">[모집위치] ${ fn:substring(v.vLocation, 0, 7) }</span>
							</div>
							<div class="data2_div2">
								<span class="data2_div2_span">[모집날짜] ${ v.vDay }</span>
							</div>
							<div class="data2_div3">
								<span class="data2_div3_span">[참여인원] ${ v.vApplicant }</span>
							</div>
						</div>
					</div>
					<!-- 상태 -->
					<div class="data3">
						<div class="data3_div">
							<span>후기<br>${ v.vCount }건
							</span>
						</div>
					</div>
				</div>
			<hr class="dataListHr">
			</c:forEach>
			</c:if>
			<c:if test="${ empty vList }">
				<span id="emptySpan">검색 결과가 없습니다.</span>
			</c:if>

			<!-- 페이징 처리 -->
			<div class="pagination">

				<!-- 이전 -->
				<c:if test="${ category eq 1 }">
					<c:if test="${ pi.currentPage <= 1 }">
						<a class="prev_btn"> < </a>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="vReview.vo">
							<c:param name="page" value="${ pi.currentPage - 1 }" />
						</c:url>
						<a href="${ before }" class="prev_btn"> < </a>
					</c:if>

					<!-- 페이지 -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<b><a class="page no">${ p }</a></b>
						</c:if>

						<c:if test="${ p ne pi.currentPage }">
							<c:url var="pagination" value="vReview.vo">
								<c:param name="page" value="${ p }" />
							</c:url>
							<a href="${ pagination }" class="page no">${ p }</a>
						</c:if>
					</c:forEach>

					<!-- 다음 -->
					<c:if test="${ pi.currentPage >= pi.maxPage }">
						<a class="next_btn"> > </a>
					</c:if>
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="vReview.vo">
							<c:param name="page" value="${ pi.currentPage + 1 }" />
						</c:url>
						<a href="${ after }" class="next_btn"> > </a>
					</c:if>
				</c:if>
				<c:if test="${ category eq 2 }">
					<c:if test="${ pi.currentPage <= 1 }">
						<a class="prev_btn"> < </a>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before"
							value='"vReview.vo'>
							<c:param name="page" value="${ pi.currentPage - 1 }" />
						</c:url>
						<a href="${ before }" class="prev_btn"> < </a>
					</c:if>

					<!-- 페이지 -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<b><a class="page no">${ p }</a></b>
						</c:if>
						<c:if test="${ p ne pi.currentPage }">
							<a href="${ pagination }" class="page no">${ p }</a>
						</c:if>
					</c:forEach>

					<!-- 다음 -->
					<c:if test="${ pi.currentPage >= pi.maxPage }">
						<a class="next_btn"> > </a>
					</c:if>
					<c:if test="${ pi.currentPage < pi.maxPage }">
						<c:url var="after" value="vReview.vo">
							<c:param name="page" value="${ pi.currentPage + 1 }" />
						</c:url>
						<a href="${ after }" class="next_btn"> > </a>
					</c:if>
				</c:if>

			</div>
		</div>
		<script type="text/javascript">
			$(function(){
				$('#reviewAdd').click(function(){
					location.href = "volunteerEndList.vo";
				})
			})
			
			// 글 리스트를 누르면 상세보기로 이동
			$(function(){
				$('.dataList').click(function(){
					var keywordInput = $('#key_hi').val();
					var bNo = $(this).children('.vBNo').val();
					location.href = "vReviewList.vo?bNo=" + bNo +"&keywordInput=" + keywordInput;
				})
			})
			
			// 검색어
			$('#searchBtn').click(function(){
				if($('#keywordInput').val().trim().length == 0){
					swal({
						text: '검색할 상품을 입력해주세요.',
	   					icon: 'info',
	   					closeOnClickOutside: false,
						}).then((ok) => {
						if(ok){
							swal.close();	
						}
					});
				} else {
					var keywordInput = $('#keywordInput').val().trim();
					location.href="vrSearch.vo?keywordInput=" + keywordInput;
				}
			})
		</script>

	</section>
	<c:import url="../common/footer.jsp" />
</body>
</html>