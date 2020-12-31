<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_mVolunteerDetail.css" type="text/css">
</head>
<body>
	<h1 id="h1">상세내역 : ${ v.bTitle }</h1>
	<hr id="title_hr">
	<br><br><br>
	<form action="detailView" method="post" id="mVolunteerDetailForm" name="mVolunteerDetailInForm" onsubmit="mVolunteerDetailIn();">
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
				<br><br>
						
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
		<div id="btnDiv">
			<input type="button" id="okayBtn" value="확 인" onclick="self.close();">
		</div>
		<script type="text/javascript">
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
		</script>
	</form>
</body>
</html>