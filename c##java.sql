CREATE TABLE usertbl(

	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	age NUMBER(3) NOT NULL,
	email varchar2(20) NOT null
);

INSERT INTO USERTBL VALUES('honh123','홍길동','hong123', 25, 'hong123@gmail.com');

ALTER TABLE USERTBL MODIFY email VARCHAR2(50);

-- userid(honh123) 와 password(hong123) 가 일치하는 회원 조회
SELECT userid, name FROM USERTBL u WHERE USERID ='honh123' AND PASSWORD ='hong123';

-- 회원 전체 조회
SELECT userid, name,age,email FROM USERTBL;

-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변견
UPDATE USERTBL
SET PASSWORD ='hong456'
WHERE USERID ='honh123' AND PASSWORD ='hong123';

SELECT *FROM USERTBL u ;

-- 회원삭제
-- 아이디와 비밀번호 일치 시 삭제
DELETE FROM USERTBL WHERE USERID ='honh123' AND PASSWORD ='hong123';


-- booktbl
-- code number (4) pk
-- title text(50)
-- writer text(50)
-- price number(10)
CREATE TABLE booktbl(

	code number(4) PRIMARY KEY,
	title varchar2(50) NOT NULL,
	writer varchar2(30) NOT NULL,
	price number(10) NOT NULL
);

ALTER TABLE booktbl ADD description VARCHAR2(1000);

-- 1000 자바의 정석 신용균 25000
INSERT INTO booktbl VALUES(1000,'자바의 정석','신용균', 25000);
-- 1001 자바의  신 강신용 29000
INSERT INTO booktbl VALUES(1001,'자바의 신','강신용', 29000);
-- 1002 자바 1000제 남궁성 32000
INSERT INTO booktbl VALUES(1002,'자바 1000제','남궁성', 32000);
-- 1003 오라클 박응용 33000
INSERT INTO booktbl VALUES(1003,'오라클','박응용', 33000);
-- 1004 점프투파이썬 신기성 35000
INSERT INTO booktbl VALUES(1004,'점프투파이썬','신기성', 35000);

-- 전체 조회
SELECT *FROM BOOKTBL;

-- 도서번호 1000 번인 도서 조회 (상세조회)
SELECT *FROM booktbl WHERE code=1000;

-- 도서번호 1001 번인 도서 가격 수정
UPDATE BOOKTBL
SET price = 45000
WHERE code = 1001;
-- 도서번호 1001 번인 도서 가격 및 상세 설명 수정
UPDATE BOOKTBL
SET price = 45000, DESCRIPTION = '상세설명'
WHERE code = 1001;

-- 도서번호 1004 번 도서 삭제
DELETE FROM booktbl WHERE code=1004;

-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT *FROM BOOKTBL WHERE title LIKE '%자바%';

-- 더미 데이터 삽입
CREATE SEQUENCE book_seq
START WITH 2000;


INSERT INTO BOOKTBL (code,title,WRITER,PRICE)
(SELECT book_seq.nextval,title,WRITER,PRICE FROM BOOKTBL);

SELECT COUNT(*) FROM BOOKTBL b; 

-- 검색(조회)
-- title 에 자바 키워드가 포함된 도서 조회 후 도서코드로 내림차순정렬
SELECT *FROM BOOKTBL WHERE title LIKE '%자바%'ORDER BY CODE DESC;

SELECT *FROM BOOKTBL WHERE title LIKE '%%'ORDER BY CODE DESC;

CREATE TABLE membertbl(

	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL
);

INSERT INTO membertbl VALUES('hong123','홍길동','hong123');

-- 아이디와 비밀번호가 일치하는 회원 조회 (로그인)
SELECT *FROM membertbl WHERE userid='hong123' AND password='hong123';
SELECT *FROM membertbl;

-- 중복 아이디 검사
-- 
SELECT *FROM membertbl WHERE userid='hong123';

-- 비밀번호 변경
UPDATE MEMBERTBL
SET PASSWORD ='hong456'
WHERE USERID ='hong456' AND PASSWORD ='hong789';

-- board
--bno, name,password,tilte,content,file,re_ref,re_lev,re_seq,readcnt,regdate(date-sysdate)

-- 시퀀스 생성 board_seq

CREATE TABLE board(

	bno number(8) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(2000) NOT NULL,
	attach varchar2(100) NOT NULL,
	re_ref NUMBER(8) NOT NULL,
	re_lev NUMBER(8) NOT NULL,
	re_seq NUMBER(8) NOT NULL,
	readcnt NUMBER(8) DEFAULT 0,
	regdate DATE DEFAULT sysdate
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

-- board attach not null => null 가능
ALTER TABLE board MODIFY attach varchar2(100) NULL;
alter table board rename column tilte to title;

INSERT INTO board(bno, name, password, title, content, RE_REF, RE_LEV,RE_SEQ)
VALUES(board_seq.nextval,'hong','12345','board 작성', 'board 작성', board_seq.currval,0,0)

SELECT*FROM BOARD ;

-- 수정
-- bno와 password가 일치 시 title, content 수정
UPDATE BOARD SET title='변경할 타이틀', CONTENT='변경할 내용'
WHERE bno = 3  AND PASSWORD =12345 ;

-- 조회수 업데이트
UPDATE BOARD SET READCNT= READCNT+1  WHERE bno = 2 ;

-- 더미 데이터
INSERT INTO board(bno, name, password, title, content, RE_REF, RE_LEV,RE_SEQ)
(SELECT board_seq.nextval, name, password, title, content, board_seq.currval,RE_LEV ,RE_SEQ FROM BOARD);

SELECT  count(*) FROM BOARD;

-- 댓글처리
SELECT *
FROM BOARD WHERE bno=( SELECT max(bno) FROM BOARD); 

-- 그룹 개녕(re_ref)

-- 댓글 추가(re_ref : 부모글의 re_ref 넣어주기)
-- re_lev : 부모글 re_lev+1
-- re_seq : 부모글 re_seq+1
INSERT INTO board(bno, name, password, title, content, RE_REF, RE_LEV,RE_SEQ)
VALUES(board_seq.nextval,'hong','12345','board 작성', 'board 작성', 15365,1,1);

-- UPDATE BOARD SET RE_LEV =1,RE_SEQ =1 WHERE BNO =15366;
-- 원본글과 댓글 함께 조회
SELECT *FROM BOARD b WHERE RE_REF =15365;

-- 두번째 댓글 추가(select 최신순 조회 : re_seq)
-- re_seq 낮을 수록 최신글

-- 원본글
-- ㄴ 댓글2
--   ㄴ 댓글2의 댓글
-- ㄴ 댓글1

-- 댓글 2 추가
-- 먼저 들어간 댓글이 있다면 re_seq 값을 +1 해야 함
UPDATE BOARD SET RE_SEQ =RE_SEQ +1 WHERE RE_REF =15365 AND RE_SEQ > 0;

INSERT INTO board(bno, name, password, title, content, RE_REF, RE_LEV,RE_SEQ)
VALUES(board_seq.nextval,'hong','12345','댓글 board 작성', '댓글 board 작성', 15365,1,1);

SELECT *FROM BOARD b WHERE RE_REF =15365 ORDER BY RE_SEQ DESC ,RE_SEQ ASC;

-- 검색
-- 조건 title or content or name
-- 검색어
select bno, name, title, readcnt ,regdate,re_lev from board WHERE title like'%한글%'ORDER BY RE_SEQ DESC ,RE_SEQ ASC;
select bno, name, title, readcnt ,regdate,re_lev from board WHERE  content like'%한글%'ORDER BY RE_SEQ DESC ,RE_SEQ ASC;
select bno, name, title, readcnt ,regdate,re_lev from board WHERE name like'%홍길동%'ORDER BY RE_SEQ DESC ,RE_SEQ ASC;

-- 오라클 페이지 나누기
-- 정렬이 완료된 후 번호를 매겨서 일부분 추출

select rownum, bno, name, title, readcnt ,regdate,re_lev from board ORDER BY RE_SEQ DESC ,RE_SEQ ASC;

select rownum, bno, name, title, readcnt ,regdate,re_lev from board ORDER BY BNO DESC;

SELECT rnum,bno, name, title, readcnt ,regdate,re_lev
FROM (SELECT rownum rnum,bno, name, title, readcnt ,regdate,re_lev 
	FROM (select bno, name, title, readcnt ,regdate,re_lev from board ORDER BY RE_SEQ DESC ,RE_SEQ ASC)
	WHERE rownum <=20)
WHERE rnum >10;

-- 1 page 요청 : rownum <=10 rnum >0
-- 2 page 요청 : rownum <=20 rnum >10

-- n page 요청 : rownum <=10n 
-- 				rnum >10*(n-1)

-- 전체 개수
SELECT COUNT(*) FROM BOARD; 

-- 검색어 기준으로 전체 개수
SELECT COUNT(*) FROM BOARD WHERE title like'%한글%'; 
SELECT COUNT(*) FROM BOARD WHERE content like'%한글%'; 
SELECT COUNT(*) FROM BOARD WHERE name like'%한글%'; 
