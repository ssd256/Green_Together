<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께그린</title>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/product/productDetail.css"
	type="text/css">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<section>

		<c:set var="p" value="${ product }" scope="request" />
		<c:set var="flist" value="${ flist }" />
		<c:set var="flistN" value="${ fn:length(flist) }" scope="request" />

		<c:if test="${ !empty loginUser && loginUser.userId == 'admin'}">
			<input type="button" id="delete_btn" class="btn" value="삭 제"
				onclick="deleteProduct();">
			<input type="button" id="update_btn" class="btn" value="수 정"
				onclick="location.href='pupdateForm.po?bNo='+${ p.bNo }">
		</c:if>
		<input type="button" id="list_btn" class="btn" value="목 록"
			onclick="location.href='plist.po'">

		<p id="sectionTitle">상품 상세보기
		<p>
		<hr id="pdetail_hr">

		<form id="orderForm" action="orderForm.po">
			<input type="hidden" name="bNo" value="${ p.bNo }">
			<c:url var="pupdateForm" value="pupdateForm.po">
				<c:param name="bNo" value="${ p.bNo }" />
				<c:param name="page" value="${ page }" />
			</c:url>
			<div id="slideshow-container">
				<img id="thumbnail" class="mySlides fade" name="fName"
					src="resources/product_uploadFiles/${ flist[0].fChangeName }"
					alt="액박" />
				<c:forEach var="f" begin="1" end="${ flistN - 2}">
					<img class="mySlides fade" name="contentImg"
						src="resources/product_uploadFiles/${ flist[f].fChangeName }"
						alt="액박" />
				</c:forEach>

				<a class="prevs" onclick="plusSlides(-1)">❮</a> <a class="nexts"
					onclick="plusSlides(1)">❯</a> <input type="hidden" id="bNo"
					value="${p.bNo}"> <input type="hidden" id="pNo" name="pNo"
					value="${ p.pNo }"> <input type="hidden" id="fName"
					value="${ flist[0].fChangeName }"> <input type="hidden"
					id="pName" name="pName" value="${ p.pName }">
			</div>

			<div id="dots">
				<span class="dot" onclick="currentSlide(1)"></span> 
				<span class="dot" onclick="currentSlide(2)"></span> 
				<span class="dot" onclick="currentSlide(3)"></span>
			</div>

			<script>
        var slideIndex = 1;
		showSlides(slideIndex);
		
		function plusSlides(n){
			showSlides(slideIndex += n);
		}
		
		function currentSlide(n) {
			  showSlides(slideIndex = n);
		}
		
		function showSlides(n){
			var i;
			var slides = document.getElementsByClassName('mySlides fade');
			var dots = document.getElementsByClassName("dot");
			
			if(n > slides.length){
				slideIndex = 1;
			}
			
			if(n < 1){
				slideIndex = slides.length;
			}
			
			for(i = 0; i < slides.length; i++){
				slides[i].style.display = "none";
			}
			
			for (i = 0; i < dots.length; i++) {
			      dots[i].className = dots[i].className.replace(" active", "");
		  	}
			  slides[slideIndex-1].style.display = "block";  
			  dots[slideIndex-1].className += " active";
		}
        </script>


			<div id="info_area">
				<table id="infoTable">
					<tr>
						<th>${ p.pName }</th>
						<td></td>
					</tr>
					<tr>
						<td>수량&emsp; <c:if test="${ p.pCount == 0 }">
								<p id="count">품 절</p>
								&emsp;&emsp;&emsp;
							</c:if> <c:if test="${ p.pCount != 0 }">
								&emsp;
								<input type="number" id="pCount" name="orderCount" min="1"
									max="${ p.pCount }" value="1">
								&emsp;&emsp;&emsp;
							</c:if> <input type="hidden" id="count" value="${ p.pCount }">
							친환경인증마크&emsp;<img
							src="${ pageContext.request.contextPath }/resources/images/greenMark.jpg"
							id="green_mark2">
						</td>
					</tr>
					<tr>
						<td>가격 : <input type="text" id="price" class="text_box"
							value="<fmt:formatNumber value="${ p.pPrice }" pattern="###,###,###"/>">&emsp;&emsp;&emsp;&emsp;&emsp;
							<input type="hidden" id="pPrice" name="orderPay"
							value="${ p.pPrice }"> 배송비 : <input type="text"
							id="delivery" class="text_box" value="2,500원" />
						</td>
						<td>
							<p>총 금액 :</p> <input type="text" id="total" class="text_box"
							value="<fmt:formatNumber value="${ p.pPrice + 2500}" pattern="###,###,###"/>">
						</td>
					</tr>
				</table>
			</div>

			<c:if test="${ empty sessionScope.loginUser }">
				<input type="button" id="order" class="p_btn" value="바로구매"
					onclick="loginView();">
				<input type="button" id="cart" class="p_btn" value="장바구니"
					onclick="loginView();">
				<input type="button" id="wish" class="p_btn" value="찜하기"
					onclick="loginView();">
			</c:if>

			<c:if test="${ !empty sessionScope.loginUser }">
				<input type="hidden" id="userId"
					value="${ sessionScope.loginUser.userId }">
				<c:if test="${ p.pCount != 0 }">
					<input type="submit" id="order" class="p_btn" value="바로구매">
				</c:if>
				<c:if test="${ p.pCount == 0 }">
					<input type="button" id="order" class="p_btn" value="바로구매"
						onclick="soldOut_p();">
				</c:if>
				<c:if test="${ p.pCount != 0 }">
					<input type="button" id="cart" class="p_btn" value="장바구니"
						onclick="cartInput();">
				</c:if>
				<c:if test="${ p.pCount == 0 }">
					<input type="button" id="cart" class="p_btn" value="장바구니"
						onclick="soldOut_c();">
				</c:if>
				<c:if test="${ p.pCount != 0 }">
					<input type="button" id="wish" class="p_btn" value="찜하기"
						onclick="wishInput();">
				</c:if>
				<c:if test="${ p.pCount == 0 }">
					<input type="button" id="wish" class="p_btn" value="찜하기"
						onclick="soldOut_w();">
				</c:if>
			</c:if>
		</form>
		<script>
	   var bNo = $('#bNo').val();
		var pNo = $('#pNo').val();
		var fName = $('#fName').val();
		var pName = $('#pName').val();
		var pPrice = $('#pPrice').val();
		var userId = $('#userId').val();
		
		
		function soldOut_p(){
			swal({
				text: '해당상품은 품절로 구매하실 수 없습니다',
				icon: 'info',
			}).then((ok) => {
				swal.close();
			})
		};
		
		
		function soldOut_c(){
			swal({
				text: '해당상품은 품절로 장바구니에 추가하실 수 없습니다',
				icon: 'info',
			}).then((ok) => {
				swal.close();
			})
		};
		
		
		function soldOut_w(){
			swal({
				text: '해당상품은 품절로 찜하기에 추가하실 수 없습니다',
				icon: 'info',
			}).then((ok) => {
				swal.close();
			})
		}
		
		
		function deleteProduct(){
			swal({
				text: '해당 상품을 삭제하시겠습니까?', 
				icon : 'warning',
				buttons: ["아니오", "예"],
				dangerMode: true,
				closeOnClickOutside: false,
				}).then((ok) => {
				if(ok){
					location.href='${pageContext.request.contextPath}/pdelete.po?bNo=' + bNo;							
				}
			});
		}

		
		function loginView(){
			swal({
				title: '로그인 필요', 
				text: '로그인 후 이용해주시기 바랍니다.', 
				icon: 'info',
				closeOnClickOutside: false
				}).then((ok) => {
				if(ok){
					location.href='loginView.me';
				}
			})
		};
		
		
		/* 장바구니에담기 */
		function cartInput(){
			var orderCount = Number($('input[name=orderCount]').val());
			var count = Number($('#count').val());
			if(orderCount > count){
				swal('', '재고보다 작은 수를 입력하세요.', '');
			} else{
				$.ajax({
					url: 'cartInsert.po',
					data: {	'bNo' : bNo, 
							'pNo' : pNo,
							'cCount' : $('input[name=orderCount]').val(),	
							'cPrice' : pPrice,
							'fName' : fName,
							'pName' : pName	
						  },
					success: function(data){
							swal({
							text: '장바구니로 이동하시겠습니까?',
							icon: 'info',
							buttons: ["쇼핑 계속하기", "장바구니로 이동"],
							closeOnClickOutside: false
							}).then((ok) => {
								if(ok){
									location.href='cartList.po';
								} else {
									swal.close();
								}
							});
					},
					error: function(data){
						swal({
							text: '더 이상 장바구니에 담을 수 없습니다.',
							icon: 'error',
							closeOnClickOutside: false,
						})
					}
				});
			}
		};
		
		
		/* 찜하기 */
		function wishInput(){
			$.ajax({
				url: 'wishInsert.po',
				data: { 'bNo' : bNo, 
						'pNo' : pNo,
						'cCount' : $('input[name=orderCount]').val(),	
						'cPrice' : pPrice,
						'fName' : fName,
						'pName' : pName	
					  },
				success: function(data){
						swal({
							text: '찜하기 목록으로 이동하시겠습니까?',
							icon: 'info',
							buttons: ["쇼핑 계속하기", "찜하기로 이동"],
							closeOnClickOutside: false
						}).then((ok) => {
							if(ok){
								location.href='wishList.po';
							} else {
								swal.close();
							}
						})
				},
				error: function(data){
					swal({
						text: '더 이상 찜하기에 담을 수 없습니다.',
						icon: 'error',
						closeOnClickOutside: false,
					})
				}
			});
		};
		
		/* 구매하기 */
		function orderInput(){
			$.ajax({
				url: 'orderForm.po',
				data: { 'bNo' : bNo, 
						'pNo' : pNo,
						'cCount' : $('input[name=orderCount]').val(),	
						'cPrice' : pPrice,
						'fName' : fName,
						'pName' : pName	
					  },
				success: function(data){
					console.log('상품 값 넘기기 성공');
				},
				error: function(data){
					console.log('값 넘기기 실패');
				}
			});
		};
	</script>

		<hr>

		<div>
			<div id="more_info">
				<textarea id="comment" cols="150" rows="10" disabled="disabled">${ p.pComment }</textarea>
			</div>
			<img id="info_img"
				src="resources/product_uploadFiles/${ flist[3].fChangeName }"
				alt="액박" />
		</div>

		<div id="caution_area">
			<p>
				<img id="arrow"
					src="${ pageContext.request.contextPath }/resources/images/배송화살표.PNG" />배송
				및 반품 안내
			</p>
			<br>
			<pre>- 배송지역 : 서울 및 수도권 지역만 가능 (이외 지역은 문의사항 게시판을 통해 문의해주세요)</pre>
			<pre>- 배송기간 : 결제 완료일 이후로부터 약 일주일 이내</pre>
			<pre>- 반품안내 : 교환 및 반품 시에는 고객센터(1588-9191)로 문의하신 후 보내주시기 바라며, 개봉한 상품의 경우 교환 및 반품이 불가합니다.</pre>
			<pre>	   단순변심의 경우 택배비는 고객님이 부담합니다.</pre>
			<pre>- 반송주소 : 서울시 강남구 역삼동 188 상일빌딩 4층 서울 강남구 역삼동 188 상일빌딩 4층</pre>
		</div>

		<hr>

		<div>
			<p id="reivew_p">상품후기</p>
			<hr id="Rhr">
			<c:if test="${ rlist.isEmpty() }">
        		등록된 후기가 없습니다.
        	</c:if>

			<c:if test="${ !(empty rlist) }">
				<c:forEach var="r" items="${ rlist }" varStatus="rstatus">
					<table class="review_table">
						<tr>
							<th>
								<div>
									<c:if test="${ flistR.isEmpty() }"/>
									<c:if test="${ !(empty flistR) }">
										<c:forEach var="fR" items="${ flistR }" varStatus="fstatus">
											<c:if test="${ r.bNo == fR.bNo }">
												<img src="resources/product_uploadFiles/${ fR.fChangeName }" />
											</c:if>
										</c:forEach>
									</c:if>
								</div>
							</th>
							<td>${ r.rContent }</td>
							<td>&emsp;별점 <c:choose>
									<c:when test="${ r.rStar eq 1}">
										<p class="star1_${ s.count }">★☆☆☆☆</p>
									</c:when>
									<c:when test="${ r.rStar eq 2}">
										<p class="star2_${ s.count }">★★☆☆☆</p>
									</c:when>
									<c:when test="${ r.rStar eq 3}">
										<p class="star3_${ s.count }">★★★☆☆</p>
									</c:when>
									<c:when test="${ r.rStar eq 4}">
										<p class="star4_${ s.count }">★★★★☆</p>
									</c:when>
									<c:otherwise>
										<p class="star5_${ s.count }">★★★★★</p>
									</c:otherwise>
								</c:choose>
							</td>
							<td>닉네임 : ${ r.nickName }<br> 등록일 : ${ r.rDate }
							</td>
							<td>
							<c:if test="${ !(empty flistR) }">
								<c:if test="${ sessionScope.loginUser ne null}">
									<c:if test="${ sessionScope.loginUser.userId eq r.mId}">
										<input type="button" class="reviewFileDel" value="후기삭제" onclick="reviewDel(${ r.bNo }, ${ r.rNo });">
									</c:if>
								</c:if>
							</c:if>
							<c:if test="${ flistR == null }">
								<c:if test="${ sessionScope.loginUser ne null}">		
									<c:if test="${ sessionScope.loginUser.userId eq r.mId}">
										<input type="button" class="reviewDel" value="후기삭제" onclick="reviewDel_file_empty(${ r.bNo }, ${ r.rNo });">
									</c:if>
								</c:if>
							</c:if>
							</td>
						</tr>
					</table>
				</c:forEach>
			</c:if>
		</div>
	</section>
	<script>
		$(function(){
			/* 배송 및 반품 안내 */
			$('#caution_area pre:eq(3)').css('font-weight', 'bold');
			
			/* 후기 - 제목, 닉네임, 등록일 */
			$('#review_table pre:eq(0)').css('font-weight', 'bold');
			$('#review_table pre:eq(2)').css('font-weight', 'bold');
			$('#review_table td:eq(2)').css('font-weight', 'bold');
			$('#review_table td:eq(5)').css('font-weight', 'bold');
			
		});
		
		
			function reviewDel(bNo, rNo){
				swal({
					text: '해당 후기를 삭제하시겠습니까?',
					icon : 'warning',
					buttons: ["아니오", "예"],
					dangerMode: true,
					closeOnClickOutside: false,
					}).then((ok) => {
					if(ok){
						location.href='reviewFileDel.po?bNo=' + bNo + '&rNo=' + rNo;							
					}
				});
			};
			
			
			function reviewDel_file_empty(bNo, rNo){
				swal({
					text: '해당 후기를 삭제하시겠습니까?',
					icon : 'warning',
					buttons: ["아니오", "예"],
					dangerMode: true,
					closeOnClickOutside: false,
					}).then((ok) => {
					if(ok){
						location.href='reviewDel.po?bNo=' + bNo + '&rNo=' + rNo;							
					}
				});
			};
	</script>

	<%@ include file="../common/footer.jsp"%>
</body>
</html>