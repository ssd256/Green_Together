<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/vReviewListView.css" type="text/css">
</head>
<body>
<%@ include file="../common/header.jsp"%>

	<section>
		<div id="bigbigDiv">
   		<!-- 봉사활동 등록 아래에 제일 큰 div -->
		<div id="formDiv">
			<input type="hidden" value="${ keywordInput }" id="key_hi">
			<strong id="bTitleStrong">봉사활동명 : ${ v.bTitle }</strong>
			<br>
			<br>
    		<div class = 'greenDiv'></div>
			<input type="hidden" value="${ v.bNo }" id="bNo_hi">
			<div class="whiteDiv"></div>
			<div class="whiteDiv"></div>
			<div class="whiteDiv"></div>
			<div class = 'yellowGreenDiv'></div>
			<!-- 봉사기간,시간,장소,기관,모집인원 -->
			<!-- 봉사기간, 시간 -->
			<div class="vInfomation">
				<div class="vInfoTitle"><span>봉사기간</span></div>
				<div class="vInfoContent">
					<span>${ v.vDay }</span>
				</div>
				<div class="vInfoTitle"><span>등록기관</span></div>
				<div class="vInfoContent">
					<span>${ v.vAgency }</span>
				</div>
			</div>
			<div class="whiteDiv"></div>
			
			<!-- 봉사장소 -->
			<div class="vInfomation">
				<div id="vInfoTitle2"><span>봉사장소</span></div>
				<div id="vInfoContent2">
					<span id="address1">${ v.vLocation }</span>
				</div>
			</div>
			<div class = 'yellowGreenDiv'></div>
			<br>
			<h3>자원봉사 후기</h3>
			<div class = 'greenDiv'></div>
			<c:if test="${ not empty vrList }">
			<c:forEach var="vr" items="${ vrList }">
			<div class="dataList">
				<input type="hidden" name="vrNo" value="${ vr.vrNo }" class="vrNo">
				<input type="hidden" name="bNo" value="${ vr.bNo }" class="bNo">
				<div class="vrTitleDiv">
					<span class="vrTitleSpan">${ vr.vrTitle }</span>
				</div>
				<div>			
					<span class="vrInformSpan">작성자 : ${ vr.mNickname } | 작성일자 : ${ vr.vrDate }</span>
				</div>
		    </div>
	    	<hr class="dataListHr">
		    </c:forEach>
		    </c:if>
		    <c:if test="${ empty vrList }">
		    	<span id="emptySpan">검색 결과가 없습니다.</span>	
		    </c:if>
			<br>
		</div>
		<div id="preNext">
			<div class="preNextDiv" id="pnd_1">
				<div id="pnd_1_1">
					<p>〈 최신글</p>				
					<c:if test="${ v.pre_title == null || v.pre_title == ''}">
					<p>최신글이 없습니다.</p>
					</c:if>
					<c:if test="${ v.pre_title != null }">
					<p id="pnd_1_1_p">${ v.pre_title }</p>
					</c:if>
					<input type="hidden" value ="${ v.pre_no }" id="pre_hi">
				</div>				
			</div>
			<div class="preNextDiv" id="pnd_2">
				<button class="addBtn" id="listBack">목록</button> 
			</div>
			<div class="preNextDiv" id="pnd_3">
				<div id="pnd_3_1">
					<p>다음글 〉</p>
					<c:if test="${ v.next_title == null || v.next_title == '' }">
					<p>다음글이 없습니다.</p>
					</c:if>
					<c:if test="${ v.next_title != null }">
					<p>${ v.next_title }</p>
					</c:if>
					<input type="hidden" value ="${ v.next_no }" id="next_hi">
				</div>
			</div>
		</div>
		</div>
		<br clear="all">
    	
		<script>
			$('.dataList').click(function(){
				var vrNo = $(this).children('.vrNo').val();
				var bNo = $(this).children('.bNo').val();
				var keywordInput = $('#key_hi').val();
				location.href = "vReviewDetailList.vo?vrNo=" + vrNo + "&bNo=" + bNo +"&keywordInput=" + keywordInput;
			});
			
			$('#listBack').click(function(){
				location.href = "vReview.vo";
			})
			
			// 최신글
			$('#pnd_1').mouseenter(function(){
				$(this).css("cursor", "pointer");
			}).click(function(){
				var bNo = $('#pre_hi').val();
				var keywordInput = $('#key_hi').val();
				if(bNo == 0 || bNo == null){
					sweetAlert("봉사활동", "최신글이 없습니다.","error");
				} else {
					location.href = "vReviewList.vo?bNo=" + bNo +"&keywordInput=" + keywordInput;
				}
			});
			
			// 다음글
			$('#pnd_3').mouseenter(function(){
				$(this).css("cursor", "pointer");
			}).click(function(){
				var bNo = $('#next_hi').val();
				if(bNo == 0){
					sweetAlert("봉사활동", "다음글이 없습니다.","error");
				} else {
					location.href = "vReviewList.vo?bNo=" + bNo +"&keywordInput=" + "${keywordInput}";
				}
			});
		</script>
    	<br>
    	<br>
    	<br>
    	<br>
    	<br>
    </section>
	<c:import url="../common/footer.jsp"/>

</body>
</html>