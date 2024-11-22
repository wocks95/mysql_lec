-- root 계정으로 접속하기
-- greenit 계정에 db_company 데이터 베이스 사용 권한 부여하기
-- GRANT ALL PRIVILEGES ON db_company.* TO 'greenit'@'%';

-- greenit 계정으로 접속하기
-- 데이터베이스(스키마) 삭제 형식
-- DROP {DATABASE | SCHEMA} [IF EXISTS] db_name;
DROP DATABASE IF EXISTS db_company; 

-- 데이터베이스(스키마) 생성 형식
-- CREATE {DATABASE | SCHEMA} [IF EXISTS] db_name [create_option]...
CREATE DATABASE IF NOT EXISTS db_company;

-- 데이터베이스 사용
 USE db_company;

DROP TABLE IF EXISTS tbl_employee;
DROP TABLE IF EXISTS tbl_proj_emp;
DROP TABLE IF EXISTS tbl_department;
DROP TABLE IF EXISTS tbl_project;

CREATE TABLE IF NOT EXISTS tbl_department
(
    dept_id INT NOT NULL AUTO_INCREMENT COMMENT'부서아이디',
    dept_name VARCHAR(30) COMMENT'부서명',
    location VARCHAR(50) COMMENT'위치',
    CONSTRAINT pk_department PRIMARY KEY (dept_id)
)ENGINE=INNODB COMMENT'부서';

CREATE TABLE IF NOT EXISTS tbl_project
(
    proj_id INT NOT NULL AUTO_INCREMENT COMMENT'사원아이디',
    proj_name VARCHAR(30) COMMENT'프로젝트명',
    begin_date DATE COMMENT'시작일자', 
    end_date DATE COMMENT'종료일자',
    CONSTRAINT pk_project PRIMARY KEY (proj_id)
)ENGINE=INNODB COMMENT'프로젝트';

CREATE TABLE IF NOT EXISTS tbl_employee
(
    emp_id INT NOT NULL AUTO_INCREMENT,
    dept_id INT NOT NULL,
    emp_name VARCHAR(15),
    position CHAR(10),
    gender CHAR(1),
    hire_date DATE,
    salary INT,
    CONSTRAINT pk_emp PRIMARY KEY (emp_id),
    CONSTRAINT fk_dept_emp FOREIGN KEY (dept_id) REFERENCES tbl_department(dept_id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tbl_proj_emp
(
    reg_id INT NOT NULL,
    state INT NOT NULL,
    emp_id INT NULL,
    proj_id INT NULL,
    CONSTRAINT pk_proj_emp PRIMARY KEY (reg_id),
    CONSTRAINT fk_employee_projemp FOREIGN KEY (emp_id) REFERENCES tbl_employee(emp_id),
    CONSTRAINT fk_project_projemp FOREIGN KEY (proj_id) REFERENCES tbl_project(proj_id)
)ENGINE=INNODB;