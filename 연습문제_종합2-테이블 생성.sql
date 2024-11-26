-- 스키마 생성 및 사용
CREATE DATABASE IF NOT EXISTS db_product;
USE db_product;



-- 테이블 삭제
DROP TABLE IF EXISTS tbl_buy;
DROP TABLE IF EXISTS tbl_product;
DROP TABLE IF EXISTS tbl_user;



CREATE TABLE IF NOT EXISTS tbl_user (
    user_no      INT AUTO_INCREMENT NOT NULL COMMENT '사용자번호'
  , user_id      VARCHAR(20) NOT NULL UNIQUE COMMENT '사용자아이디'
  , user_name    VARCHAR(20) COMMENT '사용자명'
  , user_year    SMALLINT COMMENT '태어난년도'
  , user_addr    VARCHAR(100) COMMENT '주소'
  , user_mobile1 VARCHAR(3) COMMENT '연락처1(010)'
  , user_mobile2 VARCHAR(8) COMMENT '연락처2(12345678)'
  , user_regdate DATE COMMENT '등록일'
  , CONSTRAINT pk_user PRIMARY KEY(user_no)
) ENGINE=InnoDB COMMENT '사용자';

CREATE TABLE IF NOT EXISTS tbl_product (
    prod_code     INT AUTO_INCREMENT NOT NULL COMMENT '상품코드'
  , prod_name     VARCHAR(20) COMMENT '상품명'
  , prod_category VARCHAR(20) COMMENT '상품카테고리'
  , prod_price    INT COMMENT '상품가격'
  , CONSTRAINT pk_product PRIMARY KEY(prod_code)
) ENGINE=InnoDB COMMENT '상품';

CREATE TABLE IF NOT EXISTS tbl_buy (
    buy_no     INT AUTO_INCREMENT NOT NULL COMMENT '구매번호'
  , user_no    INT COMMENT '사용자번호'
  , prod_code  INT COMMENT '상품코드'
  , buy_amount INT COMMENT '구매수량'
  , CONSTRAINT pk_buy PRIMARY KEY(buy_no)
  , CONSTRAINT fk_user_buy FOREIGN KEY(user_no)   REFERENCES tbl_user(user_no)
  , CONSTRAINT fk_prod_buy FOREIGN KEY(prod_code) REFERENCES tbl_product(prod_code) ON DELETE SET NULL
) ENGINE=InnoDB COMMENT '구매';

-- 사용자 테이블 데이터
INSERT INTO tbl_user VALUES (NULL, 'YJS', '유재석', 1972, '서울', '010', '11111111', '08/08/08');
INSERT INTO tbl_user VALUES (NULL, 'KHD', '강호동', 1970, '경북', '011', '22222222', '07/07/07');
INSERT INTO tbl_user VALUES (NULL, 'KKJ', '김국진', 1965, '서울', '010', '33333333', '09/09/09');
INSERT INTO tbl_user VALUES (NULL, 'KYM', '김용만', 1967, '서울', '010', '44444444', '15/05/05');
INSERT INTO tbl_user VALUES (NULL, 'KJD', '김제동', 1974, '경남', NULL, NULL, '13/03/03');
INSERT INTO tbl_user VALUES (NULL, 'NHS', '남희석', 1971, '충남', '010', '55555555', '14/04/04');
INSERT INTO tbl_user VALUES (NULL, 'SDY', '신동엽', 1971, '경기', NULL, NULL, '08/10/10');
INSERT INTO tbl_user VALUES (NULL, 'LHJ', '이휘재', 1972, '경기', '011', '66666666', '06/04/04');
INSERT INTO tbl_user VALUES (NULL, 'LKK', '이경규', 1960, '경남', '011', '77777777', '04/12/12');
INSERT INTO tbl_user VALUES (NULL, 'PSH', '박수홍', 1970, '서울', '010', '88888888', '12/05/05');

-- 상품 테이블 데이터
INSERT INTO tbl_product VALUES (NULL, '운동화', '신발', 30);
INSERT INTO tbl_product VALUES (NULL, '청바지', '의류', 50);
INSERT INTO tbl_product VALUES (NULL, '책', '잡화', 15);
INSERT INTO tbl_product VALUES (NULL, '노트북', '전자', 1000);
INSERT INTO tbl_product VALUES (NULL, '모니터', '전자', 200);
INSERT INTO tbl_product VALUES (NULL, '메모리', '전자', 80);
INSERT INTO tbl_product VALUES (NULL, '벨트', '잡화', 30);

-- 구매 테이블 데이터
INSERT INTO tbl_buy VALUES(NULL, 2, 1, 2);
INSERT INTO tbl_buy VALUES(NULL, 2, 4, 1);
INSERT INTO tbl_buy VALUES(NULL, 4, 5, 1);
INSERT INTO tbl_buy VALUES(NULL, 10, 5, 5);
INSERT INTO tbl_buy VALUES(NULL, 2, 2, 3);
INSERT INTO tbl_buy VALUES(NULL, 10, 6, 10);
INSERT INTO tbl_buy VALUES(NULL, 5, 3, 5);
INSERT INTO tbl_buy VALUES(NULL, 8, 3, 2);
INSERT INTO tbl_buy VALUES(NULL, 8, 2, 1);
INSERT INTO tbl_buy VALUES(NULL, 10, 1, 2);

COMMIT;