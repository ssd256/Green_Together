<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께 그린</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/adminpage_mainImage.css" type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<%@ include file="../common/admin-aside.jsp"%>
		<section>
			<div id="adminpageTitle">
	            <h3>메인 이미지 관리</h3>
	        </div>
	        <!-- 이미지 수정 -->
			<form method="post" enctype="multipart/form-data" id="mainImageUpdate1" onsubmit="return checkUpdate(1);">
				<input type="hidden" name="mId" value="${ loginUser.userId }">
				<c:if test="${!empty  board1.bNo }">
					<input type="hidden" name="bNo" value="${ board1.bNo }">
					<input type="hidden" name="fChangeName" value="${ files1.fChangeName }">
				</c:if>
				<input type="hidden" name="bCategory" value="메인이미지1">
				<input type="file" class="fileArea" id="imgFile1" name="uploadFile" onchange="LoadImg(this,1)">
				<table border="0">
					<tr>
	               		<th colspan="2"><input type="text" class="textbox" name="bTitle" value="첫 번째 이미지"></th>
	               	</tr>
	               	<tr>
                  		<td colspan="2">
							<div class="previewDiv">
							<c:if test="${!empty files1.fChangeName}">
								<img class="detailImg" id="detailImg1" src="${ contextPath }/resources/buploadFiles/${ files1.fChangeName }">				
								<img class = "preImg" id="mainImg1" src="${ contextPath }/resources/buploadFiles/${ files1.fChangeName }">
							</c:if>
							<c:if test="${empty files1.fChangeName}">	
								<img class="detailImg" id="detailImg1" src="${pageContext.request.contextPath}/resources/images/emptyImages.png">				
								<img class = "preImg" id="mainImg1" src="${pageContext.request.contextPath}/resources/images/click_here.png">
							</c:if>
							</div>
	                  	</td>
					</tr>
					<tr>
	               		<th class="linckTable">
	               			링크 주소
	               		</th>
	               		<td class="linckTable">
	               			<input type="text" class="URLtext" id="imgURL1" name="bContent" value="${ board1.bContent }"/>
	               			<input type="button" class="btn_cancle" id="cancleBtn1" value="취소" onclick="cancle()">
			                <input type="button" class="btn_update" id="submitBtn1" value="수정" onclick="return 	checkUpdate(1)" >
			                <input type="checkbox" id="checkBtn1" hidden="hide">
	               		</td>
					</tr>
				</table>
			</form>
			<form method="post" enctype="multipart/form-data" id="mainImageUpdate2" onsubmit="return checkUpdate(2);">	
				<input type="hidden" name="mId" value="${ loginUser.userId }">
				<c:if test="${!empty  board2.bNo }">
					<input type="hidden" name="bNo" value="${ board2.bNo }">
					<input type="hidden" name="fChangeName" value="${ files2.fChangeName }">
				</c:if>
				<input type="hidden" name="bCategory" value="메인이미지2">
				<input type="file" class="fileArea" id="imgFile2" name="uploadFile" onchange="LoadImg(this,2)">
				<table border="0">
					<tr>
	               		<th colspan="2"><input type="text" class="textbox" name="bTitle" value="두 번째 이미지"></th>
	               	</tr>
	               	<tr>
                  		<td colspan="2">
							<div class="previewDiv">
							<c:if test="${!empty files2.fChangeName}">
								<img class="detailImg" id="detailImg2" src="${ contextPath }/resources/buploadFiles/${ files2.fChangeName }">				
								<img class = "preImg" id="mainImg2" src="${ contextPath }/resources/buploadFiles/${ files2.fChangeName }">
							</c:if>
							<c:if test="${empty files2.fChangeName}">	
								<img class="detailImg" id="detailImg2" src="${pageContext.request.contextPath}/resources/images/emptyImages.png">				
								<img class = "preImg" id="mainImg2" src="${pageContext.request.contextPath}/resources/images/click_here.png">
							</c:if>
							</div>
	                  	</td>
					</tr>
					<tr>
	               		<th class="linckTable">
	               			링크 주소
	               		</th>
	               		<td class="linckTable">
	               			<input type="text" class="URLtext" id="imgURL2" name="bContent" value="${ board2.bContent }"/>
	               			<input type="button" class="btn_cancle" id="cancleBtn2" value="취소" onclick="cancle()">
			                <input type="button" class="btn_update" id="submitBtn2" value="수정" onclick="return 	checkUpdate(2)" >
			                <input type="checkbox" id="checkBtn2" hidden="hide">
	               		</td>
					</tr>
				</table>
			</form>
			<form method="post" enctype="multipart/form-data" id="mainImageUpdate3" onsubmit="return checkUpdate(3);">
				<input type="hidden" name="mId" value="${ loginUser.userId }">
				<c:if test="${!empty  board3.bNo }">
					<input type="hidden" name="bNo" value="${ board3.bNo }">
					<input type="hidden" name="fChangeName" value="${ files3.fChangeName }">
				</c:if>
				<input type="hidden" name="bCategory" value="메인이미지3">
				<input type="file" class="fileArea" id="imgFile3" name="uploadFile" onchange="LoadImg(this,3)">
				<table border="0">
					<tr>
	               		<th colspan="2"><input type="text" class="textbox" name="bTitle" value="세 번째 이미지"></th>
	               	</tr>
	               	<tr>
                  		<td colspan="2">
							<div class="previewDiv">
							<c:if test="${!empty files3.fChangeName}">
								<img class="detailImg" id="detailImg3" src="${ contextPath }/resources/buploadFiles/${ files3.fChangeName }">				
								<img class = "preImg" id="mainImg3" src="${ contextPath }/resources/buploadFiles/${ files3.fChangeName }">
							</c:if>
							<c:if test="${empty files3.fChangeName}">	
								<img class="detailImg" id="detailImg3" src="${pageContext.request.contextPath}/resources/images/emptyImages.png">				
								<img class = "preImg" id="mainImg3" src="${pageContext.request.contextPath}/resources/images/click_here.png">
							</c:if>
							</div>
	                  	</td>
					</tr>
					<tr>
	               		<th class="linckTable">
	               			링크 주소
	               		</th>
	               		<td class="linckTable">
	               			<input type="text" class="URLtext" id="imgURL3" name="bContent" value="${ board3.bContent }"/>
	               			<input type="button" class="btn_cancle" id="cancleBtn3" value="취소" onclick="cancle()">
			                <input type="button" class="btn_update" id="submitBtn3" value="수정" onclick="return 	checkUpdate(3)" >
			                <input type="checkbox" id="checkBtn3" hidden="hide">
	               		</td>
					</tr>
				</table>
			</form>
			<form method="post" enctype="multipart/form-data" id="mainImageUpdate4" onsubmit="return checkUpdate(4);">
				<input type="hidden" name="mId" value="${ loginUser.userId }">
				<c:if test="${!empty  board4.bNo }">
					<input type="hidden" name="bNo" value="${ board4.bNo }">
					<input type="hidden" name="fChangeName" value="${ files4.fChangeName }">
				</c:if>
				<input type="hidden" name="bCategory" value="메인이미지4">
				<input type="file" class="fileArea" id="imgFile4" name="uploadFile" onchange="LoadImg(this,4)">
				<table border="0">
					<tr>
	               		<th colspan="2"><input type="text" class="textbox" name="bTitle" value="네 번째 이미지"></th>
	               	</tr>
	               	<tr>
                  		<td colspan="2">
							<div class="previewDiv">
							<c:if test="${!empty files4.fChangeName}">
								<img class="detailImg" id="detailImg4" src="${ contextPath }/resources/buploadFiles/${ files4.fChangeName }">				
								<img class = "preImg" id="mainImg4" src="${ contextPath }/resources/buploadFiles/${ files4.fChangeName }">
							</c:if>
							<c:if test="${empty files4.fChangeName}">	
								<img class="detailImg" id="detailImg4" src="${pageContext.request.contextPath}/resources/images/emptyImages.png">				
								<img class = "preImg" id="mainImg4" src="${pageContext.request.contextPath}/resources/images/click_here.png">
							</c:if>
							</div>
	                  	</td>
					</tr>
					<tr>
	               		<th class="linckTable">
	               			링크 주소
	               		</th>
	               		<td class="linckTable">
	               			<input type="text" class="URLtext" id="imgURL4" name="bContent" value="${ board4.bContent }"/>
	               			<input type="button" class="btn_cancle" id="cancleBtn4" value="취소" onclick="cancle()">
			                <input type="button" class="btn_update" id="submitBtn4" value="수정" onclick="return 	checkUpdate(4)" >
			                <input type="checkbox" id="checkBtn4" hidden="hide">
	               		</td>
					</tr>
				</table>
	        </form>
      </section>
   	</main>
    <%@ include file="../common/footer.jsp"%>
    <script>
    	$(function(){
        	$(".fileArea").hide();
        	$(".preImg").hide();
        	$(".btn_cancle").hide();
         	$('.URLtext').attr("disabled",true); 
         	
         	var list = '<c:out value="${listCount}"/>';
         	
         	$("#mainImg1").click(function(){
            	$("#imgFile1").click();
         	});
         	$("#mainImg2").click(function(){
            	$("#imgFile2").click();
         	});
         	$("#mainImg3").click(function(){
            	$("#imgFile3").click();
         	});
         	$("#mainImg4").click(function(){
            	$("#imgFile4").click();
         	});
      	});
     
     	// 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
     	function LoadImg(value, num){
        	if(value.files && value.files[0]){
           	var reader = new FileReader();
	        reader.onload = function(e){                       
            	switch(num){
              		case 1: 
                 		$("#mainImg1").attr("src", e.target.result);
                 		break;
              		case 2:
                 		$("#mainImg2").attr("src", e.target.result);
                 		break;
              		case 3: 
                 		$("#mainImg3").attr("src", e.target.result);
                 		break;
              		case 4:
                 		$("#mainImg4").attr("src", e.target.result);
                 		break;
              	}
           }
           reader.readAsDataURL(value.files[0]);
        }
     }
     	
	//정보 수정 버튼 눌렀을때
	    function checkUpdate(i){
			let checkId="#checkBtn"+i;
			let cancleBtn="#cancleBtn"+i;
			let imgURL="#imgURL"+i;
			let detailImg="#detailImg"+i;
			let mainImg="#mainImg"+i;
			let mainImageUpdate = "#mainImageUpdate"+i
			
			var form = jQuery(mainImageUpdate)[0];
		    var formData = new FormData(form);

// 			console.log(checkId);
	    	$(checkId).click();
	    	//submit
	    	if($(checkId).is(":checked") != true){
		    	$.ajax({
		    		type : "POST",
		    		url : "mainImageUpdate.bo",
		    		data : formData,
		    		processData: false,
		    		contentType: false,
		    		dataType : 'json',
		    		success : function(data) {
		    			$(mainImg).hide();
		    			$(cancleBtn).hide();
	 	            	$(detailImg).show();
	 	            	$(detailImg).attr("src", "${ contextPath }/resources/buploadFiles/"+data.mainImg);
	 	             	$(imgURL).val(data.imgURL); 
	 	             	$(imgURL).attr("disabled",true); 
		    		},
		    		error : function(data) {
		    			swal({
							text: "파일과 함께 링크를 등록해주세요",
						}).then((ok) => {
							if(ok){
		    					location.reload();
							}
						})
	    			}
	    		});
	    	}else{
	    		if(i>1){
	    			let imgURL="#imgURL"+(--i);
// 	    			console.log($(imgURL).val());
	    			if($(imgURL).val() == ""){
// 	    				alert((i)+"번째 이미지 부터 설정해주세요");
					swal({
						text: (i)+"번째 이미지 부터 설정해주세요",
					}).then((ok) => {
						if(ok){
	    					location.reload();
						}
					})
	    			}
	    		}
	    		
	    		$(detailImg).hide();
	    		$(mainImg).show();
            	$(mainImg).attr("src", "${pageContext.request.contextPath}/resources/images/click_here.png");
	    		$(cancleBtn).show()
	    		$(imgURL).removeAttr("disabled");
	    		return false;
	    	}
	    		return true;
	    }
	    //취소했을때 새로고침
	  	function cancle(){
	  		location.reload();
	  	}
	    
// 	    function updateImage(imgURL,detailImg,mainImg){
// 	    	$.ajax({
// 	    		type : "POST",
// 	    		url : "updateImage.bo",
// 	    		data : {
// 	    			uploadFile:uploadFile
// 	    		},
// 	    		processData: false,
// 	    		contentType: false,
// 	    		success : function(data) {	
// 	    			$(mainImg).hide();
// 	            	$(detailImg).show();
// 	            	$(detailImg).attr("src", imgurl);
// 	             	$('.URLtext').text(content); 
// 	             	$('.URLtext').attr("disabled",true); 
// 	    		},
// 	    		error : function(request, status, error) {
// 	    			alert("파일 업로드 관련 에러");
//     			}
//     		});
// 	    }
     </script>
</body>
</html>