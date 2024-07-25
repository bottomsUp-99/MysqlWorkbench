use bookstore;
-- 부속즬의(Subquery) --> 서브쿼리 - nested query(중첩 쿼리)
-- 실행순서 : where 절의 부속질의를 먼저 처리하고 전체즬의를 수행한다.

-- 가장 비싼 도서명을 조회하세요.
select max(price)
from book;

select bookname
from book
where price = 35000;

select bookname
from book
where price = (select max(price)
				from book);
-- 서브쿼리는 SQL문이므로 결과는 테이블로 결과를 반환
-- -> 단일행 - 단일열 (1X1), 다중행 - 단일열(NX1), 단일행 - 다중열(1XN), 다중행 - 다중열(NXN)

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select name
from Customer
where custid in (select custid from Orders);

select custid
from Orders;

-- 대한 미디어 출판사에서 출판 도서를 구매한 고객의 이름을 구하세요
select * from Book where publisher = '대한미디어';
select * from Orders where custid = 1;

select name
from Customer
where custid in(
	select custid
    from Orders
    where bookid in (
		select bookid
        from Book
        where publisher = '대한미디어'
    )
);

-- 서브쿼리는 하위 부속질의와 상관 부속질의어 두가지가 있는데, 상위 부속질의 튜플을 이용하여 하위 부속 질의를 계산한다.
-- 출판사 별로 출판사의 평균 도서 가격보다 비싼 도서의 이름을 조회하시오.(서브 쿼리로 작성하세요)
select publisher, avg(price)
from Book
group by publisher;

select bookname
from Book b1 where b1.price > (
	select avg(b2.price)
    from Book b2
    where b1.publisher = bw.piblisher
); -- b1,b2는 튜플 변수

-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
-- 1. 도서의 판매액 평균값을 구한다.  2. 평균값보다 초과인 구매 고객별 평균을 구하여 비교한 후   3. 해당 고객의 이름을 출력한다.
select name
from Customer c1
where(select avg(o2.saleprice) from Orders o2 where c1.custid = o2.custid) > (select avg(o1.saleprice) from Orders o1);

select name
from Customer c, Orders o
where c.custid = o.custid
group by c.custid
having avg(o.saleprice) > (select avg(saleprice) from Orders);