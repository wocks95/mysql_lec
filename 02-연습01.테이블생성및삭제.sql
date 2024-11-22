
use testdb;

DROP TABLE IF EXISTS tbl_customer;
DROP TABLE IF EXISTS tbl_bank;


CREATE TABLE IF NOT EXISTS tbl_bank 
(
    bank_id VARCHAR(20) NOT NULL COMMENT '은행코드',
    bank_name VARCHAR(30) COMMENT '은행명',
    CONSTRAINT pk_bank PRIMARY KEY(bank_id) -- 제약 조건을 검
)ENGINE=INNODB COMMENT '은행';

CREATE TABLE IF NOT EXISTS tbl_customer
(
    cust_id INT NOT NULL AUTO_INCREMENT,
    cust_name VARCHAR(30) NOT NULL,
    phone VARCHAR(30) UNIQUE,
    age SMALLINT CHECK (age BETWEEN 0 AND 100) ,
    bank_id VARCHAR(20) ,
    CONSTRAINT pk_customer PRIMARY KEY(cust_id),
    CONSTRAINT fk_bank_customer FOREIGN KEY(bank_id) REFERENCES tbl_bank(bank_id)
)ENGINE=INNODB COMMENT '고객';

