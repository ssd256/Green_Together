<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린 - 무료나눔</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shares/sharesList.css" type="text/css">
</head>
<body>
	<c:import url="../common/header.jsp"/>
    <section>

        <div id="search_box">

			<select id="searchOption">
				<option value="title">제목</option>
				<option value="writer">작성자</option>
				<option value="content">내용</option>
			</select>

			<input id="search_text" type="text" placeholder="${ searchText }"/>
<%-- 			<c:url var="sSearch" value="sSearchList.sh"> --%>
<%-- 				<c:param name="searchOption" value="$('#searchOption').val()"/> --%>
<%-- 				<c:param name="page" value="${ pi.currentPage }"/> --%>
<%-- 			</c:url> --%>
			<input type="button" id="search_btn" class="btn" value="검 색">
        	<c:if test="${ !empty loginUser }">
        	<input id="insert_btn" class="btn" type="button" value="등 록" onClick="location.href='sInsertForm.sh'">	
<!--         		<a href="sInsertForm.sh" id="insert_btn" class="btn">등록</a> -->
        	</c:if>
		</div>
		
		<script>
			if("${ searchOption }" == ("title")){
				$("#searchOption").val("title").prop("selected", true);
			} else if("${ searchOption }" == ("writer")){
				$("#searchOption").val("writer").prop("selected", true);		
			} else if("${ searchOption }" == ("content")){
				$("#searchOption").val("content").prop("selected", true);
			}
		</script>

		
<%-- 		<c:url var="sSearch" value="sSearch.sh"> --%>
<%-- 			<c:param name="bNo" value="$("#searchOption").val()"/> --%>
<%-- 			<c:param name="page" value="${ pi.currentPage }"/> --%>
<%-- 		</c:url> --%>


        
        <hr id="line">
        
<!--         <div class="thumbnailArea"> -->
<%-- 			<% if(${bList.isEmpty() || fList.isEmpty()}){ %> --%>
<!-- 			등록된 사진이 없습니다. -->
<%-- 			<% } else{ %> --%>
<%-- 				<% for(int i = 0; i < bList.size(); i++){ %> --%>
<%-- 					<% Board b = bList.get(i); %> --%>
<!-- 					<div class="thumb-list" align="center"> -->
<!-- 						<div> -->
<%-- 							<input type="hidden" value="<%= b.getBoardId() %>"> --%>
<%-- 							<% for(int j = 0; j < fList.size(); j++){ %> --%>
<%-- 								<% Attachment a = fList.get(j); %> --%>
<%-- 								<% if(b.getBoardId() == a.getBoardId()){ %> --%>
<%-- 									<img src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= a.getChangeName() %>" width="200px" height="150px"> --%>
<%-- 								<% } %> --%>
<%-- 							<% } %> --%>
<!-- 						</div> -->
<!-- 						<p> -->
<%-- 							No. <%= b.getBoardId() %> <%= b.getBoardTitle() %><br> --%>
<%-- 							조회수 : <%= b.getBoardCount() %> --%>
<!-- 						</p> -->
<!-- 					</div> -->
<%-- 				<% } %> --%>
<%-- 			<% } %> --%>
<!-- 		</div> -->

<%--         <c:if test="${ sList.isEmpty() || fList.isEmpty()}"> --%>
<!--         	등록된 물품이 없습니다. -->
<%--         </c:if> --%>
<%--         <c:forEach var="i" begin="0" end=${ sList.size() }> --%>
<!-- 	 		<div id="product_area" align="center"> -->
<%-- 		        <c:forEach var="i" begin="0" end=${ fList.size() }> --%>
<!-- 			    	<div class="products"> -->
<%-- 			    		<c:if test="${ sList.get(i).getbNo() eq fList.get(i).getbNo() }"> --%>
<%-- 		    			<img class="productImg" src="resources/shares_uploadFiles/${ fList.get(i).getfChangeName() }"/> --%>
<!-- 		    			<p class="product_info"><br> -->
<%-- 							<label id="info2">[${ sList.get(i).getsStock() }] [${ sList.get(i).getsAddress() }]<br><br></label> --%>
<%-- 							제품명 : ${ sList.get(i).getbTitle() }<br> --%>
<%-- 							닉네임 : ${ sList.get(i).getmId() }<br>	    			 --%>
<!-- 		    			</p> -->
<%-- 		    			</c:if> --%>
<!-- 			    	</div>      -->
<%-- 		    	</c:forEach>   --%>
<!-- 	        </div> -->
<%--         </c:forEach> --%>
        
        
        <c:if test="${ sList.isEmpty() || fList.isEmpty()}">
        	등록된 물품이 없습니다.
        </c:if>
       <c:if test="${ !(empty sList) && !(empty fList) }">
        <c:forEach var="s" items="${ sList }">
			<div id="product_area">
				<c:url var="sdetail" value="sdetail.sh">
					<c:param name="bNo" value="${ s.bNo }"/>
					<c:param name="page" value="${ pi.currentPage }"/>
				</c:url>
<%-- 				<a href="${ sdetail }">${ s.bTitle }</a> --%>
				
				
<%-- 		    	<c:forEach var="f" items="${ fList }"> --%>

				<!-- 파일 수정한 부분 : 미경 -->
				<c:if test="${ empty loginUser }">
				<c:forEach var="f" items="${ fList }">
				<c:if test="${ s.bNo == f.bNo }">
		    	<div class="products" onclick="alistLogin();">
		    		<img class="productImg" src="resources/shares_uploadFiles/${ f.fChangeName }"/>
		    		<p class="product_info"><br>
						<label id="info2">[남은 수량 : ${ s.sStock }개] <br> [${ s.sAddress }]<br><br></label>
						제품명 : ${ s.bTitle }
<%-- 						제품명 : <a href="${ sdetail }">${ s.bTitle }</a> --%>
						<br>
						작성자 : ${ s.mId }<br>	    			
		    		</p>
		    	</div>
		    	</c:if>
		    	</c:forEach>
		    	</c:if>

		    	<script>
                    function alistLogin(){
                		alert('로그인을 해야 물품 나눔 게시글 조회가 가능합니다.');
                	}
                </script>
				
				<!-- 파일 수정한 부분 : 미경 -->
				<c:if test="${ !empty loginUser }">
				<c:forEach var="f" items="${ fList }">
				<c:if test="${ s.bNo == f.bNo }">
		    	<div class="products" onclick="location.href='${ sdetail }'">
		    		<img class="productImg" src="resources/shares_uploadFiles/${ f.fChangeName }"/>
		    		<p class="product_info"><br>
						<label id="info2">[남은 수량 : ${ s.sStock }개] <br> [${ s.sAddress }]<br><br></label>
						제품명 : ${ s.bTitle }
<%-- 						제품명 : <a href="${ sdetail }">${ s.bTitle }</a> --%>
						<br>
						작성자 : ${ s.mId }<br>	    			
		    		</p>
		    	</div>
		    	</c:if>
		    	</c:forEach>
		    	</c:if>
<%-- 		    	</c:forEach> --%>
	    	</div>
    	</c:forEach>
	    </c:if>
	    
	    <script>
	    
	    </script>
	    	
	    	
	    	
	  
<!-- 	    	<div class="products"> -->
<!-- 	    		<img class="productImg" src="resources/images/운동화.jpg"/> -->
<!-- 	    		<p class="product_info"><br> -->
<!-- 					<label id="info2">[상품상태] [지역]<br><br></label> -->
<!-- 					제품명 : <br> -->
<!-- 					닉네임 : <br>	    			 -->
<!-- 	    		</p> -->
<!-- 	    	</div> -->

	    
	    <br clear="all">
	    
	    <!-- 이전 -->
	    <div class="pagination">
	    	<c:if test="${ pi.currentPage <= 1 }">
	    		<a class="prev_btn"> < </a>
	    	</c:if>
            <c:if test="${ pi.currentPage > 1 }">
    			<c:url var="before" value="slist.sh">        
    				<c:param name="page" value="${ pi.currentPage - 1 }" />
 	          	</c:url>
          		<a href="${ before }" class="prev_btn"> < </a>
            </c:if>
	    	
    		<!-- 페이지 -->
    		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
    			<c:if test="${ p eq pi.currentPage }">
    				<b><a class="page no">${ p }</a></b>
    			</c:if>
    			
    			<c:if test="${ p ne pi.currentPage }">
    				<c:url var="pagination" value="slist.sh">
    					<c:param name="page" value="${ p }"/>
					</c:url>	
					<a href="${ pagination }" class="page no">${ p }</a>
				</c:if>
    		</c:forEach>		
    		
    		<!-- 다음 -->
    		<c:if test="${ pi.currentPage >= pi.maxPage }">
    			<a class="next_btn"> > </a>
    		</c:if>
    		<c:if test="${ pi.currentPage < pi.maxPage }">
    			<c:url var="after" value="slist.sh">
    				<c:param name="page" value="${ pi.currentPage + 1 }"/>
    			</c:url>
    			<a href="${ after }" class="next_btn"> > </a>
    		</c:if>
		</div>
	    
<!-- 	    <div class="paging"> -->
			
<!-- 				[이전] -->
<%-- 				<c:if test="${ pi.currentPage <= 1 }"> --%>
<%-- 					<a href="${ before }">이전</a> &nbsp; --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${ pi.currentPage > 1 }"> --%>
<%-- 					<c:url var="before" value="slist.sh"> --%>
<%-- 						<c:param name="page" value="${ pi.currentPage - 1 }"/> --%>
<%-- 					</c:url> --%>
<%-- 					<a href="${ before }">이전</a> &nbsp; --%>
<%-- 				</c:if> --%>
				
<!-- 				페이지 -->
<%-- 				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }"> --%>
<%-- 					<c:if test="${ p eq pi.currentPage }"> --%>
<%-- 						<font color="red" size="4"><b>${ p }</b></font> --%>
<%-- 					</c:if> --%>
					
<%-- 					<c:if test="${ p ne pi.currentPage }"> --%>
<%-- 						<c:url var="pagination" value="slist.sh"> --%>
<%-- 							<c:param name="page" value="${ p }"/> --%>
<%-- 						</c:url> --%>
<%-- 						<a href="${ pagination }">${ p }</a> &nbsp; --%>
<%-- 					</c:if> --%>
<%-- 				</c:forEach> --%>
				
<!-- 				[다음] -->
<%-- 				<c:if test="${ pi.currentPage >= pi.maxPage }"> --%>
<%-- 					<a href="${ after }">다음</a> &nbsp; --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${ pi.currentPage < pi.maxPage }"> --%>
<%-- 					<c:url var="after" value="slist.sh"> --%>
<%-- 						<c:param name="page" value="${ pi.currentPage + 1 }"/> --%>
<%-- 					</c:url>  --%>
<%-- 					<a href="${ after }">다음</a> --%>
<%-- 				</c:if> --%>
<!-- 		</div> -->
		
			    <br clear="all">
		
    </section>
    <script>
// 		$(function(){
// 			$('#product_area').mouseenter(function(){
// 				$(this).css({'color':'yellowgreen', 'font-weight':'bold', 'cursor':'pointer'});
// 			}).mouseout(function(){
// 				$(this).css({'color':'black', 'font-weight':'normal'});
// 			}).click(function(){
// 				var bNo = $(this).eq(0).text();
// 				location.href = "sdetail.sh?bNo=" + bNo + "&page=" + ${pi.currentPage}; //${ sdetail }
// 			});
// 		});
		
		$(function(){
			$('#search_btn').click(function(){
				var searchOption = $('#searchOption').val();
				var searchText = $('#search_text').val();
				location.href = "sSearch.sh?searchOption=" + searchOption + "&searchText=" + searchText;
			});
		});
	</script>
    
    <img id="top" src="resources/images/top_button2.png"/>
    
    <%@ include file="../common/footer.jsp"%>

</body>
</html>
