--------------------------------------------------
--------------     테이블 초기화    ------------------   
--------------------------------------------------
DROP TABLE APPLICATION CASCADE CONSTRAINTS ;
DROP TABLE BOARD CASCADE CONSTRAINTS ;
DROP TABLE MEMBER CASCADE CONSTRAINTS ;
DROP TABLE PRODUCT CASCADE CONSTRAINTS ;
DROP TABLE QUESTION CASCADE CONSTRAINTS ;
DROP TABLE REPORT CASCADE CONSTRAINTS ;
DROP TABLE CART CASCADE CONSTRAINTS ; 
DROP TABLE REVIEW CASCADE CONSTRAINTS ;
DROP TABLE VOLUNTEER CASCADE CONSTRAINTS ;
DROP TABLE ORDERS CASCADE CONSTRAINTS ;
DROP TABLE FILES CASCADE CONSTRAINTS ;
DROP TABLE COMMENTS CASCADE CONSTRAINTS ;
DROP TABLE SHARES CASCADE CONSTRAINTS ;
DROP TABLE WISH CASCADE CONSTRAINTS ;
DROP SEQUENCE SEQ_BOARD_NO;
DROP SEQUENCE SEQ_CART_NO;
DROP SEQUENCE SEQ_COMMENTS_NO;
DROP SEQUENCE SEQ_FILES_NO;
DROP SEQUENCE SEQ_ORDERS_NO;
DROP SEQUENCE SEQ_PRODUCT_NO;
DROP SEQUENCE SEQ_REPORT_NO;
DROP SEQUENCE SEQ_WISH_NO;

--------------------------------------------------
--------------        멤버 관련       ------------------   
--------------------------------------------------
CREATE TABLE MEMBER (
   M_ID          VARCHAR2(10CHAR),
   M_PWD          VARCHAR2(20CHAR) NOT NULL,
   M_TEM          CHAR(1) DEFAULT 'N',
   M_NICKNAME       VARCHAR2(10CHAR) NOT NULL,
   M_NAME             VARCHAR2(5CHAR) NOT NULL,
   M_BIRTHDAY             DATE NOT NULL,
   M_GENDER          CHAR(1) NOT NULL,
   M_ADDRESS          VARCHAR2(40CHAR) NOT NULL,
   M_EAMIL         VARCHAR2(20CHAR) NOT NULL,
   M_PHONE            VARCHAR2(13CHAR) NOT NULL,
   M_INTERST          VARCHAR2(30CHAR) NULL,
   M_JOB          VARCHAR2(10CHAR) NULL,
   M_ENABLE       CHAR(1) DEFAULT 'N',
   M_GRADE            VARCHAR2(10CHAR) NOT NULL,
   M_KAKAO            NUMBER NULL,
	M_ID 			VARCHAR2(10CHAR),
	M_PWD 			VARCHAR2(100byte) NOT NULL,
	M_TEM 			CHAR(1) DEFAULT 'N',
	M_NICKNAME 		VARCHAR2(10CHAR) NOT NULL,
	M_NAME 				VARCHAR2(5CHAR) NOT NULL,
	M_BIRTHDAY 				DATE NOT NULL,
	M_GENDER 			CHAR(1) NOT NULL,
	M_ADDRESS 			VARCHAR2(40CHAR) NOT NULL,
	M_EAMIL			VARCHAR2(20CHAR) NOT NULL,
	M_PHONE				VARCHAR2(13CHAR) NOT NULL,
	M_INTERST 			VARCHAR2(30CHAR) NULL,
	M_JOB 			VARCHAR2(10CHAR) NULL,
	M_ENABLE		 CHAR(1) DEFAULT 'N',
	M_GRADE				VARCHAR2(10CHAR) NOT NULL,
	M_KAKAO				NUMBER NULL,
    
    CONSTRAINT PK_MEMBER PRIMARY KEY (M_ID)
);

    alter table MEMBER modify(M_PWD VARCHAR2(100 byte));
    commit;

    COMMENT ON COLUMN MEMBER.M_ID IS '아이디';
    COMMENT ON COLUMN MEMBER.M_PWD IS '비밀번호';
    COMMENT ON COLUMN MEMBER.M_TEM IS '임시비밀번호 발급여부';
    COMMENT ON COLUMN MEMBER.M_NICKNAME IS '닉네임';
    COMMENT ON COLUMN MEMBER.M_NAME IS '이름';
    COMMENT ON COLUMN MEMBER.M_BIRTHDAY IS '생년월일';
    COMMENT ON COLUMN MEMBER.M_GENDER IS '성별';
    COMMENT ON COLUMN MEMBER.M_ADDRESS IS '주소';
    COMMENT ON COLUMN MEMBER.M_EAMIL IS '이메일';
    COMMENT ON COLUMN MEMBER.M_PHONE IS '핸드폰';
    COMMENT ON COLUMN MEMBER.M_INTERST IS '관심분야';
    COMMENT ON COLUMN MEMBER.M_JOB IS '직업';
    COMMENT ON COLUMN MEMBER.M_ENABLE IS '탈퇴여부';
    COMMENT ON COLUMN MEMBER.M_GRADE IS '등급';
    COMMENT ON COLUMN MEMBER.M_KAKAO IS '카카오아이디';

--------------------------------------------------
--------------     게시판 관련    ------------------   
--------------------------------------------------

CREATE TABLE BOARD (
   B_NO NUMBER,
   M_ID VARCHAR2(10CHAR),
   B_TITLE   VARCHAR2(20CHAR) NOT NULL,
   B_CONTENT VARCHAR2(500CHAR) NOT NULL,
   B_CATEGORY VARCHAR2(50)   NOT NULL,
   B_DATE DATE DEFAULT SYSDATE,
   B_MODIFYDATE DATE DEFAULT SYSDATE,
   B_STATUS CHAR(1) DEFAULT 'N',
    
    CONSTRAINT PK_BOARD PRIMARY KEY (B_NO),
    CONSTRAINT FK_MEMBER_TO_BOARD FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID)
);

    COMMENT ON COLUMN BOARD.B_NO IS '게시글번호';
    COMMENT ON COLUMN BOARD.M_ID IS '게시글작성자';
    COMMENT ON COLUMN BOARD.B_TITLE IS '제목';
    COMMENT ON COLUMN BOARD.B_CONTENT IS '내용';
    COMMENT ON COLUMN BOARD.B_CATEGORY IS '게시판카테고리';
    COMMENT ON COLUMN BOARD.B_DATE IS '작성일자';
    COMMENT ON COLUMN BOARD.B_MODIFYDATE IS '수정일자';
    COMMENT ON COLUMN BOARD.B_STATUS IS '삭제여부';


CREATE SEQUENCE  SEQ_BOARD_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--------------------------------------------------
--------------        상품 관련       ------------------   
--------------------------------------------------

CREATE TABLE PRODUCT (
   P_NO NUMBER,
   B_NO NUMBER,
   P_CATEGORY VARCHAR2(15CHAR)   NOT NULL,
   P_NAME VARCHAR2(30CHAR)   NOT NULL,
   P_PRICE   NUMBER   NOT NULL,
   P_COUNT   NUMBER   NOT NULL,
   P_COMMENT VARCHAR2(500CHAR) NOT NULL,
    
    CONSTRAINT PK_PRODUCT PRIMARY KEY (P_NO),
    CONSTRAINT FK_BOARD_TO_PRODUCT FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
);

    COMMENT ON COLUMN PRODUCT.P_NO IS '상품번호';
    COMMENT ON COLUMN PRODUCT.B_NO IS '게시글번호';
    COMMENT ON COLUMN PRODUCT.P_CATEGORY IS '상품카테고리';
    COMMENT ON COLUMN PRODUCT.P_NAME IS '상품명';
    COMMENT ON COLUMN PRODUCT.P_PRICE IS '상품가격';
    COMMENT ON COLUMN PRODUCT.P_COUNT IS '재고수량';
    COMMENT ON COLUMN PRODUCT.P_COMMENT IS '상품설명';
   
   
CREATE SEQUENCE  SEQ_PRODUCT_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--------------------------------------------------
--------------     나눔 게시판    ------------------   
--------------------------------------------------

CREATE TABLE SHARES (
   B_NO NUMBER   NOT NULL,
   S_STATUS CHAR(1) DEFAULT 'N',
   S_ADDRESS VARCHAR2(20CHAR) NOT NULL,
   S_STOCK   NUMBER NOT NULL,
   S_REPORT NUMBER   DEFAULT 0,
    
    CONSTRAINT FK_BOARD_TO_SHARES FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
);

    COMMENT ON COLUMN SHARES.B_NO IS '게시글번호';
    COMMENT ON COLUMN SHARES.S_STATUS IS '상품마감여부';
    COMMENT ON COLUMN SHARES.S_ADDRESS IS '주소';
    COMMENT ON COLUMN SHARES.S_STOCK IS '재고';
    COMMENT ON COLUMN SHARES.S_REPORT IS '신고횟수';
    
create or replace view slist
as
select *
from (select b_no, m_id, b_title, b_content, b_category, b_date, b_modifydate, b_status
     ,s_status, s_address, s_stock
    from board
    join shares using(b_no));
    
    
CREATE TABLE APPLY (
	B_NO NUMBER,
	S_APPLICANT VARCHAR2(10CHAR),
	A_APPLYINFO	VARCHAR2(20CHAR),
    
    CONSTRAINT FK_APPLY_TO_BOARD FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO),
    CONSTRAINT FK_APPLY_TO_MEMBER FOREIGN KEY (S_APPLICANT) REFERENCES MEMBER (M_ID)
);
    
--------------------------------------------------
--------------     봉사 활동    ------------------   
--------------------------------------------------
DROP TABLE VOLUNTEER CASCADE CONSTRAINTS ;

CREATE TABLE VOLUNTEER (
   B_NO NUMBER,
   V_DAY VARCHAR2(40CHAR) NOT NULL,
   V_TIME VARCHAR2(40CHAR)   NOT NULL,
   V_LOCATION VARCHAR2(40CHAR)   NOT NULL,
   V_AGENCY VARCHAR2(40CHAR) NOT NULL,
   V_RECRUITMENT NUMBER NOT NULL,
   V_APPLICANT NUMBER DEFAULT 0,
   V_RESPONSIBILITY VARCHAR2(40CHAR) NOT NULL,
   V_PHONE   NUMBER NOT NULL,
    
    CONSTRAINT FK_BOARD_TO_VOLUNTEER_1 FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
);

    COMMENT ON COLUMN VOLUNTEER.B_NO IS '게시글번호';
    COMMENT ON COLUMN VOLUNTEER.V_DAY IS '봉사기간';
    COMMENT ON COLUMN VOLUNTEER.V_TIME IS '봉사시간';
    COMMENT ON COLUMN VOLUNTEER.V_LOCATION IS '봉사장소';
    COMMENT ON COLUMN VOLUNTEER.V_AGENCY IS '등록기관';
    COMMENT ON COLUMN VOLUNTEER.V_RECRUITMENT IS '모집인원';
    COMMENT ON COLUMN VOLUNTEER.V_APPLICANT IS '신청인원';
    COMMENT ON COLUMN VOLUNTEER.V_RESPONSIBILITY IS '담당자명';
    COMMENT ON COLUMN VOLUNTEER.V_PHONE IS '담당자핸드폰번호';
    
--------------------------------------------------
--------------     봉사 신청    ------------------   
--------------------------------------------------
    CREATE TABLE PARTICIPATION (
   B_NO NUMBER NOT NULL,
   M_ID VARCHAR2(10CHAR) NOT NULL,
   V_STATUS CHAR(1) DEFAULT 'N',

    
    CONSTRAINT FK_BOARD_TO_VOLUNTEER_2 FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO),
    CONSTRAINT FK_MEMBER_TO_BOARD_2 FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID)
);

    COMMENT ON COLUMN PARTICIPATION.B_NO IS '게시글번호';
    COMMENT ON COLUMN PARTICIPATION.M_ID IS '아이디';
    COMMENT ON COLUMN PARTICIPATION.V_STATUS IS '봉사활동 신청여부(N=신청상태, Y=취소상태)';
    
    COMMIT;
--------------------------------------------------
--------------     Q/A  게시판    ------------------   
--------------------------------------------------
CREATE TABLE QUESTION (
   B_NO NUMBER,
   Q_CATEGORY VARCHAR2(50) NOT NULL,
    
    CONSTRAINT FK_BOARD_TO_QUESTION FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
);

    COMMENT ON COLUMN QUESTION.B_NO IS '게시글번호';
    COMMENT ON COLUMN QUESTION.Q_CATEGORY IS '질문카테고리';

    
--------------------------------------------------
--------------        댓글 관련       ------------------   
--------------------------------------------------
CREATE TABLE COMMENTS (
   C_NO NUMBER,
   B_NO NUMBER   NOT NULL,
   M_ID VARCHAR2(10CHAR) NOT NULL,
   C_CONTENT VARCHAR2(300CHAR) NOT NULL,
   C_DATE DATE   DEFAULT SYSDATE,
   C_MODIFYDATE DATE DEFAULT SYSDATE,
   C_STATUS CHAR(1) DEFAULT 'N',
   C_REPORT NUMBER   DEFAULT 0,
    
    CONSTRAINT PK_COMMENTS PRIMARY KEY (C_NO)
);

    COMMENT ON COLUMN COMMENTS.C_NO IS '댓글번호';
    COMMENT ON COLUMN COMMENTS.B_NO IS '게시글번호';
    COMMENT ON COLUMN COMMENTS.M_ID IS '댓글작성자';
    COMMENT ON COLUMN COMMENTS.C_CONTENT IS '댓글내용';
    COMMENT ON COLUMN COMMENTS.C_DATE IS '작성일자';
    COMMENT ON COLUMN COMMENTS.C_MODIFYDATE IS '수정일자';
    COMMENT ON COLUMN COMMENTS.C_STATUS IS '삭제여부';
    COMMENT ON COLUMN COMMENTS.C_REPORT IS '신고횟수';
   
CREATE SEQUENCE  SEQ_COMMENTS_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;   
    
--------------------------------------------------
--------------        파일 관련       ------------------   
--------------------------------------------------
CREATE TABLE FILES (
   F_NUM NUMBER,
   B_NO NUMBER   NOT NULL,
   F_PATH VARCHAR2(1000 BYTE) NOT NULL,
   F_ORIGINNAME VARCHAR2(255 BYTE) NOT NULL,
   F_CHANGENAME VARCHAR2(255 BYTE)   NOT NULL,
   F_LEVEL   NUMBER NOT NULL,
   F_STATUS VARCHAR2(1 BYTE) DEFAULT 'N',
    
    CONSTRAINT PK_FILES PRIMARY KEY (F_NUM)
);

    COMMENT ON COLUMN FILES.F_NUM IS '파일번호';
    COMMENT ON COLUMN FILES.B_NO IS '게시글번호';
    COMMENT ON COLUMN FILES.F_PATH IS '첨부파일경로';
    COMMENT ON COLUMN FILES.F_ORIGINNAME IS '파일원본이름';
    COMMENT ON COLUMN FILES.F_CHANGENAME IS '파일변경이름';
    COMMENT ON COLUMN FILES.F_LEVEL IS '파일레벨';
    COMMENT ON COLUMN FILES.F_STATUS IS '파일삭제여부';

CREATE SEQUENCE  SEQ_FILES_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;   

--------------------------------------------------
--------------        결제 관련       ------------------   
--------------------------------------------------
CREATE TABLE ORDERS (
   O_NO VARCHAR2(50),
   M_ID VARCHAR2(50) NOT NULL,
   B_NO VARCHAR2(50) NOT NULL,
   P_NO VARCHAR2(50) NOT NULL,
   O_COUNT   NUMBER NOT NULL,
   O_RECIPIENT   VARCHAR2(5CHAR)   NOT NULL,
   O_PHONE   VARCHAR2(11CHAR) NOT NULL,
   O_ADDRESS VARCHAR2(40CHAR) NOT NULL,
   O_PAY NUMBER NOT NULL,
   O_WAY VARCHAR2(10CHAR) NOT NULL,
   O_ADDMASSEGE VARCHAR2(15CHAR),
   O_PAY_DATE DATE DEFAULT SYSDATE,
   O_STATE   VARCHAR2(20) DEFAULT '결제완료',
   O_DELIVERY VARCHAR2(20)   DEFAULT '상품준비중', 
    
    CONSTRAINT PK_ORDERS PRIMARY KEY (O_NO)
);

    COMMENT ON COLUMN ORDERS.O_NO IS '주문번호';
    COMMENT ON COLUMN ORDERS.M_ID IS '주문자아이디';
    COMMENT ON COLUMN ORDERS.B_NO IS '게시글번호';
    COMMENT ON COLUMN ORDERS.P_NO IS '상품번호';
    COMMENT ON COLUMN ORDERS.O_COUNT IS '수량';
    COMMENT ON COLUMN ORDERS.O_RECIPIENT IS '수령인';
    COMMENT ON COLUMN ORDERS.O_PHONE IS '수령인연락처';
    COMMENT ON COLUMN ORDERS.O_ADDRESS IS '배송지';
    COMMENT ON COLUMN ORDERS.O_PAY IS '결제금액';
    COMMENT ON COLUMN ORDERS.O_WAY IS '결제방법';
    COMMENT ON COLUMN ORDERS.O_ADDMASSEGE IS '배송요청사항';
    COMMENT ON COLUMN ORDERS.O_PAY_DATE IS '결제날짜';
    COMMENT ON COLUMN ORDERS.O_STATE IS '주문상태(결제완료/취소/구매확정)';
    COMMENT ON COLUMN ORDERS.O_DELIVERY IS '배송상태여부(상품준비중, 배송준비중, 배송중, 배송완료)';

CREATE SEQUENCE  SEQ_ORDERS_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;   

--------------------------------------------------
--------------        장바구니       ------------------   
--------------------------------------------------
CREATE TABLE CART (
   CARTNO NUMBER,
   P_NO NUMBER   NOT NULL,
   B_NO NUMBER   NOT NULL,
   M_ID VARCHAR2(50) NOT NULL,
   CART_COUNT NUMBER NOT NULL,
    
    CONSTRAINT PK_CART PRIMARY KEY (CARTNO),
    CONSTRAINT FK_PRODUCT_TO_CART FOREIGN KEY (P_NO) REFERENCES PRODUCT (P_NO),
    CONSTRAINT FK_BOARD_TO_CART FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO),
    CONSTRAINT FK_MEMBER_TO_CART FOREIGN KEY (M_ID) REFERENCES MEMBER (M_ID)
);
    COMMENT ON COLUMN CART.CARTNO IS '장바구니번호';
    COMMENT ON COLUMN CART.P_NO IS '상품번호';
    COMMENT ON COLUMN CART.B_NO IS '게시글번호';
    COMMENT ON COLUMN CART.M_ID IS '아이디';
    COMMENT ON COLUMN CART.CART_COUNT IS '수량';

CREATE SEQUENCE  SEQ_CART_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;   

--------------------------------------------------
--------------        찜하기       ------------------   
--------------------------------------------------
CREATE TABLE WISH (
   W_NO NUMBER,
   P_NO NUMBER   NOT NULL,
   B_NO NUMBER   NOT NULL,
   M_ID VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_WISH PRIMARY KEY (W_NO)
);

    COMMENT ON COLUMN WISH.W_NO IS '찜하기번호';
    COMMENT ON COLUMN WISH.P_NO IS '상품번호';
    COMMENT ON COLUMN WISH.B_NO IS '게시글번호';
    COMMENT ON COLUMN WISH.M_ID IS '아이디';

CREATE SEQUENCE  SEQ_WISH_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;   

--------------------------------------------------
--------------       신고       ------------------   
--------------------------------------------------
CREATE TABLE REPORT (
   R_NO NUMBER,
   B_NO NUMBER NOT NULL,
   C_NO NUMBER   NOT NULL,
   R_REASON VARCHAR2(20CHAR) NOT NULL,
   R_CATEGORY VARCHAR2(10CHAR) NOT NULL,
   R_STATUS VARCHAR2(10CHAR) NOT NULL,
    
    CONSTRAINT PK_REPORT PRIMARY KEY (R_NO)
);
    
     COMMENT ON COLUMN REPORT.R_NO IS '신고번호';
     COMMENT ON COLUMN REPORT.B_NO IS '게시글번호';
     COMMENT ON COLUMN REPORT.C_NO IS '댓글번호';
     COMMENT ON COLUMN REPORT.R_REASON IS '신고사유';
     COMMENT ON COLUMN REPORT.R_CATEGORY IS '신고유형(게시글/댓글)';
     COMMENT ON COLUMN REPORT.R_STATUS IS '신고처리여부';

CREATE SEQUENCE  SEQ_REPORT_NO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;   
     
--------------------------------------------------
--------------         리뷰       ------------------   
--------------------------------------------------
CREATE TABLE REVIEW (
   P_NO NUMBER,
   B_NO NUMBER NOT NULL,
   O_NO VARCHAR2(50) NOT NULL,
   R_CONTENT VARCHAR2(300CHAR) NOT NULL,
   R_STAR NUMBER DEFAULT 5,
    
    CONSTRAINT FK_PRODUCT_TO_REVIEW_1 FOREIGN KEY (P_NO) REFERENCES PRODUCT (P_NO),
    CONSTRAINT FK_BOARD_TO_REVIEW_1 FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
	
);

    ALTER TABLE REVIEW ADD R_DATE DATE DEFAULT SYSDATE NOT NULL;
    ALTER TABLE REVIEW ADD R_STATUS VARCHAR2(1CHAR) DEFAULT 'N' NOT NULL;
    ALTER TABLE REVIEW MODIFY R_STATUS VARCHAR2(1CHAR) DEFAULT 'N';

    COMMENT ON COLUMN REVIEW.P_NO IS '상품번호';
    COMMENT ON COLUMN REVIEW.B_NO IS '게시글번호';
    COMMENT ON COLUMN REVIEW.O_NO IS '주문번호';
    COMMENT ON COLUMN REVIEW.R_CONTENT IS '후기작성내용';
    COMMENT ON COLUMN REVIEW.R_STAR IS '별점';
    COMMENT ON COLUMN REVIEW.R_DATE IS '후기등록날짜';
    COMMENT ON COLUMN REVIEW.R_STATUS IS '후기삭제여부';
--------------------------------------------------
--------------     신청 내역       ------------------   
--------------------------------------------------
CREATE TABLE APPLICATION (
   B_NO NUMBER,
   M_ID VARCHAR2(50) NOT NULL,
   A_STATUS VARCHAR2(1CHAR) DEFAULT 'N',
    
    CONSTRAINT FK_BOARD_TO_APPLICATION FOREIGN KEY (B_NO) REFERENCES BOARD (B_NO)
);

    COMMENT ON COLUMN APPLICATION.B_NO IS '게시글번호';
    COMMENT ON COLUMN APPLICATION.M_ID IS '신청자아이디';
    COMMENT ON COLUMN APPLICATION.A_STATUS IS '신청취소여부';

--------------------------------------------------
----------------   VIEW 관련	   -------------------	
--------------------------------------------------

-- 메인이미지 리스트 VIEW
CREATE OR REPLACE VIEW MAINIMAGELIST
AS
SELECT ROWNUM RNUM,MAINIMAGELIST.*
FROM (SELECT *
        FROM BOARD 
        JOIN FILES USING(B_NO)
    WHERE B_STATUS='N' AND B_CATEGORY='메인이미지'
    ORDER BY B_NO DESC) MAINIMAGELIST
WHERE F_STATUS ='N'

--slist VIEW
create or replace view slist
    as
    select *
    from (select b_no, m_id, b_title, b_content, b_category, b_date, b_modifydate, b_status
         ,s_status, s_address, s_stock
        from board
        join shares using(b_no));

--------------------------------------------------
--------------  샘플 데이터 생성 관련 ---------------   
--------------------------------------------------

-- INSERT MEMBER 
INSERT INTO MEMBER VALUES('admin', '$2a$10$8S3kn/iSZ/MmSj8.9MeIwOaU5JbmGTwJ.qu6X1v5ABJtmAaLURI2O', default, '운영자', '영자', '90/01/01' , 'M', '서울특별시 강남구', 'admin@nate.com' , '010-1234-5678', '자연' , '관리자' , default,  'admin', NULL);
INSERT INTO MEMBER VALUES('user01', '$2a$10$LaC5PBDXrXU4w.smNlO4uecCdG6GjbubUmaKl2Di/hbcRSQPYD8di', default, '김유저', '유저1', '90/02/02' , 'M', '서울특별시 강남구', 'user1@nate.com' , '010-1234-5678', '자연' , '회원' , default,  'user', NULL);


-- INSERT BOARD, QUESTION
insert into board values(SEQ_BOARD_NO.nextval, 'admin', '배송은 얼마나 걸리나요?', '배송은 관리자가 주문 확인 후 직접 배송을 하는 시스템입니다.
보통 주문완료 후 2,3일 후에 배송준비를 시작하여 약 일주일 이내에 상품을 받아보실 수 있습니다.', '자주묻는질문', sysdate, sysdate, 'N');

insert into board values(SEQ_BOARD_NO.nextval, 'admin', '물품나눔은 선착순인가요?', '물품나눔은 선착순으로 접수받고 있으며, 
취소하신 분이 생기면 추가로 접수 가능합니다.', '자주묻는질문', sysdate, sysdate, 'N');

insert into question values(SEQ_BOARD_NO.currval, '상품판매문의');

insert into question values(SEQ_BOARD_NO.currval, '물품나눔문의');

Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','인동생활체육관 외곽 및 실내 청소','■ 내용 : 체육관 주변 외곽청소(쓰레기, 잡초&낙엽제거) 및 체육관 내부(화장실, 휴게실 등) 마감청소 및 이용자 마스크 착용 안내
■ 자원봉사시간 : 17:00~21:00 (하루 4시간 인정) 
■ 봉사장소 : 대전광역시 동구 대전로 669-13 인동생활체육관(카운터)
■ 연락처 : 042-221-5038
※ 신청 후 불참 시 재 신청이 어렵습니다!(불참 시 연락 부탁드립니다.)','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-12-05~2020-12-27','17:31~21:00','대전 동구 대전로 669-13/인동체육관','대전광역시 동구',4,0,'이용',102215038);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','한국해양소년단전북연맹훈련장','한국해양소년단전북연맹훈련장 환경보호, 정화작업, 일손지원
초,중,고 학생은 오전 봉사 4시간 승인
대,직장,일반인은 상황에따라 8시간 승인
직장 단체는 사전협의 요함','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-09-26~2020-12-25','09:35~18:35','전북 군산시 비응로 107/훈련장','전라북도 군산시',10,0,'김영',104660953);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','난지수변생태생학습센터','□활동내용
○활동시간 : 오전 10시 ~ 12시
12월 5일(토), 12월 12일(토), 12월 19일(토), 12월 26일(토)
○활동장소: 난지수변생태학습센터
○인원: 1999년생 이전 출생자 25명
○활동내용
- 습지원 內 쓰러진 나무를 톱으로 절단하는 작업
- 절단한 나무를 적재소로 운반 및 정리작업


※주의사항
1) 기상악화 또는 AI에 따른 습지원 출입통제 시 활동이 취소 될 수 있습니다.
2) 방문 시 체온을 체크하며 이상이 발견될 시 귀가조치합니다. 또한 방문시 마스크를 필수로 착용해주시기 바라며 개인위생에 철저하여 주시기 바랍니다.
3) 신체활동 강도가 높으므로 신청하시는데 이 점 고려하여 신청해주시기 바랍니다.','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-12-05~2020-12-26','10:37~00:37','서울 마포구 마포대로4나길 46/난지수변생태생학습센터','서울특별시 마포구',25,0,'곽병',107132835);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','부평캠프마켓 안내 및 환경정화','주한미군 부지 반환에 따른 캠프마켓 개방으로 인하여 쾌적한 시설 이용을 위하여 안내 및 현장관리(청소, 안전지도 등) 봉사자를 모집합니다.

- 일시 : 주말 및 공휴일, 13:00~17:00

- 장소 : 부평캠프마켓 정문 집결 (부평구 산곡동487-1, 부평공원 주차장 맞은편) 

- 대상 : 캠프마켓에 관심이 있는 고등학생, 대학생, 성인 봉사자

- 내용 : 캠프마켓 이용객 안내, 환경정화 , 안전관리 등

- 문의 : 부평구자원봉사센터 김빛나 032-509-8770
           (평일 9:00~18:00 상담 가능 / 점심시간 12:00~13:00 통화 불가)

★ 주의사항(필독) ★
 - 참여시간만큼만 봉사시간 인정(지각 시 해당시간만큼 봉사시간 차감) 
 - 꼭 참여할 분만 신청 요망(신청 후 불참 시 추후 봉사신청 제한될 있음)','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2021-01-01~2021-01-31','13:42~17:42','인천 부평구 산곡동 48-7/부평공원 주차장 맞은편','인청광역시 부평구',6,0,'김빛',105098770);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','예당관광지 내 환경정화 활동','* 오후 1시 시작 시간입니다. 
 (오후 1시까지 예당관광지 관리사무소로 오셔서 활동 참여 확인 후 봉사활동 시작하시면 됩니다.
 (활동 종료 후에도 관리사무소에서 종료 확인 받으셔야 합니다.)

* 마스크 착용을 꼭 부탁드립니다. 코로나 증상이 의심될 경우 불참하셔도 됩니다. 
따로 연락은 안 주셔도 됩니다.

* 토요일, 일요일 봉사활동 신청시 봉사활동 해당 주 목요일까지 접수를 완료하셔야 합니다.
(이후에 신청껀은 봉사 배치에 어려움이 있어 신청이 반려됨을 양해 부탁드립니다.)

* 주말 봉사활동 후 봉사시간 등록은 봉사 후 주중에 가능하오니 
봉사활동 시간이 시급하게 필요하신 분은 이 점을 참고하여 주시기 바랍니다.

* 목장갑은 지참 부탁드립니다.(쓰레기봉투, 집게 제공)
','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-11-28~2020-12-27','13:57~18:57','충남 예산군 응봉면 예당관광로 161/예당관광지','충정남도 예산군',10,0,'이미',103398286);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','환경정화활동','공원 내 쓰레기 줍기, 낙엽 쓸기
실내 청소','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-11-11~2020-12-31','09:59~18:00','전남 함평군 대동면 학동로 1398-77/자연생태공원','전라남도 함평군',10,0,'박수',103202857);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','어린이바다과학관 실내외 환경정비','"필독" 
1. 봉사활동 대상자는 아동, 청소년입니다.
2. 온라인 수업이 있는 날은 봉사활동 불가합니다.','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-11-01~2020-12-31','10:03~13:03','전남 목포시 삼학로92번길 98/목포어린이바다과학관','전라남도 목포시',3,0,'진용',102708882);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','클린업 버스승강장 환경정화활동','◈ 대상 : 서구에 거주하는 청소년 자원봉사자(초등학생~고등학생)
◈ 신청 및 활동 기간 : ‘언제나’ 가능!
◈ 하루에 버스정류장 2곳 청소 시 1시간 인정!  (단, 1일 최대 1시간 인정, 한 달 최대 4시간 인정)
◈ 단체 활동 시 버스정류장 한 곳당 3명 이하만 인정!   (개인은 개인 보고서 양식 / 단체의 경우 단체 보고서 양식 활용)
◈ 활동장소 : 인천 서구 관내 버스정류장
◈ 활동 방법
  1. 활동 전 : 1365포털 자원봉사신청
  2. 활동 시 : 집게와 일회용 장갑, 쓰레기봉투, 카메라 꼭 개별 지참하여 활동 시작!
    (활동 전·후 사진, 본인과 정류장 사진, 쓰레기1컷 필수, 쓰레기는 집으로 가져가서 분리수거)
  3. 활동 후 : 보고서 양식 다운받아(첨부파일) 사진 첨부하여 seogu-center@hanmail.net 로 송부
     ※ 제목은 ‘클린업 보고서_이름’ 으로 전송','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-10-26~2020-12-26','07:17~21:17','인천 서구 도요지로202번길 6/서구 관내 버스승강장','인천광역시 서구',30,0,'심윤',105681365);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','나무입히기를 위한 자원봉사자 모집','활동목적 
 1.  나무옷입히기를 통한 거리 도시경관 개선
 2. 자원봉사자들의 역량을 발휘한 특색있는 가로수길 형성
 3. 겨울추위 보호 및 해충박멸에 도움

- 봉사인정시간: 최대 4시간(실내 및 실외활동), 간식 및 식사 미제공.
- 봉사활동시간: 10.19-12.19(일요일 제외)

- 준비물:  입지않는 겨울 니트옷(두꺼운 상의만), 마스크착용, 

*사전신청 후 개별문자발송하며 승인된 사람만이 봉사활동 참여 가능*
*코로나19로 최소인원만 모집하며 철저한 방역(자체 방역기를 활용한 수시 방역, 손소독제, QR코드 체크)을 기본으로 하여 자원봉사활동을 실시합니다*
','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-10-21~2020-12-19','10:19~18:20','인천 남동구 남동대로 712/서운프라자 106호','인천광역시 남동구',5,0,'김현',1023469533);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','코로나-19 감영병 방역수칙 지키기','신길6동 주민센터 코로나-19 감염병 방역수칙 지키기 자원봉사자를 아래와 같이 모집합니다.
0. 활동일시 : 2020.12.01. ~ 12.31(매일 1명)
0. 활동시간 : 14:00 ~ 18:00
0. 활동장소 : 신길6동 주민센터
0. 모집인원 : 1일 /1명(중복신청 가능)
0. 활동내용
  - 출입자 발열감시카메라 체크, 코로나19 예방수칙 준수사항 안내 등','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-12-01~2020-12-31','14:21~18:21','서울 영등포구 신길동 3741-11/주민센터','서울특별시 영등포구',1,1,'배용',1026701340);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','샛강 버드나무 교실','활동 내용
- 한강의 수달의 발자취에 대해 알아보고 함께 샛강 버드나무 숲을 가꾸어요.
- 숲의 나무와 생태계교란 식물에 대해 알아보고 함께 숲을 가꾸어요.
- 생태계교란 식물 관리
- 나무 심기와 가꾸기 (물 주기 등)
- 환경 정화 활동

일시: 평일 오후 2시 ~ 5시
장소: 여의도샛강생태공원 방문자센터(여의샛강생태체험관)
준비물: 활동하기 편한 복장, 텀블러, 모자, 마스크
*활동 이후 설문 조사가 있습니다.
문의: 사회적협동조합 한강 070-4647-0825
1. 자원봉사자 마스크 착용 2. 자원봉사자 간 2m 간격 유지','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-10-05~2020-12-19','14:23~17:23','서울 종로구 새문안로 92/1803호','서울특별시 종로구',9,0,'김길',1044051156);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','녹색환경문화운동','코로나 2.0 조치에 따라 봉사활동 시간계획이 부득이 변경되었습니다
* 28일은 오전 10시 부터~ 봉사활동 실시합니다(20명)
* 모든부분 단체에서 실시하는 기후위기 환경교육 2시간 필수이며 꼭 전화로 봉사활동 날자와 시간 확인하시기 바랍니다
1. 환경관련 동영상 및 활동기획 참여(청년/에코프랜즈 스카이불루) 등(모집인원10명) 
2. 홍보 동영상, 홍보기획 프로젝트 참여자 (모집인원10명)
3. 코로나19 등 도시경관과 준법질서 확립을 위한 불법옥외광고 근절을 위한 홍보, 캠페인(코로나로 봉사알자 순연 / 미리접수 가능 미정 20명)
4. 지하철역사 및 길거리 홍보캠페인(사진전시 및 피켓 등 퍼포먼스 등) (미정 10명)
5. 청소 : 정리정돈(청소비영리법인 업무지원(사무, 행사, 창고 물품정리 등  5명','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-11-18~2020-12-30','10:24~17:24','서울 영등포구 양평로 28/환경과사람들 NPO센터','서울특별시 영등포구',20,0,'최병',103383499);
Insert into BOARD (B_NO,M_ID,B_TITLE,B_CONTENT,B_CATEGORY,B_DATE,B_MODIFYDATE,B_STATUS) values (SEQ_BOARD_NO.nextval,'admin','쓰레기 줍기 봉사 활동','♡ 금강 상류지역에 위치한 금산군 추부면 추풍천 일대 비점오염원 저감을 위한 쓰레기 줍기 봉사 입니다.
♡ 봉사 장소 : 추부면 추풍천 일대 
♡ 집합 위치 : 추부 초등학교 정문 (충청남도 금산군 추부면 하마전로 23) 
♡ 활동 시간 : 오전 10 : 00 ~ 13 : 00 (3시간)

남녀노소 누구나 쉽게 참여할 수 있는 봉사 활동입니다! 
한 사람, 한 사람의 손길이 우리의 깨끗한 금산을 만듭니다^^ 많은 참여 부탁드립니다.


※ 마스크는 필수로 하고 오시길 바랍니다! ※



☎ 문의사항 : 담당자 김현돌 / 010-8990-4958','봉사활동',to_date('20/12/02','RR/MM/DD'),to_date('20/12/02','RR/MM/DD'),'N');
Insert into GREEN.VOLUNTEER (B_NO,V_DAY,V_TIME,V_LOCATION,V_AGENCY,V_RECRUITMENT,V_APPLICANT,V_RESPONSIBILITY,V_PHONE) values (SEQ_BOARD_NO.CURRVAL,'2020-12-12~2020-12-12','10:56~03:57','충남 금산군 추부면 하마전로 23/추부초등학교','충청남도 금산군',30,0,'김현',102384953);










