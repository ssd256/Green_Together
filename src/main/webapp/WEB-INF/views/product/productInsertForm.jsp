<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productInsertForm.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
    <section>
    <!-- 첨부파일 등록을 위해 Multipart/form-data encType 지정 -->
    <form action="pinsert.po" method="post" enctype="Multipart/form-data" onsubmit="return insertProduct();">
    	<div>
	    	<table id="product" class="explan">
	    		<tr>
	    			<th><span>*</span> 카테고리 </th>
	    			<td>
	    				<select id="categorySelect" name="categorySelect">
	    					<option value="카테고리 선택">카테고리 선택</option>
			        		<option value="화장품">화장품</option>
			        		<option value="주방용품">주방용품</option>
			        		<option value="목욕용품">목욕용품</option>
			        		<option value="비누/세제">비누/세제</option>
			        		<option value="생활용품">생활용품</option>
			        		<option value="기타">기타</option>
	    				</select>
	    				<input type="hidden" id="categoryChk" name="pCategory" value="">
	   				</td>
	    		</tr>
	    		<tr>
	    			<th><span>*</span> 상품명 </th>
	    			<td><input type="text" name="pName" placeholder="특수문자를 제외하고 입력해주세요" /></td>
	    		</tr>
	    		<tr>
	    			<th><span>*</span> 상품가격 </th>
	    			<td><input type="text" name="pPrice" placeholder="숫자만 입력해주세요" /></td>
	    		</tr>
	    		<tr>
	    			<th><span>*</span> 재고수량 </th>
	    			<td><input type="text" name="pCount" placeholder="숫자만 입력해주세요" /></td>
	    		</tr>
	    	</table>
	    </div>
    	
    	<div>
    		<table id="img_table">
    			<tr>
    				<th><span>*</span> 대표 사진 </th>
    				<td class="img">
    					<div id="thumbnailArea" class="pictureArea">
							<img id="thumbnail" class="imgs"/>
						</div>
    				</td>
					<th><span>*</span> 내용 사진</th>
					<td class="img">
						<div id="contentImgArea1" class="pictureArea">
							<img id="contentImg1" class="imgs"/>
						</div>
					</td>
					<td class="img">
						<div id="contentImgArea2" class="pictureArea">
							<img id="contentImg2" class="imgs"/>
						</div>
					</td>
					<th><span>*</span> 설명 사진 </th>
					<td class="img">
						<div id="detailImgArea" class="pictureArea">
							<img id="detailImg" class="imgs"/>
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
    						<textarea name="pComment" rows="15" cols="93" placeholder="특수문자를 제외하고 입력해주세요"></textarea>
						</div>
    				</td>
    			</tr>
    		</table>
    	</div>
    		
	    <div id="fileArea">	<!-- 파일 업로드 부분 -->
	   			<input type="file" id="thumbnailImg1" multiple="multiple" name="uploadFile" onchange="LoadImg(this,1)"/>
	   			<input type="file" id="thumbnailImg2" multiple="multiple" name="uploadFile" onchange="LoadImg(this,2)"/>
	   			<input type="file" id="thumbnailImg3" multiple="multiple" name="uploadFile" onchange="LoadImg(this,3)"/>
	   			<input type="file" id="thumbnailImg4" multiple="multiple" name="uploadFile" onchange="LoadImg(this,4)"/>
   		</div>
		<div id="buttonArea">
	   		<input type="button" id="cancel" class="btn" value="취 소" onclick="location.href='plist.po'"/>
	   		<input type="submit" id="okay" class="btn" value="등 록"/>
	   	</div>	
	</form>
    </section>
	<%@ include file="../common/footer.jsp" %>
	
	    <script>
			$('select[name=categorySelect]').change(function(){
				if($(this).val() == "카테고리 선택"){
					$('#categoryChk').val("");
				} else {
					$('#categoryChk').val($(this).val());
				}
			});
	    
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
	       		
	       		
	       		function insertProduct(){
					var pName = $('input[name="pName"]').val();
					var pPrice = $('input[name="pPrice"]').val();
					var pCount = $('input[name="pCount"]').val();
					var pComment = $('textarea[name="pComment"]').val();
					var uploadFile = $('input[name="uploadFile"]');
					var pNameExp = /^[^ㄱ-ㅎ|.,!@#$%^&*]*$/;
					var pPriceExp = /^[^0-9]*$/;
					var pCountExp = /^[^0-9]*$/
					var pCommentExp = /^[^ㄱ-ㅎ|@#$%^&*]*$/;
					
				////////////////////////////////////정규화
	       			if($('#categorySelect option:selected').val() == '카테고리 선택' ){
	       				swal({
	       					text: '카테고리를 선택해주세요.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    				return false;
	       			}
	       			
	       			if(pName.length == 0 ){
	       				swal({
	       					text: '상품명이 비었습니다.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('input[name="pName"]').focus();
	    				return false;
	       			} else if(!pNameExp.test(pName)){
	       				swal({
	       					text: '특수문자를 제외한  올바른 상품명을 입력하세요.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('input[name="pName"]').focus();
	    				return false;
	       			}
	       			
	       			if(pPrice.length == 0 ){
	       				swal({
	       					text: '가격이 비었습니다.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('input[name="pPrice"]').focus();	
    					return false;
	       			} else if(pPriceExp.test(pPrice)){
	       				swal({
	       					text: '숫자만 입력해주세요.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('input[name="pPrice"]').focus();	
    					return false;
	       			}
	       			
	       			if(pCount.length == 0 ){
	       				swal({
	       					text: '재고수량이 비었습니다.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('input[name="pCount"]').focus();	
	    				return false;
	       			} else if(pCountExp.test(pCount)) {
	       				swal({
	       					text: '숫자만 입력해주세요.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('input[name="pCount"]').focus();	
	    				return false;
	       			}
	       			
	       			if(pComment.length == 0 ){
	       				swal({
	       					text: '상품설명이 비었습니다.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('textarea[name="pComment"]').focus();	
	    				return false;
	       			} else if(!pCommentExp.test(pComment)){
	       				swal({
	       					text: '상특수문자를 제외한 올바른 문장을 입력하세요.',
	       					icon: 'info',
	       					closeOnClickOutside: false,
		    				}).then((ok) => {
			    				if(ok){
			    					swal.close();						
			    				}
		    				})
		    			$('textarea[name="pComment"]').focus();	
	    				return false;
	       			}
	       			
	       			
	       			for(var i = 0; i < uploadFile.length; i++){
	       				console.log(uploadFile[i].value);
	       				if(uploadFile[i].value.length == 0){
		       				swal({
	           					text: '사진을 모두 선택해주세요.',
	           					icon: 'info',
	           					closeOnClickOutside: false,
	    	    				}).then((ok) => {
	    		    				if(ok){
	    		    					swal.close();						
	    		    				}
	    	    				})
    	    				return false;
	       				}
	       			}
	       			
	       			return true;
	       		};
	    </script>
	
</body>
</html>