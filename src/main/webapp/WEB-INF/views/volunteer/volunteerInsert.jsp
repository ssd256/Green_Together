<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/volunteer/volunteerInsert.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp"/>

	<section>
    	<div>
    		<h2 id = 'volH3'>봉사활동 등록</h2>
    	</div>
    	<div class = 'greenDiv'></div>
    	<form action="vInsert.vo" method="post" onsubmit="return volunteerInsertF();">
    		<!-- 봉사활동 등록 아래에 제일 큰 div -->
			<div id="formDiv">
				<br>
				<input type="search" placeholder="봉사활동명 입력(20자 내외)" id="vTitle" name="bTitle" required>
				<label id="vTitleResult"></label>
				<div class="whiteDiv"></div>
				<div class="whiteDiv"></div>
				<div class="whiteDiv"></div>
				<div class = 'yellowGreenDiv'></div>
				<!-- 봉사기간,시간,장소,기관,모집인원 -->
				<!-- 봉사기간, 시간 -->
				<div class="vInfomation">
					<div class="vInfoTitle"><label>봉사기간</label></div>
					<div class="vInfoContent">
						<input type="date" name="vDay1" id="vDay1" required>
						<span>~</span>
						<input type="date" name="vDay2" id="vDay2" required>
					</div>
					<div class="vInfoTitle"><label>봉사시간</label></div>
					<div class="vInfoContent">
						<input type="time" name="vTime1" id="vTime1" required>
						<span>~</span>
						<input type="time" name="vTime2" id="vTime2" required>
					</div>
				</div>
				<div class="whiteDiv"></div>
				
				<!-- 봉사장소 -->
				<div class="vInfomation">
					<div id="vInfoTitle2"><label>봉사장소</label></div>
					<div id="vInfoContent2">
						<div id="searchAddress">
							<input type="button" onclick="execDaumPostcode()" value="주소 검색" id="searchBtn">
							<input type="text" id="address1" placeholder="주소 검색 클릭" readonly="readonly" class="tableContent" name="address1">
						</div>
						<div id="detailAddress">
							<label>상세 주소</label>
							<input type="text" name="address2" value="" class="tableContent" id="detailText" required>
						</div>
					</div>
					
				</div>
				
						
				<!-- 등록기관, 모집인원 -->
				<div class="whiteDiv"></div>
				<div class="vInfomation">
					<div class="vInfoTitle"><label>등록기관</label></div>
					<div class="vInfoContent">
						<input type="search" class="vInfoContentInput" name="vAgency" id="vAgency" required placeholder="한글,영어,숫자,띄어쓰기 입력가능 (1~20자)">
					</div>
					<div class="vInfoTitle"><label>모집인원</label></div>
					<div class="vInfoContent">
						<input type="search" class="vInfoContentInput" name="vRecruitment" id="vRecruitment" required placeholder="숫자만 입력 가능">
					</div>
				</div>
				<div class = 'yellowGreenDiv'></div>
				<br>
				<!-- 활동내용+지도API -->
				<span id = 'limitNum'>0/500</span>
				<br>
				<div id = 'vInfoDiv'>
					<div id = 'vContent'>
						<textarea placeholder="활동내용을 입력하세요." id = 'vContentTextarea' name='bContent' required></textarea>
					</div>
					<div id = "mapApi">
						지도API 부분
					</div>
				</div>
				<label>담당자 이름 :</label>
				<input type="search" class="responInfo" name="vResponsibility" id="vResponsibility" required placeholder="한글,영어 입력가능(1~10자)">
				<label>담당자 핸드폰번호 :</label>
				<input type="search" placeholder="숫자만 입력 가능" class="responInfo" name="vPhone" id="vPhone" required>
				<br> 
				<br>
				<br>
				<hr>
				<br>
			</div>
			<div id="submitDiv">
				<button id="backList" onclick="location.href='vList.vo'">목록</button>
				<input type="submit" value="등록" id='addBtn'>
			</div>
    	</form>
    	
    	<!-- 지도API -->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=27317bdd71042aa55e5b61a2ddfb1d4d&libraries=services"></script>
		<script>
		    var mapContainer = document.getElementById('mapApi'), // 지도를 표시할 div
		        mapOption = {
		            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
		            level: 5 // 지도의 확대 레벨
		        };
		
		    //지도를 미리 생성
		    var map = new daum.maps.Map(mapContainer, mapOption);
		    //주소-좌표 변환 객체를 생성
		    var geocoder = new daum.maps.services.Geocoder();
		    //마커를 미리 생성
		    var marker = new daum.maps.Marker({
		        position: new daum.maps.LatLng(37.537187, 127.005476),
		        map: map
		    });
		
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                var addr = data.address; // 최종 주소 변수
		                
		                // 주소 정보를 해당 필드에 넣는다.
		                document.getElementById("address1").value = addr;
		                // 주소로 상세 정보를 검색
		                geocoder.addressSearch(data.address, function(results, status) {
		                	
		                    // 정상적으로 검색이 완료됐으면
		                    if (status === daum.maps.services.Status.OK) {
		
		                        var result = results[0]; //첫번째 결과의 값을 활용
		
		                        // 해당 주소에 대한 좌표를 받아서
		                        var coords = new daum.maps.LatLng(result.y, result.x);
		                        // 지도를 보여준다.
		                        mapContainer.style.display = "block";
		                        map.relayout();
		                        // 지도 중심을 변경한다.
		                        map.setCenter(coords);
		                        // 마커를 결과값으로 받은 위치로 옮긴다.
		                        marker.setPosition(coords)
		                    }
		                });
		            }
		        }).open();
		    }
		</script>
    	
    	<script type="text/javascript">
    		let isVTitle=false;
    		let isAddress=false;
    		let isVAgency=false;
    		let isRecruitment=false;
    		let isvResponsibility=false;
    		let isvPhone=false;
    		
    		// 제목 20자
    		$('#vTitle').change(function(){
    			$("#vTitleResult").show();
    			var regExp = /^.{1,20}$/;
    			if(!regExp.test($(this).val())){
    				$("#vTitleResult").text("글자수 20자 이내").css("color", "red");
    				$('#vTitle').focus();
    				isVTitle = false;
    			} else {
    				$("#vTitleResult").hide();
    				isVTitle = true;
    			}
    		});
    		
    		// 봉사활동 날짜 제한
    		var sysdate = new Date().toISOString().substring(0, 10);
    		$('#vDay1').attr('min', sysdate); // 시작날짜는 오늘 이후
    		var vDay1 = 0;
    		var vDay2 = 0;
			$('#vDay1').change(function(){
	    		vDay1 = $('#vDay1').val();
				$('#vDay2').attr('min', vDay1); // 끝날짜는 시작날짜와 같거나 이후
			});
			$('#vDay2').change(function(){
				vDay2 = $('#vDay2').val();
			});
			
			$('#vTime1').change(function(){ // 시작날짜 끝날짜가 같다면 끝나는 시간은 시작시간 보다 작을 수 없다.
				var vTime1 = $('#vTime1').val();
				if(vDay1==vDay2){
					$('#vTime2').attr('min', vTime1);
				}
			});
			
			
			// 모집기관
			$('#vAgency').change(function(){
				var regExp = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\s]{1,20}$/;
    			if(!regExp.test($(this).val())){
    				$('#vAgency').focus();
    				isVAgency = false;
    			} else {
    				isVAgency = true;
    			}
			});
			
			// 모집인원
			$('#vRecruitment').change(function(){
				var regExp = /^[0-9]+$/;
    			if(!regExp.test($(this).val())){
    				isRecruitment = false;
    			} else {
    				isRecruitment = true;
    			}
			});
    		
    		
    		// 내용 500자
	    	$('#vContentTextarea').keyup(function (e){
				var content = $(this).val();
				$('#limitNum').html(content.length + "/500");
	
				if(content.length > 500){
					sweetAlert("봉사활동 내용은 최대 500자");
					var con = $(this).val(content.substring(0, 500));
					$('#limitNum').html("500/500");
				}
			});
    		
    		
    		// 담당자 이름
    		$('#vResponsibility').change(function(){
				var regExp = /^[가-힣a-zA-Z]{1,10}$/;
    			if(!regExp.test($(this).val())){
    				$('#vResponsibility').focus();
    				isvResponsibility = false;
    			} else {
    				isvResponsibility = true;
    			}
			});
    		
    		// 담당자 핸드폰 번호
    		$('#vPhone').change(function(){
				var regExp = /^\d{2,3}\d{3,4}\d{4}$/;
    			if(!regExp.test($(this).val())){
    				$('#vPhone').focus();
    				isvPhone = false;
    			} else {
    				isvPhone = true;
    			}
			});
    		
    		// 봉사활동 추가 전 체크
    		function volunteerInsertF(){
    			var addr = $("#address1").val();
    			if(!isVTitle){
    				sweetAlert("올바른 제목을 입력하세요");
    				$("#vTitle").focus();
    				return false;
    			} else if(addr.length == 0){
    				sweetAlert("올바른 주소를 입력하세요");
    				$("#address1").focus();
    				return false;
    			} else if(!isVAgency){
    				sweetAlert("올바른 기관명을 입력하세요");
    				$("#vAgency").focus();
    				return false;
    			} else if(!isRecruitment){
    				sweetAlert("올바른 인원수를 입력하세요");
    				$("#vRecruitment").focus();
    				return false;
    			} else if(!isvResponsibility){
    				sweetAlert("올바른 담당자명을 입력하세요");
    				$("#vResponsibility").focus();
    				return false;
    			} else if(!isvPhone){
    				sweetAlert("올바른 핸드폰 번호를 입력하세요");
    				$("#vPhone").focus();
    				return false;
    			} else {
    				return true;
    			}
    		}
    		
    		
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