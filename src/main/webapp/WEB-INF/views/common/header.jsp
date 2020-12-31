<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />
<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> -->
<!-- 결제 API -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" type="text/css">
</head>
<body>
	<header>
	<!-- 메뉴바는 어느 페이지든 포함하고 있을 테니 여기서 contextPath 변수 값 만들기 -->
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	
	<!--로그인 바 -->
	<c:if test="${ empty sessionScope.loginUser }">
		<div id = 'loginDiv' align = "right">
			<div id="smallMenu">
				<a  href="siteInfo.bo">사이트 소개</a>
				<a  href="plist.po" >쇼핑몰</a>
				<a  href="slist.sh">무료나눔</a>
				<a  href="vList.vo">봉사활동</a>
				<a  href="alist.ao">문의사항</a>
			</div>
			<div>
				<c:url var="loginView" value="loginView.me"/>
				<c:url var="signUp" value="signUp.me"/>
				<button class="input" onclick="location.href='${loginView}'">로그인</button>
				<button class="input" onclick="location.href='${signUp}'">회원가입</button>
			</div>
		</div>	
	</c:if>
	<c:if test="${ !empty sessionScope.loginUser }">
		<c:if test="${loginUser.userGrade == 'admin'}">
			<div id = 'loginDiv' align = "right">
				<div id="smallMenu">
					<a  href="siteInfo.bo">사이트 소개</a>
					<a  href="plist.po" >쇼핑몰</a>
					<a  href="slist.sh">무료나눔</a>
					<a  href="vList.vo">봉사활동</a>
					<a  href="alist.ao">문의사항</a>
				</div>
				<c:url var="adminPage" value="adminPage.me"/>
				<c:url var="logout" value="logout.me"/>
				<button class="input" onclick="location.href='${adminPage}'">관리자 페이지</button>
				<br>
				<button class="input2" id="alaramBtn"><img id="alarambell" src="${pageContext.request.contextPath}/resources/images/alarmbell_off.png"/></button>
				<div id="alarambox" hidden>
					<table id="alaramTable">
						<tr>
							<td class="alaramTitle">새로운 알림</td>
						</tr>
						<tr>
							<td id="newAlaram"></td>
						</tr>
						<tr>
							<td class="alaramTitle">이전 알림</td>
						</tr>
						<tr>
							<td id="oldAlaram"></td>
						</tr>
					</table>
				</div>
				<c:out value="${ loginUser.userNickName }님"/>
				<button class="input2" onclick="location.href='${logout}'">로그아웃</button>
			</div>
		</c:if>
		<c:if test="${loginUser.userGrade != 'admin'}">
			<div id = 'loginDiv' align = "right">
				<div id="smallMenu">
					<a  href="siteInfo.bo">사이트 소개</a>
					<a  href="plist.po" >쇼핑몰</a>
					<a  href="slist.sh">무료나눔</a>
					<a  href="vList.vo">봉사활동</a>
					<a  href="alist.ao">문의사항</a>
				</div>
				<c:url var="myinfo" value="memberInfo.me"/>
				<c:url var="logout" value="logout.me"/>
				<c:url var="cartList" value="cartList.po"/>
				<c:url var="wishList" value="wishList.po"/>
				<button class="input" onclick="location.href='memberInfo.me'">마이페이지</button>
				<button class="input" onclick="location.href='${cartList}'">장바구니</button>
				<button class="input" onclick="location.href='${wishList}'">찜목록</button>
				<br>
				<button class="input2" id="alaramBtn"><img id="alarambell" src="${pageContext.request.contextPath}/resources/images/alarmbell_off.png"/></button>
				<div id="alarambox" hidden>
					<table id="alaramTable">
						<tr>
							<td class="alaramTitle">새로운 알림</td>
						</tr>
						<tr>
							<td id="newAlaram"></td>
						</tr>
						<tr>
							<td class="alaramTitle">이전 알림</td>
						</tr>
						<tr>
							<td id="oldAlaram"></td>
						</tr>
					</table>
				</div>
				<c:out value="${ loginUser.userName }님"/>
				<button class="input2" onclick="location.href='${logout}'">로그아웃</button>
			</div>
		</c:if>
	</c:if>
	
	<c:if test="${!empty  image }">
	<div class="slick-items">
		<c:if test="${empty  bImage1.bNo }">
	        <div><img src="${pageContext.request.contextPath}/resources/images/environmental-protection-683437_1280.jpg"></div>
	        <div><img src="${pageContext.request.contextPath}/resources/images/KakaoTalk_20201102_145820034_01.jpg"></div>
	        <div><img src="${pageContext.request.contextPath}/resources/images/KakaoTalk_20201102_151810962_02.jpg"></div>
	        <div><img src="${pageContext.request.contextPath}/resources/images/melons-4507974_1280.jpg"></div>
        </c:if>
        
		<c:if test="${!empty  bImage1.bNo }">
	        <div><a href="${bImage1.bContent }"><img src="${ pageContext.request.contextPath }/resources/buploadFiles/${ files1.fChangeName }"></a></div>
        </c:if>
		<c:if test="${!empty  bImage2.bNo }">
	        <div><a href="${bImage2.bContent }"><img src="${ pageContext.request.contextPath }/resources/buploadFiles/${ files2.fChangeName }"></a></div>
        </c:if>
		<c:if test="${!empty  bImage3.bNo }">
	        <div><a href="${bImage3.bContent }"><img src="${ pageContext.request.contextPath }/resources/buploadFiles/${ files3.fChangeName }"></a></div>
        </c:if>
		<c:if test="${!empty  bImage4.bNo }">
	        <div><a href="${bImage4.bContent }"><img src="${ pageContext.request.contextPath }/resources/buploadFiles/${ files4.fChangeName }"></a></div>
        </c:if>
    </div>
        <div id="pager"> 
        	<div class="prev"> 
        		<img id='prevImg' src="${pageContext.request.contextPath}/resources/images/이전.png"> 
        	</div> 
        	<div class="next"> 
        		<img id='nextImg' src="${pageContext.request.contextPath}/resources/images/다음.png"> 
        	</div> 
        </div>
    <script type="text/javascript">
		$(document).ready(function () {
			$('.slick-items').slick({
				autoplay : true,  /* 자동으로 다음이미지 보여주기 */
				dots: true, /* 아래점 */  
				speed : 900 /* 이미지가 슬라이딩시 걸리는 시간 */,
				infinite: true, /* 맨끝이미지에서 끝나지 않고 다시 맨앞으로 이동 */  
				autoplaySpeed: 3000 /* 이미지가 다른 이미지로 넘어 갈때의 텀 */,
				prevArrow: $('#prevImg'), 
				nextArrow: $('#nextImg'),
				slidesToShow: 1,  /* 화면에 보여질 이미지 갯수*/      
				slidesToScroll: 1, /* 스크롤시 이동할 이미지 갯수 */ 
				fade: true
			});
		});
	</script>
  </c:if>
  <c:if test="${empty  image }">
	<!-- 이미지 배너 슬라이드 -->
	<div class="slick_items">
        <img src="resources/images/KakaoTalk_20201102_151810962_02.jpg">
    </div>
	</c:if>
	<!-- 메뉴 네비게이터 -->
    <nav>
        <a href="home.do"><img id="logo" src="resources/images/캡처.PNG" width = '230'></a>
        <div id = 'div2'>
            <ul id = 'main_menu'>
                <li id = 'main1' class = "main_menu_li">
                    <a  href="siteInfo.bo">사이트 소개</a>
                </li>
                <li id = 'main2' class = "main_menu_li">
                    <a  href="plist.po" >쇼핑몰</a>
                </li>
                <li id = 'main3' class = "main_menu_li">
                    <a  href="slist.sh">무료나눔</a>
                </li>
                <li id = 'main4' class = "main_menu_li">
                    <a  href="vList.vo">봉사활동</a>
                    <div id = 'sub_menu4' hidden>
                       <a href="vList.vo" class ='sub_btn' >봉사활동</a> |
                       
                       <c:if test="${ !empty loginUser }">
                        <a href="vReview.vo" class ='sub_btn' id="alist" >봉사활동 후기</a>
                       </c:if>
                       <c:if test="${ empty loginUser }">
                       <a href="#" class ='sub_btn' id="nolist" onclick="alistLogin();">봉사활동 후기</a>
                       </c:if>
                    </div>
                </li>
                <li id = 'main5' class = "main_menu_li">
                    <a>고객센터</a>
<!--                     <ul id = 'sub_menu5' class ='sub_btn' hidden> -->
                    <div id = 'sub_menu5' hidden>
                       <a href="qlist.qo" class ='sub_btn' >자주묻는질문</a> |
                       
                       <c:if test="${ !empty loginUser }">
                        <a href="alist.ao" class ='sub_btn' id="alist" >문의사항</a>
                       </c:if>
                       <c:if test="${ empty loginUser }">
                       <a href="#" class ='sub_btn' id="nolist" onclick="alistLogin();">문의사항</a>
                       </c:if>
                    </div>
                    <script>
                    	function alistLogin(){
                    		alert('로그인이 필요한 서비스입니다.');
                    		document.location.href="loginView.me"
                    	}
                    </script>
                </li>
            </ul>
        </div>
    </nav>
	<hr id="headerhr">
    <br clear="all">
    </header>
    <script>
    	//전역변수 선언 모든 홈페이지에서 사용 할 수 있게 header에서 생성
    	
    	//웹소켓5 script
    	let socket = null;
		$(document).ready(function (){
			console.log("웹소켓 연결시도")
			connectWs();
			
			$('.newAlarmbox').click(function(){
				var vNo = $(this).children('#alaraNo').val();
				console.log(vNo);
			})
    	});
		//웹소켓 연결 시도	
		function connectWs(){
			sock = new WebSocket( "ws://"+location.host+"/spring/echo/websocket" );
			//sock = new WebSocket( "ws://localhost:9900/spring/echo/websocket" );
		   	socket = sock;
		 
		   	sock.onopen = function() {
		           console.log('info: 웹소켓 연결됨');
		           updateAlarm();
	    	};
    		
			sock.onmessage = function(evt) {//웹소켓에 전송된 메시지 확인
				var data = evt.data;
			   	console.log("ReceivMessage : " + data + "\n");
		 		
			   	updateAlarm();
	    
		    	sock.onclose = function() {
		      		console.log('웹소켓 연결 끊김');
		      		/* setTimeout(function(){conntectWs();} , 1000); */
		    	};
	    
	    		sock.onerror = function (err) {console.log('웹소켓 Errors : ' , err);};
			}
		}
		
		function updateAlarm(){
			$.ajax({
				url: 'alarmUpdate.al',
				headers : {
	                'Accept' : 'application/json',
	                'Content-Type' : 'application/json'
	            },
	            data : "JSON",
				success: function(data){
					console.log(data);
					var newValues = $('#newAlaram').html();
					var oldValues = $('#oldAlaram').html();
					
					for(var i in data){
						if(data[i].alarmIsread == "N"){
							$('#alarambell').attr("src", "${pageContext.request.contextPath}/resources/images/alarmbell_on.png");
							newValues += "<div class='newAlarmbox' onclick='alarmClick("+data[i].alarmNo+")'><input type='hidden' class='alarmUrl' value="+data[i].alarmURL +">"
									  + data[i].alarmTitle + '</div> '
									  + "<span id='alarmDate'>" + data[i].alarmDate +"</span>"
							   		  + "<br><hr>"
							
						}else{
							oldValues += "<div class='newAlarmbox'><a  href="+data[i].alarmURL +" id='alarmUrl'>"
									  + data[i].alarmTitle + '</a></div> '
									  + "<span id='alarmDate'>" + data[i].alarmDate +"</span>"
							   		  + "<br><hr>"
						}
						
					}
					
					$('#newAlaram').html(newValues);
					$('#oldAlaram').html(oldValues);
				},
	          
			});
			
		}
		
		$("#alaramBtn").click(function(){
            $('#alarambox').slideToggle();
        });
		
		function alarmClick(alarmNo){
			console.log(alarmNo);
			var url = $(this).children(".alarmUrl").val();
// 			location.href = 
		 	$.ajax({
	        	url: 'alarmClick.al',
	        	dataType:'json',
	            data: {
	            	alarmNo:alarmNo,
				},
				async: false,
	            success: function(data){
	            	console.log(data);
	            	console.log(data.result);
	            	location.href=data.alarmUrl;
	            },
	            error: function(data){
	               alert("ajax 에러 발생");
	            }
	    	});
		}
		
		// 글 리스트를 누르면 상세보기로 이동
    	//내용과 ok버튼
    	function sweetAlert(text){
    		swal(text);
    	}
    	function sweetAlert(title, text){
    		swal(title,text);
    	}
    	// 제목과 내용과 아이콘
    	// icon  : "warning", "error", "success", "info", 생략시 ""
	    function sweetAlert(title, text, icon) {
	    	swal({
	    		  title: title,
	    		  text: text,
	    		  icon: icon,
	    		});
	    }/*
	   	 title : 제목, 생략시 ""
	   	 text  : 내용, 생략시""
	   	 icon  : "warning", "error", "success", "info", 생략시 ""
	   	 button : 버튼 이름
	   	*/
	    function sweetAlert(title, text, icon, button) {
	    	swal({
	    		  title: title,
	    		  text: text,
	    		  icon: icon,
	    		  button: button,
	    		});
	    }
    	
    	/*
    	//확인하고 액션이 필요할때 사용
    	function actionAlert(text){
    		swal(text)
    		.then((value) => {
    		  //확인했을때
    		});
    	}
    	*/
    	
    	//확인, 취소 액션
    	function sweetAlertAction(title, text, okmessage, url) {
    		swal({
    			  title: title,
    			  text: text,
    			  icon: "warning",
    			  buttons: true,
    			  dangerMode: true,
    			}).then((ok) => {
    			  if (ok) {
    			    swal(okmessage, {
    			      icon: "success",
    			    }).then((ok) => {
    			    	if(ok){
    			    		url;
    			    	}
    			    });
    			  } else {
    			    swal("취소하였습니다.");
    			  }
    			});
	    }
		//상단바 고정
    	window.addEventListener('scroll', function(){
            const header = document.querySelector('#loginDiv');
            header.classList.toggle("sticky", window.scrollY > 0);
        });
    	
    	//상단바가 메뉴바 지나갈때 메뉴바 추가
    	var menu = $("#div2").offset().top;
    	$(window).scroll(function() {
    	  	var window = $(this).scrollTop();

    	    if(menu <= window) {
    	      $("#smallMenu").addClass("show");
    	    } else {
    	      $("#smallMenu").removeClass("show");
    	    }
    	})
    	
    </script>
</body>
</html>
