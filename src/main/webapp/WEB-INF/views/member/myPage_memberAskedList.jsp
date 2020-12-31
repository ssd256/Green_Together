<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 문의사항</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_memberAskedList.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<%@ include file="../common/member-aside.jsp"%>
		<section>
		<h2>문의사항 작성내역</h2>
		<div class="flex_div" id="flex_div_title">
				<div class="flex_div_2">
					<p>카테고리</p>
				</div>
				<div class="flex_div_3">
					<p>제목</p>
				</div>
				<div class="flex_div_4">
					<p>작성날짜</p>
				</div>
				<div class="flex_div_5">
					<p>답변상태</p>
				</div>
			</div>
			<div class="hrDiv">
				<hr>
			</div>
			<c:if test="${ aList.isEmpty() }">
				<p>문의사항 작성 내역이 없습니다.</p>
			</c:if>
			<c:if test="${ not empty aList }">
				<c:forEach var="a" items="${ aList }">
					<div class="flex_div">
						<div class="flex_div_2">
							<p class="flex_div_2_p">[${ a.qCategory }]</p>
						</div>
						<div class="flex_div_3" >
							<p id="askedTitle" onclick="detailB(this)">${ a.bTitle }</p>
							<input type="hidden" value="${ a.bNo }" class="aNo">
						</div>
						<div class="flex_div_4">
							<p>${ a.bDate }</p>
						</div>
						<jsp:useBean id="now" class="java.util.Date" />
						<div class="flex_div_5">
							<input type="hidden" value="${ a.bNo }" class="aNo">
							<c:if test ="${ a.recnt > 0 }">
							<p id="answerOk">답변완료</p>
							</c:if>
						</div>
					</div>
					<div class="hrDiv">
						<hr>
					</div>
				</c:forEach>
			</c:if>
			<script type="text/javascript">
			function detailB(t){
				var bNo = $(t).siblings('input').val();	
				location.href = "adetail.ao?bNo=" +bNo +"&page=" + 1;
				/* 페이지 처리를 어떻게 해야하지..? */
				}
			</script>
		</section>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>