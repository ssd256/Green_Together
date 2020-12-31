<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shares/sharesInsert.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp"/>
    <section>
<!-- 		<p id="sectionTitle">물품나눔 작성하기 -->
<!-- 		<p> -->
<!-- 		<hr> -->

		<div class="writeDiv">
			<form action="sInsert.sh" method="post" enctype="multipart/form-data">
			
				<input type="hidden" name="userId" value=""/>
<%-- 				<input type="hidden" name="userId" value="${ loginUser.userId }"/> --%>
				<input type="hidden" name="category" value="shares" />
				<table id="writeContent">
					<tr>
						<td class="tableTitle" style="width: 150px;" >지역</td>
						<td colspan="3">
						<input type="text" id="sample5_address" name="area" placeholder="주소를 입력해주세요." required>
						<input type="button" onclick="sample5_execDaumPostcode()" style="background: #a4c639; color: white;" value="주소 검색"><br>
						<div id="map" style="width:510px;height:120px;margin-left:23px;"></div>
<!-- 						<select id="titleText" name="area"> -->
<!-- 								<option>==지역 선택==</option> -->
<!-- 								<option>서울</option> -->
<!-- 								<option>경기도</option> -->
<!-- 								<option>지방</option> -->
<!-- 						</select></td> -->
					</tr>
					<tr>
						<td class="tableTitle">제목</td>
						<td colspan="3"><input type="text" id="titleText" name="titleText"
							placeholder="제목을 입력해주세요." required/></td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th class="tableTitle">작성자</th> -->
<!-- 						<td colspan="3"> -->
<%-- 							<input type="text" id="titleText" name="sWriter" readonly value="${ loginUser.id }" style="background: lightgrey;"> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr>
						<td class="tableTitle">재고</td>
						<td colspan="3"><input type="text" id="titleText" name="stock"
							placeholder="재고를 입력해주세요." required/></td>
					</tr>

					<tr>
						<td class="tableTitle">대표 이미지</td>
						<td colspan="3">
							<div id="titleImgArea">
								<img id="titleImg" width="620" height="200">
							</div>
						</td>
					</tr>
					<tr>
						<td class="tableTitle">참조 이미지</td>
						<td>
							<div id="contentImgArea1">
								<img id="contentImg1" width="300" height="100">
							</div>
						</td>
						<td>
							<div id="contentImgArea2">
								<img id="contentImg2" width="300" height="100">
							</div>
						</td>
					</tr>
					<tr>
						<td class="tableTitle">내용 작성</td>
						<td colspan="3" rowspan="4"><textarea id="contentText" name="content"
								placeholder="상품 상세설명을 작성해주세요." required></textarea></td>
					</tr>


				</table>

				<div id="fileArea">
					<input type="file" id="thumbnailImg1" multiple="multiple"
						name="thumbnailImg1" onchange="LoadImg(this,1)" required> 
					<input type="file" id="thumbnailImg2" multiple="multiple"
						name="thumbnailImg2" onchange="LoadImg(this,2)" required> 
					<input type="file" id="thumbnailImg3" multiple="multiple"
						name="thumbnailImg3" onchange="LoadImg(this,3)" required> 
				</div>
				<script>
				
	    		$('input[name="stock"]').on("keyup", function(){
					var a = $('input[name="stock"]').val();
					var temp = /^[0-9]{1,10000}$/g;   
					$('input[name="stock"]').val(a);
					
					if(!temp.test(a)){
						alert("숫자만 입력 가능합니다.");
					}
				});

					$(function() {
						$("#fileArea").hide();

						$("#titleImgArea").click(function() {
							$("#thumbnailImg1").click();
						});
						$("#contentImgArea1").click(function() {
							$("#thumbnailImg2").click();
						});
						$("#contentImgArea2").click(function() {
							$("#thumbnailImg3").click();
						});
					});

					function LoadImg(value, num) {
						if (value.files && value.files[0]) {
							var reader = new FileReader();

							reader.onload = function(e) {
								switch (num) {
								case 1:
									$("#titleImg").attr("src", e.target.result);
									break;
								case 2:
									$("#contentImg1").attr("src",
											e.target.result);
									break;
								case 3:
									$("#contentImg2").attr("src",
											e.target.result);
									break;
								}
							}

							reader.readAsDataURL(value.files[0]);
						}
					}
					
					
				</script>
				
				         <!-- 지도API -->
      <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=27317bdd71042aa55e5b61a2ddfb1d4d&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
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


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
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

				<input id="cancleBtn" type="button" onClick="location.href='slist.sh'" value="취소" /> 
				<input id="submitBtn" type="submit" value="등록" />
			</form>
		</div>
		<br><br><br><br><br><br>
    </section>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>
    
    <script>
    	$(function(){
    		$(window).scroll(function(){
    			if($(this).scrollTop() < 200){
    				$('#top').fadeOut();
    			} else {
    				$('#top').fadeIn();
    			}
    		});
    		
    		$('#top').click(function(){
    			$('html, body').animate({
    				scrollTop : 0
    			}, 400);
    			return false;
    		});
    	});
    </script>
</body>
</html>
