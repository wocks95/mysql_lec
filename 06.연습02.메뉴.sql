DROP DATABASE IF EXISTS db_menu;
CREATE DATABASE IF NOT EXISTS db_menu;
USE db_menu;


DROP TABLE IF EXISTS tbl_order_menu;
DROP TABLE IF EXISTS tbl_payment_order;
DROP TABLE IF EXISTS tbl_order;
DROP TABLE IF EXISTS tbl_menu;
DROP TABLE IF EXISTS tbl_payment;
DROP TABLE IF EXISTS tbl_category;

CREATE TABLE IF NOT EXISTS tbl_category
(
    category_code INT NOT NULL COMMENT '카테고리코드',
    category_name VARCHAR(30) COMMENT '카테고리명',
    ref_category_code INT COMMENT '상위카테고리코드',
    CONSTRAINT pk_category PRIMARY KEY (category_code),
    CONSTRAINT fk_category FOREIGN KEY (ref_category_code) REFERENCES tbl_category (category_code)
)ENGINE=INNODB COMMENT'카테고리';

CREATE TABLE IF NOT EXISTS tbl_menu
(
    menu_code INT NOT NULL  AUTO_INCREMENT COMMENT '메뉴코드',
    menu_name VARCHAR(30) COMMENT '메뉴명',
    menu_price INT COMMENT '메뉴가격',
    orderable_status CHAR(1) COMMENT '주문가능상태',
    category_code INT NULL COMMENT '카테고리코드',
    CONSTRAINT pk_menu PRIMARY KEY (menu_code),
    CONSTRAINT fk_category_menu FOREIGN KEY(category_code) REFERENCES tbl_category(category_code)
)ENGINE=INNODB COMMENT'메뉴';

CREATE TABLE IF NOT EXISTS tbl_payment
(
    payment_code INT NOT NULL COMMENT '결제코드',
    payment_date VARCHAR(8) COMMENT '결제일',
    payment_time VARCHAR(8) COMMENT '결제시간',
    payment_price INT COMMENT '결제금액',
    payment_type VARCHAR(8) COMMENT '결제구분',
    CONSTRAINT pk_payment PRIMARY KEY (payment_code)
)ENGINE=INNODB COMMENT'결제';

CREATE TABLE IF NOT EXISTS tbl_order
(
    order_code INT NOT NULL COMMENT '주문코드',
    order_date VARCHAR(8) COMMENT '주문일자',
    order_time VARCHAR(8) COMMENT '주문시간',
    total_order_price INT COMMENT '총주문금액',
    CONSTRAINT pk_order PRIMARY KEY (order_code)
)ENGINE=INNODB COMMENT'주문';

CREATE TABLE IF NOT EXISTS tbl_order_menu
(
    menu_code INT NULL COMMENT '메뉴코드',
    order_code INT NULL COMMENT '주문코드',
    order_amount INT COMMENT '주문수량',
    CONSTRAINT fk_menu_ordermenu FOREIGN KEY (menu_code) REFERENCES tbl_menu (menu_code),
    CONSTRAINT fk_order_ordermenu FOREIGN KEY (order_code) REFERENCES tbl_order (order_code)
)ENGINE=INNODB COMMENT'주문메뉴';

CREATE TABLE IF NOT EXISTS tbl_payment_order
(
    order_code INT NULL COMMENT '주문코드',
    payment_code INT NULL COMMENT '결제코드',
    CONSTRAINT fk_order_paymentorder FOREIGN KEY (order_code) REFERENCES tbl_order (order_code),
    CONSTRAINT fk_payment_payment_order FOREIGN KEY(payment_code) REFERENCES  tbl_payment (payment_code)   
)ENGINE=INNODB COMMENT '주문결제';

INSERT INTO
    tbl_category(category_code, category_name, ref_category_code)
    VALUES
        (1, '파스타'  , NULL),
        (2, '스테이크', NULL),
        (3, '서비스'  , NULL),
        (4, '피자'    , NULL),
        (5, '사이드'  , NULL),
        (6, '음료'    , 5),
        (7, 'beer'    , 6),
        (8, 'wine'    , 6),
        (9, 'drink'   , 6);

        
        
INSERT INTO 
    tbl_menu
    VALUES
        (NULL, '봉골레파스타', 30000, 'O', 1),
        (NULL, '치맛살'      , 50000, 'O', 2),
        (NULL, '치즈피자'    , 25000, 'O', 4),
        (NULL, '피클'        ,  5000, 'X', 3),
        (NULL, '물티슈'      ,     0, 'X', 3),
        (null, '호가든'      ,  7000, 'O', 7);
COMMIT;
