USE db_company;

/*SELECT FROM ~ */

-- 1. 부서 테이블의 모든 데이터 조회하기
SELECT * -- * : 모든 칼럼을 의미한다. 실무에서는 사용 금지.(성능 이슈)
FROM tbl_department; 

-- 2. 부서 테이블에서 위치만 조회하기
SELECT location
  FROM tbl_department;

-- 3. 부서 테이블에서 위치의 중복을 제거하고 조회하기
SELECT DISTINCT location -- 중복 제거 : DISTINCT
  FROM tbl_department;
  
-- 4. 칼럼에 별명 지정하기 (AS 별명)
SELECT 
      dept_id AS 부서번호
    , dept_name AS 부서명
    , location AS "부서 위치" -- 공백을 주고 싶으면 '' or ""로 묶어줘야한다.
  FROM 
      tbl_department;

-- 5. 오너 명시(데이터베이스, 테이블)
SELECT
      tbl_department.dept_id  -- 테이블명은 생략 가능
    , tbl_department.dept_name
    , tbl_department.location
  FROM
      db_company.tbl_department; -- USE db_company 로 인해서 데이터베이스는 생략 가능
      
-- 6. 테이블에 별명 지정하기(AS 별명 or AS 생략 후 별명만 지정)
SELECT
      d.dept_id
    , d.dept_name
    , d.location
  FROM
      tbl_department d;
      
/* WHERE ~ */

-- 7. 대구에 있는 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE location = '대구'; -- 비교 연산자(=, !=, >, >=, <, <=)

-- 8. 부서번호가 1이고 연봉이 3000000 이상인 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE dept_id = 1 AND salary >= 3000000; -- 논리 연산자 (AND, OR, NOT)
 
-- 9. 연봉이 3000000 ~ 5000000 사이인 사원 조회하기
 SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
   FROM tbl_employee
  WHERE salary BETWEEN 3000000 AND 5000000; -- salary >= 3000000 AND salary <= 5000000;
  
-- 10. 직급이 '과장', '부장' 인 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE position In ('과장', '부장'); -- position = '과장' OR position = '부장';
 
-- 11. 직급이 '과장', '부장'이 아닌 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE  position <> '과장' AND position != '부장'; -- position NOT IN ('과장', '부장'); 
 
-- 12. 사원명이 '한'으로 시작하는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE '한%'; -- % : 와일드 카드(만능문자 : 글자 수의 제한이 없는 모든 문자를 의미한다.)
                            -- LIKE 연산자 : 와일드 카드 전용 연산자
                            
-- 13. 사원명에 '민'을 포함하는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE CONCAT('%', '민', '%'); -- CONCAT('%', '민', '%') 함수 결과는 '%민%'이다.
-- COMCAT(=concatenate) : 전달된 문자열을 모두 이어 붙인 결과를 반환

-- 14. (db_menu 스키마) 상위카테고리고드가 없는 카테고리 조회하기
SELECT category_code, category_name, ref_category_code
  FROM db_menu.tbl_category
 WHERE ref_category_code IS NULL; -- IS NULL : NULL 이다.
 
-- 15. (db_menu 스키마) 상위카테고리코드가 있는 카테고리 조회하기
SELECT category_code, category_name, ref_category_code
  FROM db_menu.tbl_category
 WHERE ref_category_code IS NOT NULL; -- IS NOT NULL :  NOT NULL 이다.
 
/*GROUP BY ~ HAVING ~ */
/* 값을 내고 싶을 때 사용 
      SUM() : 합계
      AVG() : 평균
      MAX() : 최대
      MIN() : 최소
    COUNT() : 개수 
*/
 
-- 16. 직급별로 그룹화하여 연봉의 평균 조회하기
SELECT position, AVG(salary)   -- ★★★GROUP BY 절에 명시한 칼럼만 SELECT에서 조회할 수 있다.
   FROM tbl_employee
GROUP BY position; -- 직급별로 그룹화 작업 

-- 17. 부서별로 사원 수 조회하기
SELECT dept_id AS 부서번호, COUNT(*) AS 사원수 -- COUNT(*) : 모든 칼럼을 조회해서 어느 한 칼럼이라도 값을 가지고 있으면 카운트에 포함한다.
  FROM tbl_employee
GROUP BY dept_id;
-- *SELECT COUNT(*) : 모든 칼럼을 조회해서 카운터해준다. 의도적으로 특정칼럼을 조회하지 않으면 일반적으로 확인해햐할 경우 *를 쓴다.

-- 18. 직급별 연봉의 평균이 5000000 이상인 직급 조회하기
SELECT position, AVG(salary) -- HAVING 절에서 통계 함수를 이용한 조건식을 사용 할 수 있다.
  FROM tbl_employee
GROUP BY position
HAVING AVG(salary) >= 5000000; -- 통계함수는 WHERE 절에서 사용할 수 없다.

-- 19. 직급별 사원 수 구하기. 직급이 ' 과장' 인 직급만 조회하기
SELECT position, COUNT(*)
  FROM tbl_employee
 WHERE position = '과장' -- 통계 함수가 사용되지 않는 일반 조건. 
GROUP BY position;       -- WHERE 절에서 미리 조건을 넣어 데이터를 줄이고, GROUP을 활용하여 성능이 떨어지지 않게 함.
                         -- '과장'데이터로 sampling 데이터를 줄여서 그룹
                         
-- 잘못된 조건의 지정
SELECT position, COUNT(*)
  FROM tbl_employee        -- sampling 데이터
  GROUP BY position      -- sampling 데이터 전체를 대상으로 그룹화하고 
 HAVING position = '과장';   -- 나중에 값을 내는 경우는 성능이 떨어짐
 
 /* ORDER BY ~ */
 
 -- 20. 사원명 순으로 사원 조회하기
 SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
   FROM tbl_employee
ORDER BY emp_name ASC; -- ASCending : 오름차순 정렬 (사전 편찬 순) - 디폴트 / DESCending : 내림차순 정렬
-- DESC : 큰 숫자가 위로, 작은 숫자 일수록 아래로

-- 21. 직급의 오름차순, 동일 직급은 고용일의 내림차순 정렬
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
ORDER BY position, hire_date DESC; -- position ASC(디폴트), hire_date DESC;

/* LIMIT ~ */

-- 일반적 패턴 : 원하는 기준으로 정렬한 뒤 일부만 조회

-- 22. 가장 먼저 입사한 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
ORDER BY hire_date -- 조회할 칼럼
-- LIMIT 1; -- 1개만 보여달라는 의미
LIMIT 0, 1; -- 첫 번째 행(0 = LOW INDAX)부터 1개 행 조회함

-- 23. 급여가 2~3번째로 높은 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
ORDER BY salary DESC
LIMIT 1, 2; -- 2행(1)부터 2개 행 조회함


