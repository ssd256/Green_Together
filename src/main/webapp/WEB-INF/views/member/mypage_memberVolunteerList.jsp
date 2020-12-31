<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_volunteer.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<%@ include file="../common/member-aside.jsp"%>
		<section>
			<h2 id="mvH2">봉사활동 신청내역</h2>
			<div id="vrWriteBtnDiv">
				<button id="vrWriteBtn">봉사활동 후기 작성하기</button>
			</div>
			<div class="flex_div" id="flex_div_title">
				<div class="flex_div_2">
					<p>제목</p>
				</div>
				<div class="flex_div_3">
					<p>봉사지역</p>
				</div>
				<div class="flex_div_4">
					<p>인원</p>
				</div>
				<div class="flex_div_5">
					<p>상태</p>
				</div>
			</div>
			<div class="hrDiv">
				<hr>
			</div>
			<c:if test="${ empty pList }">
				<p>봉사활동 신청내역이 없습니다.</p>
			</c:if>
			<c:if test="${ not empty pList }">
				<c:forEach var="p" items="${ pList }">
					<div class="flex_div">
						<div class="flex_div_2">
							<p class="flex_div_2_p" onclick="detailB(this)">${ p.bTitle }</p>
							<input type="hidden" value="${ p.bNo }" class="vNo">
						</div>
						<div class="flex_div_3">
							<p>${ p.bLocation }</p>
						</div>
						<div class="flex_div_4">
							<p>${ p.vApplicant }/${ p.vRecruitment }</p>
						</div>
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
						<div class="flex_div_5">
							<input type="hidden" value="${ p.bNo }" class="vNo">
							<c:if test="${ p.vDay lt today }">
								<button class="finishBtn" disabled="disabled">완료</button>
							</c:if>
							<c:if test="${ p.vDay ge today }">
							<button class="cancleBtn" onclick="cancleB(this)">취소</button>
							</c:if>
						</div>
					</div>
					<div class="hrDiv">
						<hr>
					</div>
				</c:forEach>
			</c:if>
			<script type="text/javascript">
				function cancleB(t){
					var bNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
					
					swal({
						title : '봉사활동',
						text : '신청하시겠습니까?',
						icon : 'warning',
						buttons : ["아니오", "예"],
						dangerMode: true,
					}).then((ok) => {
						if(ok){
							swal({
								title : '신청완료',
								text : '봉사활동 신청 완료되었습니다.',
								icon : 'success'
							}).then((ok) => {
								if(ok){
									test(bNo);
								}
							});
						} else {
							swal.close();
						}
					});
					function test(bNo){
						location.href = "mVolunteerCancle.me?bNo=" + bNo;
					}
				}
				function detailB(t){
					var bNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
					var url = "mVolunteerDetail.me?bNo=" +bNo;
					var name = "봉사활동 상세보기";
					var option = "width=1200, height=900, top=0, left=400, location=no";
					window.open(url, name, option);
				}
				
				$(function(){
					$('#vrWriteBtn').click(function(){
						location.href = "volunteerEndList.vo";
					})
				})
				
			</script>
		</section>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>