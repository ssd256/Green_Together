<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린 - 상품수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productUdpateForm.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<section>
		<c:set var="p" value="${ product }" scope="request"/>
       	<c:set var="f" value="${ flist }" />
	
	    <form id="updateForm" action="pupdate.po" method="post" enctype="Multipart/form-data" onsubmit="return updateProduct();">
	    <input type="hidden" name="bNo" value="${ p.bNo }">
    	<div>
	    	<table id="product" class="explan">
	    		<tr>
	    			<th><span>*</span> 카테고리 </th>
	    			<td>
	    				<input type="text" id="categoryChk" name="pCategory" value="${ p.pCategory }" disabled="disabled">
	   				</td>
	    		</tr>
	    		<tr>
	    			<th><span>*</span> 상품명 </th>
	    			<td><input type="text" name="pName" value="${ p.pName }"></td>
	    		</tr>
	    		<tr>
	    			<th><span>*</span> 상품가격 </th>
	    			<td><input type="text" name="pPrice" value="${ p.pPrice }"></td>
	    		</tr>
	    		<tr>
	    			<th><span>*</span> 재고수량 </th>
	    			<td><input type="text" name="pCount" value="${ p.pCount }"></td>
	    		</tr>
	    	</table>
	    </div>
    	
    	<div>
    	<input type="hidden" name="fNum" value="${ f.get(0).fNum }">
    	<input type="hidden" name="fNum" value="${ f.get(1).fNum }">
    	<input type="hidden" name="fNum" value="${ f.get(2).fNum }">
    	<input type="hidden" name="fNum" value="${ f.get(3).fNum }">
    		<table id="img_table">
    			<tr>
    				<th><span>*</span> 대표 사진 </th>
    				<td class="img">
    					<div id="thumbnailArea" class="pictureArea">
							<img id="thumbnail" class="imgs" src="resources/product_uploadFiles/${ f.get(0).fChangeName }">
							<input type="hidden" id="fName1" class="fName" value="${ f.get(0).fChangeName }">
						</div>
    				</td>
					<th><span>*</span> 내용 사진</th>
					<td class="img">
						<div id="contentImgArea1" class="pictureArea">
							<img id="contentImg1" class="imgs" src="resources/product_uploadFiles/${ f.get(1).fChangeName }" >
							<input type="hidden" id="fName2" class="fName" value="${ f.get(1).fChangeName }">
						</div>
					</td>
					<td class="img">
						<div id="contentImgArea2" class="pictureArea">
							<img id="contentImg2" class="imgs" src="resources/product_uploadFiles/${ f.get(2).fChangeName }">
							<input type="hidden" id="fName3" class="fName" value="${ f.get(2).fChangeName }">
						</div>
					</td>
					<th><span>*</span> 설명 사진 </th>
					<td class="img">
						<div id="detailImgArea" class="pictureArea">
							<img id="detailImg" class="imgs" src="resources/product_uploadFiles/${ f.get(3).fChangeName }">
							<input type="hidden" id="fName4" class="fName" value="${ f.get(3).fChangeName }">
						</div>
					</td>
    			</tr>
    		</table>
    	</div>
    	<div>
    		<table id="info" class="explan">
    			<tr>
    				<th><span>*</span> 상품설명</th>
    				<td>
    					<div>
    						<textarea name="pComment" rows="15" cols="93">${ p.pComment }</textarea>
						</div>
    				</td>
    			</tr>
    		</table>
    	</div>
    		
	    <div id="fileArea">	<!-- 파일 업로드 부분 -->
	   			<input type="file" id="thumbnailImg1" name="thumbnailImg1" multiple="multiple" name="reloadFile" onchange="LoadImg(this,1)"/>
	   			<input type="file" id="thumbnailImg2" name="thumbnailImg2" multiple="multiple" name="reloadFile" onchange="LoadImg(this,2)"/>
	   			<input type="file" id="thumbnailImg3" name="thumbnailImg3" multiple="multiple" name="reloadFile" onchange="LoadImg(this,3)"/>
	   			<input type="file" id="thumbnailImg4" name="thumbnailImg4" multiple="multiple" name="reloadFile" onchange="LoadImg(this,4)"/>
   		</div>
		<div id="buttonArea">
		<c:url var="pdetail" value="pdetail.po">
			<c:param name="bNo" value="${ p.bNo }"/>
			<c:param name="pName" value="${ p.pName }"/>
		</c:url>
  			<input type="button" id="cancel" class="btn" value="취 소" onclick="location.href='${ pdetail }'"/>
  			<input type="submit" id="update" class="btn" value="등 록"/>
	   	</div>	
	</form>
	</section>
	<%@ include file="../common/footer.jsp"%>
	
	   <script>
	    	$(function(){
	    		// 사진 업로드 시 자리 지정
	    		$(function(){
	       			$("#fileArea").hide();
	       			
	       			$("#thumbnailArea").click(function(){
	       				$("#thumbnailImg1").click();
	       			});
	       			$("#contentImgArea1").click(function(){
	       				$("#thumbnailImg2").click();
	       			});
	       			$("#contentImgArea2").click(function(){
	       				$("#thumbnailImg3").click();
	       			});
	       			$("#detailImgArea").click(function(){
	       				$("#thumbnailImg4").click();
	       			});
	    		});
	       		
	    		
				//////////////////////////////////// 정규화
	    		$('input[name="pName"]').on("keyup", function(){
					var a = $('input[name="pName"]').val();
					a = a.replace(/[0-9]*$/g, "");   
					$('input[name="pName"]').val(a);
				});
				
	    		$('input[name="pPrice"]').on("keyup", function(){
					var a = $('input[name="pPrice"]').val();
					a = a.replace(/[^가-힣\s\d]*$/g, "");
					$('input[name="pPrice"]').val(a);
				});
	    		
	    		$('input[name="pCount"]').on("keyup", function(){
					var a = $('input[name="pCount"]').val();
					a = a.replace(/[^가-힣\s\d]*$/g, "");
					$('input[name="pCount"]').val(a);
				});
	    		
	    		$('textarea[name="pComment"]').on("keyup", function(){
					var a = $('textarea[name="pComment"]').val();
					a = a.replace(/[^가-힣!.,\s\d]*$/g, "");
					$('textarea[name="pComment"]').val(a);
				});
	    		
	    	});
	   
       		// 이미지 업로드 함수
       		function LoadImg(value, num){
       			if(value.files && value.files[0]){
       				var reader = new FileReader();
       				
       				reader.onload = function(e){
       					switch(num){
       					case 1:
       						$('#thumbnail').attr("src", e.target.result);
       						break;
       					case 2:
       						$('#contentImg1').attr("src", e.target.result);
       						break;
       					case 3:
       						$('#contentImg2').attr("src", e.target.result);
       						break;
       					case 4:
       						$('#detailImg').attr("src", e.target.result);
       						break;
       					}
       				}
       				reader.readAsDataURL(value.files[0]);
       			}	   			
       		};
	       		
	       		
       		//////////////////////////////////// 정규화
       		function updateProduct(){
       			if($('input[name="pName"]').val().length == 0 ){
       				swal({
       					text: '상품명이 비었습니다.',
       					icon: 'info',
       					closeOnClickOutside: false,
	    				}).then((ok) => {
		    				if(ok){
		    					swal.close();						
		    				}
	    				})
	    				return false;
       			}
       			
       			if($('input[name="pPrice"]').val().length == 0 ){
       				swal({
       					text: '가격이 비었습니다.',
       					icon: 'info',
       					closeOnClickOutside: false,
	    				}).then((ok) => {
		    				if(ok){
		    					swal.close();						
		    				}
	    				})
	    				return false;
       			}
       			
       			if($('input[name="pCount"]').val().length == 0 ){
       				swal({
       					text: '재고수량이 비었습니다.',
       					icon: 'info',
       					closeOnClickOutside: false,
	    				}).then((ok) => {
		    				if(ok){
		    					swal.close();						
		    				}
	    				})
	    				return false;
       			}
       			
       			if($('textarea[name="pComment"]').val().length == 0 ){
       				swal({
       					text: '상품설명이 비었습니다.',
       					icon: 'info',
       					closeOnClickOutside: false,
	    				}).then((ok) => {
		    				if(ok){
		    					swal.close();						
		    				}
	    				})
	    				return false;
       			}
       			
       			return true;
       		};
    </script>
</body>
</html>