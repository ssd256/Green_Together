<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께 그린</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myPage_review.css" type="text/css">
</head>
<body>
   <h1 id="reviewInfo">후기 작성</h1>	
   <hr id="review_hr">
   
       <table id="product_table">
           <tr>
               <th>상품명</th>
               <td>${ order.pName }</td>
           </tr>
           <tr>
               <th>상품가격</th>
               <td><fmt:formatNumber value="${ order.orderPay }" pattern="###,###,###"/>원</td>
           </tr>
       </table>
       
       <form id="reviewForm" method="post" name="reviewInfo" action="reviewInsert.po" enctype="Multipart/form-data" target="memberOrder" onsubmit="return reviewForm();"> 
       <input type="hidden" id="oNo" name="oNo" value="${ order.oNo }">
       <input type="hidden" id="oId" name="oId" value="${ order.oId }">
       <input type="hidden" id="pNo" name="pNo" value="${ order.pNo }">
       <table id="review_table">
           <tr>
               <th>별점</th>
               <td >
               	<p class="star_grade">
				  <a id="a1" href="#">★</a>
				  <a id="a2" href="#">★</a>
				  <a id="a3" href="#">★</a>
				  <a id="a4" href="#">★</a>
				  <a id="a5" href="#">★</a>
				  <input type="hidden" id="starCount" name="starCount" value="5">
               </p>
               </td>
           </tr>
           <tr>
               <th>사진</th>
               <td class="img">
					<div id="imgArea1" class="pictureArea">
						<img id="img1" class="imgs"/>
					</div>
				</td>
           </tr>
			<tr>
			<th>후기작성</th>
				<td>
					<textarea id="review_detail" name="content" placeholder="특수문자나 영어는 제외하고 적어주세요." required></textarea>
				</td>
			</tr>
       </table>
       
       <div id="fileArea">	
	   			<input type="file" id="thumbnailImg1" multiple="multiple" name="uploadFile" onchange="LoadImg(this,1)"/>
   		</div>
       
       <div id="btn_box">
           <input type="button" class="btn_box" id="cancleBtn" value="취 소" onclick="window.close();">	
           <input type="submit" class="btn_box" id="reviewBtn" value="등 록">	
       </div>
    </form>
    
    <script>
 		// 별점 선택
 		var star;
		 $('.star_grade a').click(function(){
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			star = $('.on').length;
			$('#starCount').val(star);
			return false;
		});
		console.log($('#starCount').val());
    	
		
    	// 사진 업로드 시 자리 지정
   		$(function(){
  			$("#fileArea").hide();
  			
  			$("#imgArea1").click(function(){
  				$("#thumbnailImg1").click();
  			});
   		});
      		
    	
      	// 이미지 업로드 함수
   		function LoadImg(value, num){
   			if(value.files && value.files[0]){
   				var reader = new FileReader();
   				
   				reader.onload = function(e){
   					switch(num){
   					case 1:
   						$('#img1').attr("src", e.target.result);
   						break;
   					case 2:
   						$('#img2').attr("src", e.target.result);
   						break;
   					}
   				}
   				reader.readAsDataURL(value.files[0]);
   			}	   			
   		};
   		
   			
   		function reviewForm(){
   		// 특수문자만 제외
   			var review = $('#review_detail').val();
   			var reviewExp = /^[@#$%&*a-zA-Zㄱ-ㅎ|s]*$/;
				
			if(reviewExp.test(review)){
				swal({
					text: '특수문자나 영어를 제외하고 작성해주세요.',
					icon: 'info',
					closeOnClickOutside: false,
				}).then((ok) => {
    				if(ok){
    					swal.close();						
    				}
				})
				$('#review_detail').focus();
				return false;
			} else{
				window.close();
				return true;
			}
   		}
    </script>	
    
</body>
</html>