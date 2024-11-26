-- 서버 생성( 그전에 ROOT 계정에서 권한부터 주고 오기)
DROP DATABASE IF EXISTS db_bookstore;
CREATE DATABASE IF NOT EXISTS db_bookstore;
USE db_bookstore;
-- TABLE 만들기
DROP TABLE IF EXISTS tbl_order;
DROP TABLE IF EXISTS tbl_customer;
DROP TABLE IF EXISTS tbl_book;

CREATE TABLE IF NOT EXISTS tbl_book
(
    book_id INT NOT NULL AUTO_INCREMENT COMMENT '책번호',
    book_name VARCHAR(100) COMMENT '책이름',
    publisher VARCHAR(50) COMMENT '출판사',
    price INT NOT NULL COMMENT '가격',
    CONSTRAINT pk_book PRIMARY KEY (book_id)
)ENGINE=INNODB COMMENT '책정보';

CREATE TABLE IF NOT EXISTS tbl_customer
(
    cust_id INT NOT NULL AUTO_INCREMENT COMMENT '고객번호',
    cust_name VARCHAR(20) COMMENT '고객명',
    cust_addr VARCHAR(50) COMMENT '주소',
    cust_tel VARCHAR(20) COMMENT '전화',
    CONSTRAINT pk_customer PRIMARY KEY (cust_id)
)ENGINE=INNODB COMMENT '고객정보'; 
ALTER TABLE tbl_customer AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS tbl_order
(
    order_id INT NOT NULL AUTO_INCREMENT COMMENT '주문번호',
    cust_id INT COMMENT '고객 번호',
    book_id INT COMMENT '책번호',
    amount INT COMMENT '판매수량',
    ordered_at DATE COMMENT '주문일자',
    CONSTRAINT pk_order PRIMARY KEY (order_id),
    CONSTRAINT fk_customer_order FOREIGN KEY (cust_id) REFERENCES tbl_customer (cust_id) ON DELETE SET NULL,
    CONSTRAINT fk_book_order FOREIGN KEY (book_id) REFERENCES tbl_book (book_id) ON DELETE CASCADE
)ENGINE=INNODB COMMENT '주문정보';

-- INSERT INTO 구간
INSERT INTO 
    tbl_book
        VALUES
            (NULL, '축구의 역사'     , '굿스포츠'  , 7000),
            (NULL, '축구 아는 여자'  , '나이스북'  , 13000),
            (NULL, '축구의 이해'     , '대한미디어', 22000),
            (NULL, '골프 바이블'     , '대한미디어', 35000),
            (NULL, '피겨 교본'       , '굿스포츠'  , 6000),
            (NULL, '역도 단계별 기술', '굿스포츠'  , 6000),
            (NULL, '야구의 추억'     , '이상미디어', 20000),
            (NULL, '야구를 부탁해'   , '이상미디어', 13000),
            (NULL, '올림픽 이야기'   , '삼성당'    , 7500),
            (NULL, '올림픽 챔피언'   , '나이스북'  , 13000);
            
INSERT INTO
    tbl_customer
        VALUES
            (NULL, '박지성', '영국'    , 000-000-0000),
            (NULL, '김연아', '대한민국', 111-111-1111),
            (NULL, '장미란', '대한민국', 222-222-2222),
            (NULL, '추신수', '미국'    , 333-333-3333),
            (NULL, '박세리', '대한민국', NULL);


INSERT INTO
    tbl_order
        VALUES
            (NULL, 1000,  1, 1, '2020-07-01'),
            (NULL, 1000,  3, 2, '2020-07-03'),
            (NULL, 1001,  5, 1, '2020-07-03'),
            (NULL, 1002,  6, 2, '2020-07-04'),
            (NULL, 1003,  7, 3, '2020-07-05'),
            (NULL, 1000,  2, 5, '2020-07-07'),
            (NULL, 1003,  8, 2, '2020-07-07'),
            (NULL, 1002, 10, 2, '2020-07-08'),
            (NULL, 1001, 10, 1, '2020-07-09'),
            (NULL, 1002,  6, 4, '2020-07-10');
            

            

