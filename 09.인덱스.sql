USE db_company;

/* 클러스터 인덱스 : PK에 부여된 인덱스 */

-- 1. (인덱스 태우기) 부서번호가 1인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id * 2 = 2; -- 인덱스가 설정된 칼럼으로 조회 -> 성능 향상
                        -- 인덱스가 설정된 칼럼을 조작하면 (연산, 함수) 더 이상 인덱스를 타지 않는다.
                        
-- 2. (인덱스 안 태우기) 부서명이 '영업부'인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_name = '영업부'; -- Full Table Scan
 -- WHERE 절에서 사용한 조건이 PK가 아니면 해당되는 테이블을 전부 찾아서 값이 나오기 때문에 성능이 떨어짐
 
-- 3. 부서번호가 1 이상인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id >= 1; -- 해당 작업은 인덱스 태움 
-- 인덱스를 태울지 풀 스캔을 할지 데이터 양에 따라 결정하거나 크기 비교(>=)를 보고 상황에 따라 DB 검색 엔진이 판단해서 결정함
-- 인덱스의 범위 조건은 검색 엔진이 Index Range Scan 또는 Ful Table Scan 중 선택해서 동작한다.

/* 보조 인덱스 만들기 */
CREATE INDEX ix_name
    ON tbl_employee(emp_name ASC);

SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name = '이은영';
 
-- Index Range Scan
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE '이%'; -- DB 검색 엔진의 판단에 따라 인덱스 태움.(Index Range Scan)

-- Full Table Scan(인덱스가 설정된 칼럼을 함수 처리 했기 때문에)
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE SUBSTRING(emp_name, 1, 1) = '이'; -- SUBSTRING(emp_name, 1, 1) : 1번째 글자부터 1글자만 추출