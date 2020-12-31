<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shares/sharesDetail.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp"/>
    <section>
      <main class="container">


<div class="replyModal">

 <div class="modalContent">
  
  <div>
   <textarea class="modal_repCon" name="modal_repCon"></textarea>
  </div>
  
  <div>
   <button type="button" class="modal_modify_btn">수정</button>
   <button type="button" class="modal_cancel">취소</button>
  </div>
  
 </div>

 <div class="modalBackground"></div>
 
</div>



         <div class="slideshow-container">
             <c:forEach var="f" items="${ files }">
               <div class="mySlides fade">
                  <img id="imgshares" class="active" src="resources/shares_uploadFiles/${ f.fChangeName }" alt="">
               </div>
   
<!--                <div class="mySlides fade"> -->
<%--                   <img src="resources/shares_uploadFiles/${ f.get(i).getfChangeName() }" alt=""> --%>
<!--                </div> -->
   
<!--                <div class="mySlides fade"> -->
<%--                   <img src="resources/shares_uploadFiles/${ f.get(i).getfChangeName() }" alt=""> --%>
<!--                </div> -->
   
            </c:forEach>
   
               <a class="prevs" onclick="plusSlides(-1)"><img id='prevImg' src="${pageContext.request.contextPath}/resources/images/이전.png"> </a> 
               <a class="nexts" onclick="plusSlides(1)"><img id='nextImg' src="${pageContext.request.contextPath}/resources/images/다음.png"></a>
<!--                <div style="margin-left: 200px; margin-top: -20px"> -->
				<div align="center" style="margin-top: -80px; margin-left:30px;">
                  <span class="dot" onclick="currentSlide(1)"></span> <span
                     class="dot" onclick="currentSlide(2)"></span> <span class="dot"
                     onclick="currentSlide(3)"></span>
               </div>
         </div>


         <script>
            var slideIndex = 1;
            showSlides(slideIndex);

            function plusSlides(n) {
               showSlides(slideIndex += n);
            }

            function currentSlide(n) {
               showSlides(slideIndex = n);
            }

            function showSlides(n) {
               var i;
               var slides = document.getElementsByClassName("mySlides");
               var dots = document.getElementsByClassName("dot");
               if (n > slides.length) {
                  slideIndex = 1
               }
               if (n < 1) {
                  slideIndex = slides.length
               }
               for (i = 0; i < slides.length; i++) {
                  slides[i].style.display = "none";
               }
               for (i = 0; i < dots.length; i++) {
                  dots[i].className = dots[i].className.replace(
                        " active", "");
               }
               slides[slideIndex - 1].style.display = "block";
               dots[slideIndex - 1].className += " active";
            }
         </script>

<%--       <c:url var="sApply" value="sApply.sh"> --%>
<%--          <c:param name="bNo" value="${ shares.bNo }"/> --%>
<%--       </c:url> --%>

         <div class="right-column">


            <div class="product-description">
            
               <span>작성자 : ${ shares.mId }</span><br> <span>남은 수량 : ${ shares.sStock }</span>
               <h2>${ shares.bTitle }</h2>
               <p>${ shares.bContent }</p>
            </div>

               <input type="hidden" id="address1" value="${ shares.sAddress }"/>

            <div class="product-configuration">
               <p style="color: gray;"><span>주소 : ${ shares.sAddress }</span></p>
               <div class="cable-config">
<!--                   <button id="hovermap">지도 상세보기</button> -->
						<div id="mapApi" style="width:520px;height:200px;margin-bottom: 5px; " ></div>
						<a href="alist.ao">문의사항 바로가기</a>
               </div>
            </div>
            
            
            
            
            
            
            
              <c:if test="${ shares.sStock == 0 }">
            <div class="product-price" >
               <input id="closedBtn" type="button" class="cart-btn" value="매진되었습니다.">
            </div>
              </c:if>
            
<!--  || loginUser.userId != shares.mId -->
              <c:if test="${ !empty apply }">
            <div class="product-price" >
               <input id="noBtn" type="button" class="cart-btn" value="물품 신청 취소하기">
            </div>
              </c:if>
              
              <c:if test="${ empty apply and shares.sStock > 0 }">
            <div class="product-price" >
               <input id="cancleBtn" type="button" class="cart-btn" value="물품 신청하기">
            </div>
            </c:if>

<%--       <c:url var="sApply" value="sApply.sh"> --%>
<%--          <c:param name="bNo" value="${ shares.bNo }"/> --%>
<%--       </c:url> --%>
         </div>
      </main>
      
      <script>
		$('#cancleBtn').click(function(){
			var bNo = ${ shares.bNo }

			swal({
				title : '무료 나눔',
				text : '신청하시겠습니까?',
				icon : 'warning',
				buttons : ["아니오", "예"],
				dangerMode: true,
			}).then((ok) => {
				console.log(ok);
				if(ok){
					swal({
						title : '신청완료',
						text : '나눔 신청이 완료되었습니다.',
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
				location.href = "sApply.sh?bNo=" + bNo;
			}
		})
		
			$('#noBtn').click(function(){
				var bNo = ${ shares.bNo }

				swal({
					title : '무료 나눔',
					text : '취소하시겠습니까?',
					icon : 'warning',
					buttons : ["아니오", "예"],
					dangerMode: true,
				}).then((ok) => {
					console.log(ok);
					if(ok){
						swal({
							title : '취소완료',
							text : '나눔 신청이 취소되었습니다.',
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
					location.href = "sApplyDelete.sh?bNo=" + bNo;
				}
			})
      </script>

      <br><br>
      
      <c:url var="blist" value="slist.sh">
         <c:param name="page" value="${ page }"/>
      </c:url>
      <c:url var="bupView" value="sUpdateForm.sh">
         <c:param name="bNo" value="${ shares.bNo }"/>
         <c:param name="page" value="${ page }"/>
      </c:url>
      <c:url var="bdelete" value="sDelete.sh">
         <c:param name="bNo" value="${ shares.bNo }"/>
      </c:url>
     

      <div>
         <button id="listBtn" onclick="location.href='${ blist }'">목록</button>
<!--          <button class="reportBtn">신고</button> -->
		 <c:if test="${ loginUser.userId == shares.mId }">
         <button class="editBtn" onclick="location.href='${ bupView }'">수정</button>
         </c:if>
         <c:if test="${ loginUser.userId == shares.mId }">
         <button class="deleteBtn" onclick="location.href='${ bdelete }'">삭제</button>
         </c:if>
      </div>


      <br>

      <hr id="line">
      
      <div class="replyArea">
         <div id="replySelectArea">
            <table id="replySelectTable" style="width: 100%">
               <tr style="height: 60px;">
                  <td align="center" width="10%">작성자</td>
                  <td align="center" width="70%">댓글 내용</td>
                  <td align="center" width="10%">등록 일자</td>
                  <td align="center" width="10%">수정 / 삭제</td>
               </tr>
            </table>
            
                  <hr id="line2">
<!--             <table id="replySelectTable" style="width: 100%"> -->
<!--                <tr style="height: 60px;"> -->
<!--                   <td width="10%" align="center">user01</td> -->
<!--                   <td width="90%" align="left">댓글의 상세 내용</td> -->
<!--                                     <td width="40%"><button class="reportBtn">신고</button> <button class="editBtn">수정</button>   <button class="editBtn">삭제</button></td> -->
<!--                </tr> -->
<!--             </table> -->
            <table class='replySelectTable' style="width: 100%" id="rtb">
               <thead>
                  <tr>
                     <td colspan="2"><b id="rCount"></b></td>
                  </tr>
               </thead>
               <tbody></tbody>
            </table>
            
                                 <b id="rCount"></b>
         </div>

         <hr id="line">
         <br>

         <div class="replyWriteArea">
            <table style="width: 100%;">
               <tr align="center" style="height: 60px;">
               	  <td width="10%" height="60px">${ loginUser.userId }
                  <td width="100%"><input type="text" id="replyContent"
                     style="resize: none; width: 99%; height: 60px;" /></td>
                  <td width="10%"><button id="addReply" style="height: 65px; width: 80px;">등록</button></td>
               </tr>
            </table>
         </div>
      </div>
    </section>
    
    <script>
        $(function(){
           $("#hovermap").click(function(){
              $("#mapApi").toggle();
           })
        });
	</script>
    
    <script>
      $('#addReply').on('click', function(){
         var cContent = $("#replyContent").val(); // 댓글 내용
         var bNo = ${ shares.bNo }; // 댓글이 달린 게시글 번호, 어느 게시글에 댓글이 달렸는지
         
         // addReply.bo ==> 'success' 전달 받기
         $.ajax({
            url:"addReply.bo",
            data:{cContent:cContent, bNo:bNo},
            type:"post",
            success:function(data){
               if(data == "success"){
                  $("#rContent").val("");
               } else{
            	   alert("작성자 본인만 삭제할 수 있습니다.");
               }
            }
         });
      });
      
		$(function(){
			getReplyList();
			setInterval(function(){
				getReplyList();
			}, 1000); // 1초마다 댓글 리스트를 가지고 옴
		});
      
      function getReplyList(){
         var bNo = ${ shares.bNo };
         
         $.ajax({
            url: "cList.sh",
            data: {bNo:bNo},
            success: function(data){
               console.log(data);
               
               $tableBody = $('#rtb tbody');
               $tableBody.html('');
               
               var $tr;
               var $rWriter;
               var $rContent;
               var $rCreateDate;
               
               $('#rCount').text('댓글(' + data.length + ')');
               
               if(data.length > 0){
                  for(var i in data){
                     $tr = $('<tr style="height: 60px";>');
                     $rWriter = $('<td width=10% align="center" id="memberId">').text(data[i].mId);
                     $rContent = $('<td width=70% id="cContent">').text(data[i].cContent);
                     $rCreateDate = $('<td width=10% align="center">').text(data[i].cDate);
                     $button1 = $('<button id="commentsDelete" onclick="commentsDelete(this)">삭제</button>');
                     $button2 = $('<button id="commentsModify">수정</button>');
					 $cNo = $('<input type="hidden">').val(data[i].cNo);
                     
                     $tr.append($rWriter);
                     $tr.append($rContent);
                     $tr.append($rCreateDate);
                     $tr.append($cNo)
                     $tr.append($button1);
                     $tr.append($button2);
                     $tableBody.append($tr);
                  }
               } else{
                  $tr = $('<tr>');
                  $rContent = $('<td colspan="3">').text('등록된 댓글이 없습니다.');
                  
                  $tr.append($rContent);
                  $tableBody.append($tr);
               }
            }
         });
      }
      
//       $('#commentsDelete').on('click', function(){
// 			var cNo = $(this).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
          
//           // addReply.bo ==> 'success' 전달 받기
//           $.ajax({
//              url:"commentsDelete.sh",
//              data:{cNo:cNo},
//              type:"post",
//              success:function(data){
//                 if(data == "success"){
//                 	getReplyList();
//                 }
//              }
//           });
//        });
      
		function commentsDelete(t){
			var cNo = $(t).siblings('input').val(); // 클릭된 행의 input:hidden 값인 글번호 값을 가지고 옴
			var mId = $(t).siblings('#memberId').text();
			

	          $.ajax({
	              url:"commentsDelete.sh",
	              data:{cNo:cNo, mId:mId},
	              success:function(data){
	                 if(data == "success"){
	                	 getReplyList();
	                 } else{
	                	 alert("작성자 본인만 삭제할 수 있습니다.");
	                 }
	              }
	           });
		}
		
		$(document).on("click", "#commentsModify", function(){
// 			 $(".replyModal").attr("style", "display:block;");
			 $(".replyModal").fadeIn(200);
			 
			 var cNo = $(this).siblings('input').val();
			 var cContent = $(this).siblings('#cContent').text();
			 var mId = $(this).siblings('#memberId').text();
			 
			 $(".modal_repCon").val(cContent);
			 $(".modal_modify_btn").attr("cNo", cNo);
			 $(".modal_modify_btn").attr("mId", mId);
		});

		$(".modal_cancel").click(function(){
// 		 $(".replyModal").attr("style", "display:none;");
		 $(".replyModal").fadeOut(200);
		});
		
		
		$(".modal_modify_btn").click(function(){
			 var modifyConfirm = confirm("정말로 수정하시겠습니까?");
			 
			 if(modifyConfirm) {
			  var data = {
					  cNo : $(this).attr("cNo"),
					  cContent : $(".modal_repCon").val(),
					  mId : $(this).attr("mId")
			    };
			  
			  $.ajax({
			   url : "modifyComments.sh",
			   data : data,
			   success : function(data){
			    
			    if(data == "success") {
			    	getReplyList();
			     $(".replyModal").fadeOut(200);
			    } else {
			     alert("작성자 본인만 할 수 있습니다.");       
			    }
			   }
			  });
			 }
			 
			});
		
		
    </script>
    
		<!-- 지도API -->
      <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=27317bdd71042aa55e5b61a2ddfb1d4d&libraries=services"></script>
		<script>
		encodeURIComponent(document.getElementById('mapApi'));
			var mapContainer = document.getElementById('mapApi'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
		
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			var inputAddress = $('#address1').val();
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
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">무료 나눔 장소</div>'
			        });
			        infowindow.open(map, marker);
		
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});   
    </script>
    
    <%@ include file="../common/footer.jsp"%>
    <img id="top" src="resources/images/top_button2.png"/>
    
    
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