USE db_company;

ALTER TABLE tbl_employee AUTO_INCREMENT = 1001;

-- 행 삽입하기
-- INSERT INTO 테이블(칼럼, ...) VALUES (값, ...);
INSERT INTO tbl_department(dept_name, location) VALUES ('영업부', '대구');
INSERT INTO tbl_department(dept_name, location) VALUES ('인사부', '서울');
INSERT INTO tbl_department(dept_name, location) VALUES ('총무부', '대구');
INSERT INTO tbl_department(dept_name, location) VALUES ('기획부', '서울');

-- tbl_employee 의 첫 번째 칼럼 emp_id 에는 NULL 값을 전달해서 emp_id 칼럼의 AUTO_INCREMENT 동작을 보장한다.
INSERT INTO tbl_employee VALUES (NULL, 1, '구창민', '과장', 'M', '95-05-01', 5000000);
INSERT INTO tbl_employee VALUES (NULL, 2, '김민서', '사원', 'M', '17-09-01', 2500000);
INSERT INTO tbl_employee VALUES (NULL, 3, '이은영', '부장', 'F', '90-09-01', 5500000);
INSERT INTO tbl_employee VALUES (NULL, 4, '한성일', '과장', 'M', '93-04-01', 5000000);
