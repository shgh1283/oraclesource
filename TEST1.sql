CREATE TABLE BOARD(
	bno NUMBER(10,0) PRIMARY KEY,
	name VARCHAR2(20) NOT NULL,
	password VARCHAR2(20) NOT NULL,
	title VARCHAR2(20) NOT NULL,
	content VARCHAR2(20) NOT NULL,
	readcnt NUMBER(10,0) DEFAULT 0,
	regdate DATE DEFAULT SYSDATE
);


CREATE SEQUENCE board_seq;
