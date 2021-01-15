## :herb: 함께그린 : 친환경 쇼핑몰 및 환경 커뮤니티 지원 웹사이트  
  
  팀장 : 김중현    
  팀원 : 김미경, 명다정, 이영실, 한지원   
<br>      
  
### :dart: 개발환경
- Server : Apache Tomcat 9.0
- Database : Oracle 11g
- Development Tool : Eclipse 4.15.0, sqlDeveloper version 19.2.1.247, Apache Maven
- Development Language : JAVA , HTML5, CSS3, JavaScript, jQuery, SQL, JSP
- Web Framework: spring, Mybatis
- Team Coop : Github, ERDCloud, kakaoOven
- API: Swal, kakao map, kakao login, SMTP, I'mport
<br>

### :bulb: 개발배경      
환경오염 이슈로 인해 공공기관과 기업에서 친환경제품의 사용이 증가하고 있으며 일반 소비자들 또한 환경보호와 친환경제품에 관심이 높다는 점을 주목하였습니다. 사용자들이 보다 편리하게 환경보호를 실천할 수 있도록 친환경 물품 쇼핑몰과 환경보호 커뮤니티를 제공하는 웹사이트인 "함께그린"을 개발하였습니다.   
<br>              
       
### :date: 일정      
  - 9/21 ~ 9/24   기획회의(+ppt)   
  - 9/25 ~ 10/1   UI 설계회의(+ppt)     
  - 10/2 ~ 10/5   DB설계회의(+ppt)   
  - 10/5 ~ 11/1   UI 화면 구현   
  - 11/1 ~ 12/6   기능 구현 및 화면 수정   
  - 12/7 ~ 12/13   시퀀스 다이어그램 & ppt 수정   
  - 12/14 ~ 12/21   베타 테스트 및 통합 테스트      
<br>      
       
### :memo: 맡은 파트      
:closed_book: 김중현
- 로그인(일반 로그인, 카카오 로그인) / 로그아웃 / 로그인 상태 유지 
- 회원가입 / 아이디, 비밀번호 찾기 
- 마이페이지(회원정보 수정 / 비밀번호 변경 / 회원탈퇴) 
- 관리자(메인화면 사진 변경)      
 <br>  
   
:green_book: 김미경
- 친환경 쇼핑몰 조회 / 구매 / 결제 / 장바구니 / 찜하기
- 구매후기(조회 / 작성 / 삭제)
- 자주 묻는 질문 게시판 조회 / 등록 / 수정 / 삭제
 - 마이페이지(주문내역 확인 / 구매확정 / 구매취소)
 - 관리자(주문내역&배송관리 조회 / 수정)   
 <br>   
    
:blue_book: 명다정
- 봉사활동 게시판 조회 / 등록 / 수정 / 삭제 / 봉사신청, 취소
- 봉사활동 후기 게시판 조회 / 등록 / 수정 / 삭제
- 마이페이지(봉사활동 내역 조회, 취소 / 봉사후기 내역 조회)   
- 메인화면(봉사활동 게시판 최신 게시물 조회)
<br>   
    
:orange_book: 이영실
- 문의사항 게시판 조회 / 등록 / 수정 / 삭제
- 마이페이지(문의사항 작성내역 조회)
- 관리자(문의사항 답변 등록 / 수정 / 삭제) 
- 메인화면(친환경 쇼핑몰 최신 상품 조회)   
 <br>  
   
:ledger: 한지원
- 물품나눔 게시판 조회 / 등록 / 수정 /삭제 / 댓글 등록 / 수정 / 삭제 / 무료나눔 신청, 취소
- 마이페이지(물품신청 내역 조회 / 취소)
- 메인화면(물품나눔 게시판 최신 게시물 조회)   
<br>    


### :computer: 화면 일부
- 친환경 상품 상세 조회 일부   

![친환경 상품 상세 조회](https://github.com/ssd256/Green_Together/blob/main/images/view/ProdectDetail.PNG)   
 **1. 쇼핑몰 목록 화면에서 상품의 이미지를 누르면 상세 조회 화면으로 이동합니다.   
2. 수량을 선택하여 구매, 장바구니, 찜하기 기능을 사용할 수 있습니다.  
3. 재고수량이 0이면 '품절'표시로 바뀌며 구매, 장바구니, 찜하기 기능을 사용할 수 없습니다.**   
<br><br><br>

- 상품 등록   

![상품 등록](https://github.com/ssd256/Green_Together/blob/main/images/view/ProductInsert.PNG)   
**1. 모든 항목을 입력해야 등록이 가능하며, 한 항목이라도 비거나 선택하지 않으면 swal 알림창이 뜹니다.   
2. 상품가격과 재고수량은 숫자만 입력이 가능합니다.**
<br><br><br>

- 장바구니

![장바구니](https://github.com/ssd256/Green_Together/blob/main/images/view/CartList.PNG)   
**1. 추가된 상품을 한 개씩 삭제할 수 있습니다.   
2. 체크박스를 통해 여러 개 구매할 수 있습니다. 선택된 상품들의 결제 금액은 총 결제 금액 옆에 더해서 표시됩니다.     
3. 장바구니에는 최대 5개의 상품만 담을 수 있습니다.**   
<br><br><br>

- 찜하기   

![찜하기](https://github.com/ssd256/Green_Together/blob/main/images/view/WishList.PNG)   
**1. 추가된 상품을 한 개씩 장바구니에 추가할 수 있습니다.    
2. 추가된 상품을 한 개씩 삭제할 수 있습니다.   
3. 찜목록에는 최대 5개의 상품만 담을 수 있습니다.**
<br><br><br>

- 주문하기 배송지 변경   

![주문하기 배송지 변경2](https://github.com/ssd256/Green_Together/blob/main/images/view/ChangeDelivery.PNG)      
**1. 배송지는 기본적으로 주문자의 주소로 설정됩니다. 배송지 변경하기 버튼을 통해 받는 사람의 정보를 변경할 수 있습니다.   
2. 우편번호 찾기 버튼을 통해 새로운 주소로 배송지를 변경할 수 있습니다.**   
<br><br><br>

- 결제창   

![결제하기 일부](https://github.com/ssd256/Green_Together/blob/main/images/view/Payment.PNG)   
**결제창을 통해 원하는 결제수단을 선택하면 결제할 수 있습니다.[i'm port]**   
<br><br><br>

- 마이페이지 일부  

![마이페이지 일부](https://github.com/ssd256/Green_Together/blob/main/images/view/MyPage.PNG)   
**1. 상세조회 버튼을 통해 주문한 물품의 자세한 정보를 확인할 수 있습니다.   
2. 주문취소 버튼을 누르면 주문취소와 함께 구매 목록에서 사라집니다.   
3. 구매확정 버튼을 누르면 주문취소, 구매확정 버튼이 사라지고 후기작성 버튼이 나타납니다.   
배송완료가 되지 않을 때 구매확정을 하면, 배송상태 또한 배송완료로 바뀌게 됩니다.**
<br><br><br>

- 후기 작성 

![후기작성](https://github.com/ssd256/Green_Together/blob/main/images/view/ReviewInsert.PNG)   
**1. 후기는 구매확정 된 상품 당 한 번만 작성할 수 있고, 후기 삭제 후 재작성 할 수 없습니다.   
2. 후기작성 내용만 채우면 별점이나 사진을 선택하지 않아도 후기 등록이 가능합니다.**
<br><br><br>

- 후기 조회   

![후기 조회](https://github.com/ssd256/Green_Together/blob/main/images/view/ReviewDetail.PNG)   
**작성한 후기는 상품의 상제 조회 페이지에서 확인/삭제할 수 있습니다.**
<br><br><br>

- 관리자페이지 일부   

![관리자페이지 일부](https://github.com/ssd256/Green_Together/blob/main/images/view/Admin.PNG)   
**사용자가 구매한 주문한 상품들의 주문 상태와 배송 상태를 관리할 수 있습니다.**
<br><br><br>

- 자주 묻는 질문 게시판   

 
**1. 관리자만 해당 게시판에 질문을 등록/수정/삭제할 수 있습니다. 사용자는 조회만 가능합니다.
2. 라디오버튼을 통해 한 개의 질문과 답변을 수정/삭제할 수 있습니다. **
<br>
