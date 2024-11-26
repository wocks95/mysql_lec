USE db_bookstore;

-- 7. 책이름에 '올림픽'이 포함된 책 정보를 조회하시오.
SELECT book_id, book_name, publisher, price
  FROM tbl_book
 WHERE book_name LIKE CONCAT('%','올림픽', '%');
 
-- 8. 가격이 가장 비싼 책을 조회하시오.
SELECT book_id, book_name, publisher, price
  FROM tbl_book
 WHERE price = (SELECT MAX(price)
                  FROM tbl_book);

-- 9. '2020-07-05'부터 '2020-07-09' 사이에 주문된 도서 정보를 조회하시오.
SELECT o.order_id AS 주문번호, b.book_id AS 책번호, b.book_name AS 책이름
  FROM tbl_book b INNER JOIN tbl_order o
    ON b.book_id = o.book_id
 WHERE o.ordered_at BETWEEN '2020-07-05' AND '2020-07-09'
 ORDER BY o.ordered_at;
 

-- 10. 주문한 이력이 없는 고객의 이름을 조회하시오.
SELECT c.cust_name AS 고객명
  FROM tbl_customer c LEFT JOIN tbl_order o
    ON c.cust_id = o.cust_id
 WHERE o.order_id IS NULL;

-- 11. '2020-07-04'부터 '2020-07-07' 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.
SELECT order_id AS 구매번호
     , cust_id AS 고객번호
     , book_id AS 책번호
     , amount AS 구매액
     , ordered_at AS 주문일자
  FROM tbl_order
 WHERE ordered_at NOT BETWEEN '2020-07-04' AND '2020-07-07';

-- 12. 가장 최근에 구매한 고객의 이름, 책이름, 주문일자를 조회하시오.
SELECT cust_name AS 고객명
     , b.book_name AS 책이름
     , o.ordered_at AS 주문일자
  FROM tbl_book b INNER JOIN tbl_order o
    ON b.book_id = o.book_id INNER JOIN tbl_customer c
    ON c.cust_id = o.cust_id
 WHERE o.ordered_at = (SELECT MAX(ordered_at) FROM tbl_order);
 
-- 13. 주문된 적이 없는 책의 주문번호, 책번호, 책이름을 조회하시오.
SELECT o.order_id, b.book_id, b.book_name
  FROM tbl_book b LEFT JOIN tbl_order o
    ON b.book_id = o.book_id
 WHERE o.order_id IS NULL;    
 
-- 14. 모든 서적 중에서 가장 비싼 서적을 구매한 고객이름, 책이름, 가격을 조회하시오.
-- 가장 비싼 서적을 구매한 고객이 없다면 고객 이름은 NULL로 처리하시오.
SELECT c.cust_name AS 고객이름
     , b.book_name AS 책이름
     , b.price AS 가격
  FROM tbl_book b LEFT JOIN tbl_order o
    ON b.book_id = o.book_id LEFT JOIN tbl_customer c
    ON c.cust_id = o.cust_id
 WHERE b.price = (SELECT MAX(price) FROM tbl_book);

-- 15. '김연아'가 구매한 도서수를 조회하시오.
SELECT c.cust_name AS 고객명, COUNT(o.order_id) AS 구매도서수
  FROM tbl_customer c INNER JOIN tbl_order o
    ON c.cust_id = o.cust_id -- PK로 연결된 KEY로 ON을 작성
 WHERE c.cust_name = '김연아'
GROUP BY c.cust_id, c.cust_name;

-- 16. 출판사별로 판매된 책의 개수를 조회하시오.
SELECT b.publisher AS 출판사
     , COUNT(o.order_id) AS 판매된책수
  FROM tbl_book b LEFT JOIN tbl_order o
    ON b.book_id = o.book_id
GROUP BY b.publisher;
-- 17. '박지성'이 구매한 도서를 발간한 출판사(publisher) 개수를 조회하시오.
-- 고객명  출판사수
SELECT c.cust_name AS 고객명, COUNT(DISTINCT B.publisher) AS 출판사
  FROM tbl_customer c INNER JOIN tbl_order o
    ON c.cust_id = o.cust_id INNER JOIN tbl_book b
    ON b.book_id = o.book_id
GROUP BY c.cust_id, c.cust_name;

-- 18. 모든 구매 고객의 이름과 총구매액(price * amount)을 조회하시오. 구매 이력이 있는 고객만 조회하시오.
-- 고객명  총구매액
-- 박지성  116000
-- 김연아  19000
-- 장미란  62000
-- 추신수  86000
SELECT c.cust_name AS 고객명
     , SUM(b.price * o.amount) AS 구매액
  FROM tbl_customer c INNER JOIN tbl_order o 
    ON c.cust_id = o.cust_id INNER JOIN tbl_book b
    ON b.book_id = o.book_id
GROUP BY c.cust_id, c.cust_name;

-- 19. 모든 구매 고객의 이름과 총구매액(price * amount)과 구매횟수를 조회하시오. 구매 이력이 없는 고객은 총구매액과 구매횟수를 0으로 조회하고, 고객번호 오름차순으로 정렬하시오.
-- 고객명  총구매액  구매횟수
-- 박지성  116000     3
-- 김연아  19000      2
-- 장미란  62000      3
-- 추신수  86000      2
-- 박세리  0          0
SELECT c.cust_name AS 고객명
     , IFNULL(SUM(b.price * o.amount), 0) AS 구매액
     , COUNT(O.order_id) AS 구매횟수
  FROM tbl_customer c LEFT JOIN tbl_order o
    ON c.cust_id = o.cust_id LEFT JOIN tbl_book b
    ON b.book_id = o.book_id
GROUP BY c.cust_id, c.cust_name
ORDER BY c.cust_id ASC;

-- 20. 총구매액이 2~3위인 고객의 이름와 총구매액을 조회하시오.
-- 고객명  총구매액
-- 추신수  86000
-- 장미란  62000
SELECT c.cust_name AS 고객명
     , SUM(b.price * o.amount) AS 총구매액
  FROM tbl_customer c INNER JOIN tbl_order o
    ON c.cust_id = o.cust_id INNER JOIN tbl_book b
    ON b.book_id = o.book_id
GROUP BY c.cust_id, c.cust_name 
-- c.cust_id, c.cust_name 기준으로 그룹을 묶고, 고객명의 총구매액 합계를 보여줌
ORDER BY 총구매액 DESC
LIMIT 1, 2;



