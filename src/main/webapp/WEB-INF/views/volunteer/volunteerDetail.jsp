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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/volunteerDetail.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<section>
    	<div>
    		<h2 id = 'volH3'>봉사활동 신청</h2>
    	</div>
    	<div class = 'greenDiv'></div>
   		<!-- 봉사활동 등록 아래에 제일 큰 div -->
		<div id="formDiv">
			<br>
			<strong id="bTitleStrong">${ v.bTitle }</strong>
			<input type="hidden" value="${ v.bNo }" id="bNo_hi">
			<input type="hidden" value="${ localInput }">
			<input type="hidden" value="${ statusInput }">
			<input type="hidden" value="${ startInput }">
			<input type="hidden" value="${ endInput }">
			<c:if test="${ !empty sessionScope.loginUser }">
				<c:if test="${ loginUser.userGrade =='admin' }">
					<button class="adminBtn" id="updateBtn">수정</button>
					<button class="adminBtn" id="deleteBtn">삭제</button>
				</c:if>
				<c:if test="${ loginUser.userGrade != 'admin' }">
				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
					<c:if test="${ v.vRecruitment > v.vApplicant && fn:substring(v.vDay, 11, 21) ge today }">
					<c:choose>
						<c:when test="${ p.mId != null }">
							<button class="userBtn" id="cancleBtn">취소하기</button>
						</c:when>
						<c:otherwise>
							<button class="userBtn" id="appBtn">신청하기</button>
						</c:otherwise>
					</c:choose>
					</c:if>
					<c:if test="${ v.vRecruitment <= v.vApplicant || fn:substring(v.vDay, 11, 21) lt today }"> 
						<button class="userBtn" id="finishBtn" disabled="disabled">마감</button>
					</c:if>
				</c:if>
			</c:if>
			
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
				<div class="vInfoTitle"><span>봉사시간</span></div>
				<div class="vInfoContent">
					<span>${ v.vTime }</span>
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
			
					
			<!-- 등록기관, 모집인원 -->
			<div class="whiteDiv"></div>
			<div class="vInfomation">
				<div class="vInfoTitle"><span>모집인원</span></div>
				<div class="vInfoContent">
					<span>${ v.vRecruitment }</span>
				</div>
				<div class="vInfoTitle"><span>신청인원</span></div>
				<div class="vInfoContent">
					<span>${ v.vApplicant }</span>
				</div>
			</div>
			<div class = 'yellowGreenDiv'></div>
			<br>
			<!-- 활동내용+지도API -->
			<br>
			<div id = 'vInfoDiv'>
				<div id = 'vContent'>
					<textarea id = 'vContentTextarea' name='bContent' readonly>${ v.bContent }</textarea>
				</div>
				<div id = "mapApi">
					지도API 부분
				</div>
			</div>
			<span>담당자 이름 :</span>
			<span> ${ v.vResponsibility }</span><br>
			<span>담당자 핸드폰번호 :</span>
			<span> ${ v.vPhone }</span><br>
			<span>등록기관 :</span>
			<span> ${ v.vAgency }</span>
			<br> 
			<br>
			<br>
			<hr>
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
		<br clear="all">
    	
		<!-- 지도API -->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=27317bdd71042aa55e5b61a2ddfb1d4d&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('mapApi'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
		
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			var inputAddress = $('#address1').text();
			var inputAddressArr = inputAddress.split('/');
		
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(inputAddressArr[0], function(result, status) {
		
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
		
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
		
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">봉사장소</div>'
			        });
			        infowindow.open(map, marker);
		
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});    
		    
			// 최신글 
			$('#pnd_1').mouseenter(function(){
				$(this).css("cursor", "pointer");
			}).click(function(){
				var bNo = $('#pre_hi').val();
				if(bNo == 0 || bNo == null){
					sweetAlert("봉사활동", "최신글이 없습니다.","error");
				} else {
					location.href = "vDetail.vo?bNo=" + bNo + "&localInput=" + "${localInput}" + "&statusInput=" + "${statusInput}" +
                    "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}" + "&page=" + "${pi.currentPage}";
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
					location.href = "vDetail.vo?bNo=" + bNo + "&localInput=" + "${localInput}" + "&statusInput=" + "${statusInput}" +
                    "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}" + "&page=" + "${pi.currentPage}";
				}
			});
			
			// 관리자-삭제버튼
			$('#deleteBtn').click(function(){
				var bNo = $('#bNo_hi').val();
				swal({
					title : '봉사활동',
					text : '삭제하시겠습니까?',
					icon : 'warning',
					buttons : ["아니오", "예"],
					dangerMode: true,
				}).then((ok) => {
					if(ok){
						swal({
							title : '삭제완료',
							text : '해당 게시글이 삭제되었습니다.',
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
			})
			 
			function test(bNo){
				location.href = "vDelete.vo?bNo=" + bNo;
			}
			
			$('#updateBtn').click(function(){
				var bNo = $('#bNo_hi').val();
				location.href = "vUpdateView.vo?bNo=" + bNo + "&localInput=" + "${localInput}" + "&statusInput=" + "${statusInput}" +
                "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}";
			})
			
			// 사용자- 봉사활동 신청하기 버튼
			$('#appBtn').click(function(){
				var bNo = $('#bNo_hi').val();
				var appNo = 1;
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
					location.href = "vUpdaateApp.vo?bNo=" + bNo + "&appNo=" + appNo + "&localInput=" + "${localInput}" 
							+ "&statusInput=" + "${statusInput}" + "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}";
				}
			})
			
			// 사용자- 봉사활동 취소하기 버튼
			$('#cancleBtn').click(function(){
				var bNo = $('#bNo_hi').val();
				var appNo = 2;
				swal({
					title : '봉사활동',
					text : '취소하시겠습니까?',
					icon : 'warning',
					buttons : ["아니오", "예"],
					dangerMode: true,
				}).then((ok) => {
					if(ok){
						swal({
							title : '취소완료',
							text : '봉사활동 신청 취소되었습니다.',
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
					location.href = "vUpdaateApp.vo?bNo=" + bNo + "&appNo=" + appNo + "&localInput=" + "${localInput}" 
					+ "&statusInput=" + "${statusInput}" + "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}";
				}
			})
			
			// 새로고침 막기
			window.onkeydown = function() {
				var kcode = event.keyCode;
				if(kcode == 8 || kcode == 116) event.returnValue = false;
			}
			
			// 목록으로 가기
			$('#listBack').click(function(){
				if("${localInput}" == "" && "${statusInput}" == "" && "${startInput}" == "" && "${endInput}" == ""){ // 옵션 설정하지 않았을 경우
					location.href = "vList.vo?page=" + "${pi.currentPage}";
				} else { // 검색 옵션 설정 할 경우
					location.href = "vOption.vo?bNo=" + "${v.bNo}" + "&localInput=" + "${localInput}" + "&statusInput=" + "${statusInput}" +
	                "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}" + "&page=" + "${pi.currentPage}";
				}
			})
			
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