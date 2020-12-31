<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<style type="text/css">
	/* 섹션 */
	.divTitle{
		text-align: center;
 		color: rgb(94, 94, 94); 
	}
	
	/* 인기상품 css */
	.bestProduct{/* 인기상품DIV */ width: 100%;}	
	
	#bestProductTbImg,#bestProductName,#bestProductPrice{/* 인기상품보이는 테이블 */width:100%;}
	
	
    .pimg{	/*상품 이미지*/
    	text-align: center;
		display : table-cell;
		width: 20%;
		height: 300px;
        }
        
    .pimg img{
  		width: 300px;
		height: 300px;
		cursor: pointer;
   		}
        
    .ptd{ /*상품 이름, 가격*/
    	text-align: center;
        width: 50px;
    	height: 30px; 
    	font-size: large;  	
    	font-weight: bold;
    	color: gray;
    	cursor: pointer;
        }
    
    .pPrice{
    	text-align: center;
        width: 50px;
    	height: 30px; 
    	font-size: large;  	
    	font-weight: bold;
    	color: gray;
    }    
        

	/* 봉사활동/무료나눔 큰 div */
	.boardFlex{
		display: flex;
	}
	/* 봉사활동/무료나눔 이미지 쪽 div */
	.boardLeft{
		flex: 6;
		width: 800px;
		height: 470px;
	}
	#vImg{
		text-align: left;
	}
	#sImg{
		text-align: right;
	}
	
	/* 봉사활동/무료나눔 이미지 클래스 */
	.viewImg{
		width: 85%;
		height: 470px;
		border-radius: 10px;
	}
	
	/* 봉사활동/무료나눔 게시판 쪽 div */
	.boardRight{
		flex: 4;
	}
	#boardRightMargin{
		float: right;
	}
	
	span{
		font-size: 20px;
		font-weight: bolder;
	}
	
	/* 봉사활동/무료나눔 게시판 정보 제목 */
	.boardTitle{
		text-align: center;
		width: 480px;
	}
	
	/* 게시판 이름 아래 녹색 줄 */
    .greenDiv{
    	width: 180px;
    	height: 3px;
    	background: rgb(193, 223, 135);
    	border-radius: 10px;
    	margin-left: 160px;
    	margin-top: 10px;
   	    margin-bottom: 25px;
    }
	
	
	/* 봉사활동/무료나눔 게시판 정보 */
	.boradInfo{
		display: flex;
		width: 600px;
		margin-bottom: -5px;
	}
	/* 봉사활동/무료나눔 게시판 정보 - 지역 */
	.locationTd{
		color: rgb(68, 193, 163);
		font-weight: bold;
		width: 60px;	
	}
	#tb, #ts{
		font-size: 16px;
		border-spacing: 15px 20px;
	
	}
	/* 봉사활동/무료나눔 게시판 정보 - 내용 */
	.bTitle{
		font-weight: bold;
		width: 300px;
		text-align:left; 
		text-overflow:ellipsis; 
		overflow:hidden; 
		white-space:nowrap;
		cursor: pointer;
	}
	/* 봉사활동/무료나눔 게시판 정보 - 날짜 */
	.bTime{
		font-weight: bold;
		width: 150px;
		text-align: center;
		color: rgb(94, 94, 94);
	}
	
	/* 고객센터 */
	#csBoard{
		display: flex;
		justify-content: space-around;
		margin: 0 300px;
	}
	
	/*  */
	.csBoardDiv{
		background: rgba(224, 224, 224, 0.42);
		width: 250px;
		height: 100px;
		border: 1px solid black;
		font-weight: bolder;
		color: rgb(94, 94, 94);
		text-align: center;
		display: table;
		cursor: pointer;
	}
	
	/*  */
	.csBoardDiv p{
		display: table-cell;
		vertical-align: middle;
	}
	#headerhr{ margin-top: 20px;}
</style>
</head>
<body>
	 <%@ include file="common/header.jsp"%>
    <section>
	    <div class = "divTitle">
	    	<h2>함께그린 인기상품</h2>
	    </div>
	    <br>

	    <div class="slide_div" id="bestProduct">
	    <table id="bestProductTbImg">
			<tbody>
		    </tbody>
		</table>

		<table id="bestProductName">
			<tbody>
			</tbody>
		</table>
		 
		<table id="bestProductPrice">
			<tbody>
			</tbody>
		</table>  
  		</div>
  		
		<script>
			/* 이미지 받아오는 ajax */
			function productTopListImg(){
				$.ajax({
					url: "productTopListImg.po",
					success: function(data){
						console.log(data);
						
						$tableBody = $('#bestProductTbImg tbody');
						$tableBody.html("");
						
						for(var i in data){
							var $pImg='<td class="pimg" onclick="goPdetail(this)"><img src="resources/product_uploadFiles/'+data[i].fChangeName+'"/>';	
							var $bNo = $('<input type="hidden">').val(data[i].bNo);
							
							$tableBody.append($pImg);
							$tableBody.append($bNo);
							
						}
					}
				});			
			}
	
			function goPdetail(i){
				var bNo = $(i).next('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
				location.href = "pdetail.po?bNo=" + bNo + "&pNo=" + 1;
			}	
			
			/* 상품이름과 가격 받아오는 ajax */
			function productTopList(){
				$.ajax({
					url: "productTopList.po",
					success: function(data){
						console.log(data);
						
 						$NameTableBody = $('#bestProductName tbody');
						$NameTableBody.html("");
						
						$PriceTableBody = $('#bestProductPrice tbody');
						$PriceTableBody.html("");
						
 						for(var i in data){
 						var $tr = $('<tr>');
						var $pName = $('<td class="ptd" onclick="goPdetailn(this)">').text(data[i].pName);
						var $pPrice = $('<td class="pPrice">').text(data[i].pPrice+'원');
						/* 바로가기 글번호 받아오기 */
						var $bNo = $('<input type="hidden">').val(data[i].bNo);
						
						console.log("bNo : " + $bNo);
						
						$NameTableBody.append($pName); 
						$NameTableBody.append($bNo);
 						$PriceTableBody.append($pPrice);
						}  
					}
			});
		}
		
			
			function goPdetailn(n){
				var bNo = $(n).next('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
				location.href = "pdetail.po?bNo=" + bNo + "&pName=" + "1";
			}	
			
		/* 상품은 10분 간격 새로고침 */
		$(function(){
				productTopListImg();
				productTopList();
				setInterval(function(){
					productTopList();
					productTopList();
				}, 60000);	
			})		
		</script>
	    <br>
	    <hr>
	    <br>
	    <br>
	    <div class = "divTitle">
	    	<h2>함께그린 봉사활동</h2>
	    	<br>
	    </div>
	    <br>
		<div class="boardFlex">
			<div class="boardLeft" id="vImg">
				<img alt="봉사활동 이미지" src="${pageContext.request.contextPath}/resources/images/봉사활동예시.PNG" class="viewImg" id="view1">
			</div>
			<div class="boardRight">
				<div class="boardTitle">
					<img alt="게시판 이미지" src="${pageContext.request.contextPath}/resources/images/게시판리스트.jpeg" style="width: 20px;">
					<span>모집중인 봉사활동</span>
					<div class = 'greenDiv'></div>
				</div>
				<div class="boradInfo">
					<table id="tb">
						<thead>
							<tr>
								<th></th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<script>
					function vCurrentList(){
						$.ajax({
							url :"vCurrentList.vo",
							success : function(data){
								$tableBody = $('#tb tbody');
								$tableBody.html("");
								
								for(var i in data){
									var $tr = $('<tr>');
									var $vLocation = $('<td class="locationTd">').text(data[i].vLocation);
									var $bTitle = $('<td class="bTitle" onclick="goBNo(this)">').text(data[i].bTitle);
									var $vDay = $('<td class="bTime">').text(data[i].vDay);
									var $bNo = $('<input type="hidden">').val(data[i].bNo);
									
									
									$tr.append($vLocation);
									$tr.append($bTitle);
									$tr.append($vDay);
									$tr.append($bNo);
									$tableBody.append($tr);
								}
							}
						});
					}
					$(function(){
						vCurrentList();
						setInterval(function(){
							vCurrentList();
						}, 60000);
					});
					function goBNo(t){
						var bNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
						console.log("뭘까요? : " + bNo);
						location.href = "vDetail.vo?bNo=" + bNo + "&localInput=" + "${localInput}" + "&statusInput=" + "${statusInput}" +
                        "&startInput=" + "${startInput}"+ "&endInput=" + "${endInput}" + "&page=" + "${pi.currentPage}";
					}
				</script>
			</div>
		</div>
		<br>
		<br>
		<br>
		<hr>
		<br>
		<br>
		<div class = "divTitle">
	    	<h2>함께그린 무료나눔</h2>
	    	<br>
	    </div>

		<div class="boardFlex">
			<div class="boardRight">
			<div id="boardRightMargin">
				<div class="boardTitle" >
					<img alt="게시판 이미지" src="${pageContext.request.contextPath}/resources/images/게시판리스트.jpeg" style="width: 20px;">
					<span>진행중인 나눔글</span>
					<div class = 'greenDiv'></div>
				</div>
				
				<div class="boradInfo">
					<table id="ts">
						<thead>
							<tr>
								<th></th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				
<!-- 				<div class="boradInfo"> -->
<!-- 					<p class="bLocation"></p> -->
<!-- 					<p class="bTitle"></p> -->
<!-- 					<p class="bTime"></p> -->
<!-- 				</div> -->
<!-- 				<div class="boradInfo"> -->
<!-- 					<p class="bLocation">[제주]</p> -->
<!-- 					<p class="bTitle">제주지역 귤따기 자원 봉사자 모집</p> -->
<!-- 					<p class="bTime">2020-11-05</p> -->
<!-- 				</div> -->
			</div>
					<script>
					function sCurrentList(){
						$.ajax({
							url :"sCurrentList.sh",
							success : function(data){
								$tableBody = $('#ts tbody');
								$tableBody.html("");
								
								for(var i in data){
									var $tr = $('<tr>');
									var $sAddress = $('<td class="locationTd">').text(data[i].sAddress);
									var $bTitle = $('<td class="bTitle" onclick="goSharesBNo(this)">').text(data[i].bTitle);
									var $sDay = $('<td class="bTime">').text(data[i].bModifyDate);
									var $bNo = $('<input type="hidden">').val(data[i].bNo);
									
									
									$tr.append($sAddress);
									$tr.append($bTitle);
									$tr.append($sDay);
									$tr.append($bNo);
									$tableBody.append($tr);
								}
							}
						});
					}
					$(function(){
						sCurrentList();
						setInterval(function(){
							sCurrentList();
						}, 60000);
					});
					function goSharesBNo(t){
						var bNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
						console.log("뭘까요? : " + bNo);
						location.href = "sdetail.sh?bNo=" + bNo;
					}
				</script>
			</div>
			<div class="boardLeft" id="sImg">
				<img alt="봉사활동 이미지" src="${pageContext.request.contextPath}/resources/images/무료나눔예시.PNG" class="viewImg" id="view1">
			</div>
		</div>
	    <br>
	    <br>
	    <br>
		<hr>
		<div class = "divTitle">
	    	<h2>함께그린 고객센터</h2>
	    	<br>
	    </div>
	    <br>
	    <div id="csBoard">
	    	<c:if test="${ !empty loginUser }">
	    	<div class="csBoardDiv"><p onclick="location.href='ainsertView.ao';">문의하기</p></div>
	    	<div class="csBoardDiv"><p onclick="location.href='qlist.qo'">FQA<br>자주묻는질문</p></div>
	    	<div class="csBoardDiv"><p onclick="location.href='alist.ao'">Q&A<br>문의사항</p></div>
	   		</c:if>
	   		<c:if test="${ empty loginUser }">
	    	<div class="csBoardDiv"><p onclick="loginPlz();">문의하기</p></div>
	    	<div class="csBoardDiv"><p onclick="location.href='qlist.qo'">FQA<br>자주묻는질문</p></div>
	    	<div class="csBoardDiv"><p onclick="loginPlz();">Q&A<br>문의사항</p></div>
	   		</c:if>
	    </div>
	    <script>
          function loginPlz(){
            alert('로그인이 필요한 서비스입니다.');
            document.location.href="loginView.me"
           		}
          
  		$(function(){
			$('.csBoardDiv').mouseenter(function(){
				$(this).css({'background':'black','font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function(){
				$(this).css({'background':'black','font-weight':'bold'});
			})
       </script>
    </section>
    	<c:import url="common/footer.jsp"/>
</body>
</html>