<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/volunteerList.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp"/>
	
	<section>
		<div>
			<h2 id = 'volH2'>봉사활동 참여</h2>
			<c:if test="${ loginUser.userGrade == 'admin' }">
				<input type="button" onclick="location.href='vinsertView.vo'" value="봉사활동 등록" id="addVBtn">
				<label id="updateInform">봉사활동 수정/삭제 : 원하는 봉사활동 클릭 시 사용 가능</label>
			</c:if>
		</div>
		<br>
		<div class = 'greenDiv'></div>
		<form action="vOption.vo" method="get">
			<div id="vSelectOption">
				<!-- 모집장소 -->
				<div id="vOption1">
					<h3>봉사지역</h3>
					<div class="vOpDiv">
						<div class="vOp1_1">
							<input type="button" id="local1" class="localBtn" value="전체">
						</div>
						<div class="vOp1_2" id="vOpDetail">
							<input type="hidden" id="localInput" name="localInput" value="전체">
							<input type="button"  id="local2" class="localBtn" value="서울">
							<input type="button"  id="local3" class="localBtn" value="부산">
							<input type="button"  id="local4" class="localBtn" value="대구">
							<input type="button"  id="local5" class="localBtn" value="인천">
							<input type="button"  id="local6" class="localBtn" value="광주">
							<input type="button"  id="local7" class="localBtn" value="대전"><br>
							<input type="button"  id="local8" class="localBtn" value="울산">
							<input type="button"  id="local9" class="localBtn" value="세종">
							<input type="button"  id="local18" class="localBtn" value="제주">
							<input type="button"  id="local10" class="localBtn" value="경기">
							<input type="button"  id="local11" class="localBtn" value="강원">
							<input type="button"  id="local12" class="localBtn" value="충북"><br>
							<input type="button"  id="local13" class="localBtn" value="충남">
							<input type="button"  id="local14" class="localBtn" value="전북">
							<input type="button"  id="local15" class="localBtn" value="전남">
							<input type="button"  id="local16" class="localBtn" value="경북">
							<input type="button"  id="local17" class="localBtn" value="경남">
						</div>
					</div>
				</div>
				
				<!-- 모집상태 -->
				<div id="vOption2">
					<h3>모집상태</h3>
					<input type="hidden" id="statusInput" name="statusInput" value="전체">
					<input type="button" id="status1" class="statusBtn" value="전체">&nbsp;&nbsp;&nbsp;
					<input type="button" id="status2" class="statusBtn" value="모집중"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="status3" class="statusBtn" value="모집완료">
				</div>
				
				<!-- 봉사기간 -->
				<div id="vOption3">
					<h3>봉사기간</h3>
					<input type="date" id="startInput" name="startInput"><span>~</span><input type="date" name="endInput" id="endInput">
					<br>
					<br>
					<button type="submit" id="optionBtn">검색</button>
				</div>
				<input type="hidden">
			</div>
		</form>
		<div class = 'greenDiv'></div>
		<br>
		<br>
		<br>
		<br>
	    <div id="dataDiv">
	    	<div class = 'yellowGreenDiv'></div>
	    	
	    	<!-- 실질적 데이터 -->
	    	<c:url var="vDetail" value="vDetail.vo">
	    		<c:param name="bNo" value="${ v.bNo }"/>
	    		<c:param name="papge" value="${ pi.currentPage }"/>
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
		    				<div class="data2_div1"><span class="data2_div1_span">[모집위치] ${ fn:substring(v.vLocation, 0, 7) }</span></div>
		    				<div class="data2_div2"><span class="data2_div2_span">[모집날짜] ${ v.vDay }</span></div>
		    				<div class="data2_div3"><span class="data2_div3_span">[모집인원] ${ v.vRecruitment }</span></div>
		    			</div>
		    		</div>
		    		<!-- 상태 -->
		    		<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
		    		<div class="data3">
		    			<c:if test="${ v.vRecruitment gt v.vApplicant && fn:substring(v.vDay, 11, 21) ge today }">
		    				<div class="data3_div">
		    					<span>모집중</span>
		    				</div>
		    			</c:if>
		    			<c:if test="${ v.vRecruitment eq v.vApplicant || fn:substring(v.vDay, 11, 21) lt today }">
		    				<div class="finishVolunteerBtn">
		    					<span>모집완료</span>
		    				</div>
		    			</c:if>
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
	    			<c:url var="before" value="vList.vo">        
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
	    				<c:url var="pagination" value="vList.vo">
	    					<c:param name="page" value="${ p }"/>
						</c:url>	
						<a href="${ pagination }" class="page no">${ p }</a>
					</c:if>
	    		</c:forEach>		
	    		
	    		<!-- 다음 -->
	    		<c:if test="${ pi.currentPage >= pi.maxPage }">
					<a class="next_btn"> > </a>
					</c:if>
	    		<c:if test="${ pi.currentPage < pi.maxPage }">
	    			<c:url var="after" value="vList.vo">
	    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
	    			</c:url>
	    			<a href="${ after }" class="next_btn"> > </a>
	    		</c:if>
	    		</c:if>
	    		<c:if test="${ category eq 2 }">
		    	<c:if test="${ pi.currentPage <= 1 }">
		    		<a class="prev_btn"> < </a>
		    	</c:if>
	            <c:if test="${ pi.currentPage > 1 }">
	    			<c:url var="before" value='"vOption.vo?localInput=" + localInput + "&statusInput=" + statusInput+ 
									"&startInput=" + startInput+ "&endInput=" + endInput + "&page=" + page'>        
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
	    				<c:url var="pagination" value="vOption.vo">
	    					<c:param name="localInput" value="${ localInput }"/>
	    					<c:param name="statusInput" value="${ statusInput }"/>
	    					<c:param name="startInput" value="${ startInput }"/>
	    					<c:param name="endInput" value="${ endInput }"/>
	    					<c:param name="page" value="${ p }"/>
						</c:url>	
						<a href="${ pagination }" class="page no">${ p }</a>
					</c:if>
	    		</c:forEach>		
	    		
	    		<!-- 다음 -->
	    		<c:if test="${ pi.currentPage >= pi.maxPage }">
					<a class="next_btn"> > </a>
					</c:if>
	    		<c:if test="${ pi.currentPage < pi.maxPage }">
	    			<c:url var="after" value="vOption.vo">
	    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
	    			</c:url>
	    			<a href="${ after }" class="next_btn"> > </a>
	    		</c:if>
	    		</c:if>
	    		
		      </div>
	    </div>
	    <script>
				$(function(){
					$('.localBtn').click(function(){
						$('.localBtn').css({'background':'white', 'font-weight':'normal', 'color':'black', 'animation-fill-mode': 'forwards'});
						$(this).css({'background':'rgb(99, 165, 55)', 'font-weight':'bolder', 'color':'white', 'animation-fill-mode': 'forwards'});
						
						var Input = $(this).val();
						// 현재 누른 버튼의 text값을 받음
						$('#localInput').val(Input);
						
					});
				});
				$(function(){
					$('.statusBtn').click(function(){
						$('.statusBtn').css({'background':'white', 'font-weight':'normal', 'color':'black', 'animation-fill-mode': 'forwards'});
						$(this).css({'background':'rgb(99, 165, 55)', 'font-weight':'bolder', 'color':'white', 'animation-fill-mode': 'forwards'});
						
						var sInput = $(this).val();
						// 현재 누른 버튼의 text값을 받음
						console.log("상태 : " + sInput);
						$('#statusInput').val(sInput);
					});
				});
				
				
				$(function(){
					document.getElementById('startInput').value = new Date().toISOString().substring(0, 10); // 오늘 날짜 주입
				})
				
				// 글 리스트를 누르면 상세보기로 이동
				$(function(){
					$('.dataList').click(function(){
						var vNo = $(this).children('.vBNo').val();
						location.href = "vDetail.vo?bNo=" + vNo + "&localInput=" + "${localInput}" + "&statusInput=" + "${statusInput}" +
                        "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}" + "&page=" + "${pi.currentPage}";
					})
				})
				
			</script>
	    
	    
		<br clear="all">
    </section>
    <br><br><br>
    <c:import url="../common/footer.jsp"/>
    
</body>
</html>