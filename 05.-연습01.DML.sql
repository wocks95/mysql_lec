-- 1. root 계정으로 접속하기
-- 2. greenit 계정에 db_menu 데이터베이스 사용 권한 부여하기
--  GRANT ALL PRIVILEGES ON db_menu.* TO 'greenit'@'%';

-- greenit 계정으로 접속하기
DROP DATABASE IF EXISTS db_menu;
CREATE DATABASE IF NOT EXISTS db_menu;
USE db_menu;

-- 테이블 삭제
DROP TABLE IF EXISTS tbl_order_menu;
DROP TABLE IF EXISTS tbl_payment_order;
DROP TABLE IF EXISTS tbl_order;
DROP TABLE IF EXISTS tbl_menu;
DROP TABLE IF EXISTS tbl_payment;
DROP TABLE IF EXISTS tbl_category;

-- 테이블 생성
-- PRIMARY KEY에는 UNIQUE와 NOT NULL 이 기본적으로 포함되어있음.
-- 다만, 테이블 정의서에 해달라고 적혀있을 경우 적어야함

CREATE TABLE IF NOT EXISTS tbl_category
(
    category_code INT NOT NULL AUTO_INCREMENT COMMENT '카테고리코드',
    category_name VARCHAR(30) NOT NULL COMMENT '카테고리명',
    ref_category_code INT COMMENT '상위카테고리코드',
    CONSTRAINT pk_category PRIMARY KEY (category_code),
    CONSTRAINT fk_category FOREIGN KEY (ref_category_code) REFERENCES tbl_category (category_code)
)ENGINE=INNODB COMMENT'카테고리';

CREATE TABLE IF NOT EXISTS tbl_menu
(
    menu_code INT NOT NULL  AUTO_INCREMENT COMMENT '메뉴코드',
    menu_name VARCHAR(30)  NOT NULL COMMENT '메뉴명',
    menu_price INT  NOT NULL COMMENT '메뉴가격',
    category_code INT  NOT NULL NULL COMMENT '카테고리코드',
    orderable_status CHAR(1) NOT NULL COMMENT '주문가능상태',
    CONSTRAINT pk_menu PRIMARY KEY (menu_code),
    CONSTRAINT fk_category_menu FOREIGN KEY(category_code) REFERENCES tbl_category(category_code)
)ENGINE=INNODB COMMENT'메뉴';

CREATE TABLE IF NOT EXISTS tbl_payment
(
    payment_code INT NOT NULL AUTO_INCREMENT COMMENT '결제코드',
    payment_date VARCHAR(8) NOT NULL COMMENT '결제일',
    payment_time VARCHAR(8) NOT NULL COMMENT '결제시간',
    payment_price INT NOT NULL COMMENT '결제금액',
    payment_type VARCHAR(8) NOT NULL COMMENT '결제구분',
    CONSTRAINT pk_payment PRIMARY KEY (payment_code)
)ENGINE=INNODB COMMENT'결제';

CREATE TABLE IF NOT EXISTS tbl_order
(
    order_code INT NOT NULL COMMENT '주문코드',
    order_date VARCHAR(8) NOT NULL COMMENT '주문일자',
    order_time VARCHAR(8) NOT NULL COMMENT '주문시간',
    total_order_price INT NOT NULL COMMENT '총주문금액',
    CONSTRAINT pk_order PRIMARY KEY (order_code)
)ENGINE=INNODB COMMENT'주문';

CREATE TABLE IF NOT EXISTS tbl_order_menu
(
    menu_code INT NOT NULL COMMENT '메뉴코드',
    order_code INT NOT NULL COMMENT '주문코드',
    order_amount INT  NOT NULL COMMENT '주문수량',
    CONSTRAINT pk_ordermenu PRIMARY KEY(menu_code, order_code),
    CONSTRAINT fk_menu_ordermenu FOREIGN KEY (menu_code) REFERENCES tbl_menu (menu_code),
    CONSTRAINT fk_order_ordermenu FOREIGN KEY (order_code) REFERENCES tbl_order (order_code)
)ENGINE=INNODB COMMENT'주문메뉴';

CREATE TABLE IF NOT EXISTS tbl_payment_order
(
    order_code INT NOT NULL COMMENT '주문코드',
    payment_code INT NOT NULL COMMENT '결제코드',
    CONSTRAINT pk_paymentorder PRIMARY KEY (order_code, payment_code),
    CONSTRAINT fk_order_paymentorder FOREIGN KEY (order_code) REFERENCES tbl_order (order_code),
    CONSTRAINT fk_payment_payment_order FOREIGN KEY(payment_code) REFERENCES  tbl_payment (payment_code)   
)ENGINE=INNODB COMMENT '주문결제';

INSERT INTO
    tbl_category(category_code, category_name, ref_category_code)
    VALUES
        (NULL, '메인'  , NULL),
        (NULL, '사이드', NULL),
        (NULL, '음료'  , NULL),
        (NULL, '서비스', NULL),
        (NULL, '파스타'  , 1),
        (NULL, '스테이크', 1),
        (NULL, '리조또'  , 1),
        (NULL, '피자'    , 2),
        (NULL, '샐러드'  , 2),
        (NULL, '비어'    , 3),
        (NULL, '와인'    , 3),
        (NULL, '기타'    , 3);

INSERT INTO 
    tbl_menu
    VALUES
        (NULL, '봉골레파스타'  , 12000, 5, 'O'),
        (NULL, '알리오올리오'  , 11000, 5, 'O'),
        (NULL, '토마토파스타'  , 13000, 5, 'O'),
        (NULL, '아란치니 로제' , 12000, 5, 'O'),
        (NULL, '우삼겹파스타'  , 11000, 5, 'O'),
        (NULL, '스테이크크림'  , 13000, 5, 'O'),
        (NULL, '해물크림파스타', 10000, 5, 'O'),
        
        (NULL, '퀸즈랜드 립아이' , 45000, 6, 'O'),
        (NULL, '채끝살스테이크'  , 40000, 6, 'O'),
        (NULL, '갈릭 립아이'     , 41000, 6, 'O'),
        (NULL, '티본스테이크'    , 50000, 6, 'O'),
        (NULL, '등심스테이크'    , 38000, 6, 'O'),
        (NULL, '토시살스테이크'  , 36000, 6, 'O'),
        (NULL, '살치살스테이크'  , 38500, 6, 'O'),
        (NULL, '부채살스테이크'  , 34000, 6, 'O'),
        
        (NULL, '크림리조또'     ,  8500, 7, 'O'),
        (NULL, '로제리조또'     ,  8500, 7, 'O'),
        (NULL, '불고기리조또'   ,  9000, 7, 'O'),
        (NULL, '해물리조또'     ,  9000, 7, 'O'),
        (NULL, '먹물리조또'     , 10000, 7, 'O'),
        (NULL, '스테이크리조또' , 11000, 7, 'O'),
        
        (NULL, '치즈피자'      ,  8000, 8, 'O'),
        (NULL, '불고기피자'    ,  9000, 8, 'O'),
        (NULL, '페퍼로니피자'  ,  9000, 8, 'O'),
        (NULL, '포테이토피자'  ,  8000, 8, 'O'),
        (NULL, '콤비네이션피자',  9000, 8, 'O'),
        (NULL, '바베큐피자'    , 10000, 8, 'O'),
        
        (NULL, '닭가슴살샐러드'    , 8000, 9, 'O'),
        (NULL, '리코타치즈샐러드'  , 7000, 9, 'O'),
        (NULL, '바질페스토샐러드'  , 8000, 9, 'O'),
        (NULL, '훈제연어샐러드'    , 9000, 9, 'O'),
        (NULL, '목살샐러드'        , 9000, 9, 'O'),
        
        (NULL, '카스'      , 6000, 9, 'O'),
        (NULL, '호가든'    , 6000, 9, 'O'),
        (NULL, '삿포로'    , 6000, 9, 'O'),
        (NULL, 'OB'        , 6000, 9, 'O'),
        (NULL, '레드와인'  , 8000, 9, 'O'),
        (NULL, '화이트와인', 8000, 9, 'O'),
        (NULL, '물'        ,    0, 9, 'O');
        
COMMIT;
