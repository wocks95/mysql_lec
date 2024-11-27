USE db_product;

-- 1. 연락처1이 없는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.
-- user_no  user_id  user_mobile1  user_mobile2
-- 5        KJD      NULL          NULL
-- 7        SDY      NULL          NULL
SELECT user_no, user_id, user_mobile1, user_mobile2
  FROM tbl_user
 WHERE user_mobile1 IS NULL;
    


-- 2. 연락처2가 '5'로 시작하는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하시오.
-- user_no  user_id  user_mobile1  user_mobile2
-- 6        NHS      010           55555555
SELECT user_no, user_id, user_mobile1, user_mobile2
  FROM tbl_user
 WHERE user_mobile2 LIKE '5%';


-- 3. 2010년 이후에 가입한 사용자의 사용자번호, 아이디, 가입일을 조회하시오.
-- user_no  user_id  user_regdate
-- 4        KYM      2015-05-05
-- 5        KJD      2013-03-03
-- 6        NHS      2014-04-04
-- 10       PSH      2012-05-05
SELECT user_no, user_id, user_regdate
  FROM tbl_user 
 WHERE YEAR(user_regdate) >= 2010; 


-- 4. 사용자번호와 연락처1, 연락처2를 연결하여 조회하시오. 연락처가 없는 경우 NULL 대신 'None'으로 조회하시오.
-- user_no  contact
-- 1        01011111111
-- 2        01022222222
-- 3        01033333333
-- 4        01044444444
-- 5        None
-- 6        01055555555
-- 7        None
-- 8        01066666666
-- 9        01077777777
-- 10       01088888888
SELECT user_no, IFNULL(CONCAT(user_mobile1, user_mobile2), 'None') AS contact
  FROM tbl_user;


-- 5. 지역별 사용자수를 조회하시오.
-- 주소   사용자수
-- 서울   4
-- 경북   1
-- 경남   2
-- 충남   1
-- 경기   2
SELECT user_addr AS 주소, COUNT(user_no) AS 사용자수
  FROM tbl_user
GROUP BY user_addr;


-- 6. '서울', '경기'를 제외한 지역별 사용자수를 조회하시오.
-- 주소   사용자수
-- 경북   1
-- 경남   2
-- 충남   1
SELECT user_addr AS 주소, COUNT(user_no) AS 사용자수
  FROM tbl_user
 WHERE user_addr NOT IN('서울', '경기')
GROUP BY user_addr;
  

-- 7. 구매내역이 없는 사용자를 조회하시오.
-- 번호  아이디
-- 3     KKJ
-- 9     LKK
-- 6     HNS
-- 7     SDY
-- 1     YJS
SELECT user_no AS 번호, user_id AS 아이디
  FROM tbl_user
 WHERE user_no NOT IN(SELECT user_no FROM tbl_buy);


-- 8. 카테고리별 구매횟수를 조회하시오.
-- 카테고리  구매횟수
-- 신발      2
-- 의류      2
-- 서적      2
-- 전자      4
SELECT p.prod_category, COUNT(b.buy_no)
  FROM tbl_product p INNER JOIN tbl_buy b
    ON p.prod_code = b.prod_code 
GROUP BY p.prod_category;


-- 9. 아이디별 구매횟수를 조회하시오.
-- 아이디  구매횟수
-- KHD     3
-- KYM     1
-- KJD     1
-- LHJ     2
-- PSH     3
SELECT u.user_id AS 아이디, COUNT(b.buy_no) AS 구매횟수
  FROM tbl_user u INNER JOIN tbl_buy b
    ON u.user_no = b.user_no
GROUP BY u.user_id;


-- 10. 아이디별 구매횟수를 조회하시오. 구매 이력이 없는 경우 구매횟수는 0으로 조회하고 아이디의 오름차순으로 조회하시오.
-- 아이디  고객명  구매횟수
-- KHD     강호동  3
-- KJD     김제동  1
-- KKJ     김국진  0
-- KYM     김용만  1
-- LHJ     이휘재  2
-- LKK     이경규  0
-- NHS     남희석  0
-- PSH     박수홍  3
-- SDY     신동엽  0
-- YJS     유재석  0
SELECT u.user_id AS 아이디, u.user_name AS 고객명, COUNT(buy_no) AS 구매횟수
  FROM tbl_user u LEFT JOIN tbl_buy b
    ON u.user_no = b.user_no
GROUP BY u.user_id, u.user_name
ORDER BY u.user_id;

-- 11. 모든 상품의 상품명과 판매횟수를 조회하시오. 판매 이력이 없는 상품은 0으로 조회하시오.
-- 상품명  판매횟수
-- 운동화  2개
-- 청바지  2개
-- 책      2개
-- 노트북  1개
-- 모니터  2개
-- 메모리  1개
-- 벨트    0개
SELECT p.prod_name AS 상품명, CONCAT(COUNT(buy_no), '개') AS 판매횟수
  FROM tbl_product p LEFT JOIN tbl_buy b
    ON p.prod_code = b.prod_code
GROUP BY p.prod_code, p.prod_name;


-- 12. 카테고리가 '전자'인 상품을 구매한 고객의 구매내역을 조회하시오.
-- 고객명  상품명  구매액
-- 강호동  노트북  1000
-- 김용만  모니터  200
-- 박수홍  모니터  1000
-- 박수홍  메모리  800
SELECT u.user_name AS 고객명, p.prod_name AS 상품명, p.prod_price * b.buy_amount AS 구매액
  FROM tbl_user u INNER JOIN tbl_buy b
    ON u.user_no = b.user_no INNER JOIN tbl_product p
    ON p.prod_code = b.prod_code
 WHERE p.prod_category = '전자';


-- 13. 상품을 구매한 이력이 있는 고객의 아이디, 고객명, 구매횟수, 총구매액을 조회하시오.
-- 아이디  고객명  구매횟수  총구매액
-- KHD     강호동  3         1210
-- KYM     김용만  1         200
-- PSH     박수홍  3         1860
-- KJD     김제동  1         75
-- LHJ     이휘재  2         80
SELECT u.user_id, u.user_name, COUNT(b.buy_no) AS 구매횟수, SUM(p.prod_price * b.buy_amount) AS 총구매액
  FROM tbl_user u INNER JOIN tbl_buy b
    ON u.user_no = b.user_no INNER JOIN tbl_product p
    ON p.prod_code = b.prod_code
GROUP BY u.user_id, u.user_id;

-- 14. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하시오.
-- 고객명  구매횟수
-- 강호동  3
-- 이휘재  2
-- 박수홍  3
SELECT u.user_name AS 고객명, COUNT(b.buy_no) AS 구매횟수
  FROM tbl_user u INNER JOIN tbl_buy b
    ON u.user_no = b.user_no
GROUP BY u.user_no, u.user_name  
HAVING COUNT(b.buy_no) >= 2;


-- 15. 어떤 고객이 어떤 상품을 구매했는지 조회하시오. 구매 이력이 없는 고객도 조회하고 아이디로 오름차순 정렬하시오.
-- 고객명   구매상품
-- 강호동   청바지
-- 강호동   노트북
-- 강호동   운동화
-- 김제동   책
-- 김국진   NULL
-- 김용만   모니터
-- 이휘재   청바지
-- 이휘재   책
-- 이경규   NULL
-- 남희석   NULL
-- 박수홍   운동화
-- 박수홍   메모리
-- 박수홍   모니터
-- 신동엽   NULL
-- 유재석   NULL



-- 16. 상품 테이블에서 상품명이 '책'인 상품의 카테고리를 '서적'으로 수정하시오.



-- 17. 연락처1이 '011'인 사용자의 연락처1을 모두 '010'으로 수정하시오.



-- 18. 구매번호가 가장 큰 구매내역을 삭제하시오.



-- 19. 상품코드가 1인 상품을 삭제하시오. 삭제 이후 상품번호가 1인 상품의 구매내역이 어떻게 변하는지 조회하시오.



-- 20. 사용자번호가 5인 사용자를 삭제하시오. 사용자번호가 5인 사용자의 구매 내역을 먼저 삭제