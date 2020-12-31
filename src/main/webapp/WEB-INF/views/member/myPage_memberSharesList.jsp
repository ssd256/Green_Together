<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section{
		height: auto;
		margin: 0px 10%;
	}

	.flex_div{
		display: flex;
		margin: 0px 2%;
		text-align: center;
	}
	#flex_div_title{
		font-size: 16px;
		font-weight: bolder;
	}
	.hrDiv{
		margin: 0px 2%;
	}
	.flex_div_2{
		flex:  2;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.flex_div_2_p{
		width: 100%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		text-align: center;
		cursor: pointer;
	}
	.flex_div_3{
		flex:  4;
	}
	.flex_div_4{
		flex: 1.5;
	}
	.flex_div_5{
		flex: 1.5;
	}
	.cancleBtn{
		width: 50%;
		height: 40px;
		border: none;
		background: rgb(68, 193, 163);
	}
	.finishBtn{
		width: 50%;
		height: 40px;
		border: none;
		color: black;
	}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<%@ include file="../common/member-aside.jsp"%>
		<section>
			<h2>물품나눔 신청내역</h2>
			<div class="flex_div" id="flex_div_title">
				<div class="flex_div_2">
					<p>제품명</p>
				</div>
				<div class="flex_div_3">
					<p>물품 나눔 지역</p>
				</div>
				<div class="flex_div_4">
					<p>재고</p>
				</div>
				<div class="flex_div_5">
					<p>상태</p>
				</div>
			</div>
			<div class="hrDiv">
				<hr>
			</div>
			<c:if test="${ sList.isEmpty() || fList.isEmpty()}">
				<p>물품나눔 신청내역이 없습니다.</p>
			</c:if>
			<c:if test="${ not empty sList }">
				<c:forEach var="s" items="${ sList }">
					<div class="flex_div">
						<div class="flex_div_2">
							<p class="flex_div_2_p" onclick="detailB(this)">${ s.bTitle }</p>
							<input type="hidden" value="${ s.bNo }" class="vNo">
						</div>
						<div class="flex_div_3">
							<p>${ s.sAddress }</p>
						</div>
						<div class="flex_div_4">
							<p>${ s.sStock }개</p>
						</div>
						<jsp:useBean id="now" class="java.util.Date" />
<%-- 						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" /> --%>
						<div class="flex_div_5">
							<input type="hidden" value="${ s.bNo }" class="vNo">
<%-- 							<c:if test="${ p.vDay lt today }"> --%>
<!-- 								<button class="finishBtn" disabled="disabled">완료</button> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test="${ p.vDay ge today }"> --%>
							<button class="cancleBtn" onclick="cancleB(this)">취소</button>
<%-- 							</c:if> --%>
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
// 					var appNo = 2;
// 					var viewNo = 2;
					
					swal({
						title : '무료나눔',
						text : '취소하시겠습니까?',
						icon : 'warning',
						buttons : ["아니오", "예"],
						dangerMode: true,
					}).then((ok) => {
						console.log(ok);
						if(ok){
							swal({
								title : '취소완료',
								text : '무료나눔 취소가 완료되었습니다.',
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
// 						location.href = "vUpdaateApp.vo?bNo=" + bNo + "&appNo=" + appNo + "&viewNo=" + viewNo;
// 						location.href = "mVolunteerCancle.me?bNo=" + bNo;
						location.href = "sApplyDelete.sh?bNo=" + bNo;
					}
				}
				function detailB(t){
					var bNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
					location.href = "sdetail.sh?bNo=" + bNo;
// 					var url = "sdetail.sh?bNo=" + bNo;
// 					var name = "무료나눔 상세보기";
// 					var option = "width=900, height=700, top=0, left=500, location=no";
// 					window.open(url, name, option);
				}
			</script>
			
		</section>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>