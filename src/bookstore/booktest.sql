use bookstore;

select phone
from Customer
where name = '김연아';
-- 북정보에서 가격이 10000원 이상인 도서의 이름과 출판사를 출력하세요
select bookname, publisher
from Book
where price >= 10000;

-- 모든 도서의 이름과 가격을 검색하시오.
select bookname, price
from Book;

-- 모든 도서의 도서번호, 도서 이름, 출판사, 가격을 출력하시오.
select *
from Book;

-- 도서 테이블에 있는 모든 출판사를 검색하시오.
select distinct publisher
from Book
order by publisher;

-- 가격이 20000원이 미만인 도서를 검색하시오.
select *
from Book
where price < 20000;

-- 가격이 10000이상 20000이하인 도서를 검색하시오.
select *
from Book
where price between 10000 and 20000;

select *
from Book
where (price >= 10000) and (price <= 20000);

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
select *
from Book
where publisher in ('굿스포츠', '대한미디어');

select *
from Book
where publisher like '대한미디어' or publisher like '굿스포츠';

-- '축구의 역사'를 출간한 출판사를 검색하시오.
select publisher
from Book
where bookname like '축구의 역사';

-- 와일드 문자 : %, [], [^]
-- [0-5] : 0~5 사이 숫자로 시작하는 문자열
-- [^0-5] : 0~5 사이 숫자로 시작하지 않는 문자열, _
-- _ : 특정 위취에 있는 1개의 문자와 일치 ex) '_구%' --> 두번째 위치에 '구'라는 문자가 들어가고 이후에 문자열이 있는 경우

-- 도서이름에 '축구'가 포함된 출판사를 검색하시오.
select publisher
from Book
where bookname like '%축구%';

-- 도서 이름의 왼쪽 두번째 위치에 '구'라는 문자열을 가지는 도서를 검색하시오.
select *
from Book
where bookname like '_구%';

-- 도서를 이름순으로 검색하시오
select *
from Book
order by bookname;

select *
from Book
order by bookname desc;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
select *
from Book
order by price, bookname;

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색하시오.
select *
from Book
order by price desc, publisher;

-- 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice) as 총매출
from Orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice) as '김연아 고객님의 총 판매액'
from Orders
where custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
select sum(saleprice) 총판매액, avg(saleprice)평균값, min(saleprice)최저가, max(saleprice)최고가
from Orders;

-- 서점의 도서 판매 건수를 구하시오
select count(*)
from orders; -- count()함수를 사용하면 null값은 포함해서 해당 속성의 튜플 개수를 센다.

select count(publisher)
from Book; -- count()함수에 직접 컬럼명을 기입하면 null을 제외한 해당 속성의 튜플 개수를 센다.

select count(distinct publisher)
from Book; -- count()함수에 직접 컬럼며을 기입하면 그 컬럼의 null값을 제외하고 중복된 값을 제외하여 출력한다.

select count(ifnull(saleprice,0)) from orders; -- 만약 null값이 있다면 0으로 치환해서 출력

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
select custid as 고갱님, count(*) as 도서수량, sum(saleprice) as 총판매액
from Orders
group by custid;

-- 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두권 이상 구매한 고객만 구한다.
select custid as 고객님, count(*) as "주문 도서의 총 수량"
from Orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

-- <<select 절의 실행 순서>>
-- 1. from  2. where  3. group by  4. having  5. select  6. order by
-- SQL문은 실행 순서가 없는 비절차적인 언어이지만 내부적 실행순서는 존재한다.




-- 만약 박지성 고객이 주문한 도서의 총 구매액을 알고 싶다.
-- 조인(join) : 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산.
select *
from Customer, Orders; -- 두 테이블을 아무 조건 없이 연결한 결과 관계대수 : 카디션 프로덕트 연산 5 x 10

-- 고객과 고객의 주문에 대한 데이터를 모두 보이시오.
select *
from Customer, Orders
where Customer.custid = Orders.custid; -- 두 테이블의 연결 조선을 추가 (유후~~ 조인~~)

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select saleprice
from Customer, Orders
where Customer.custid = Orders.custid;

select saleprice
from Customer
inner join Orders
on Customer.custid = Orders.custid;

-- 고객별로 주문한 도은 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select Customer.custid, sum(saleprice)
from Customer, Orders
where Customer.custid = Orders.custid
group by Customer.custid
order by Customer.custid;

-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select Customer.name, Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid;

-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select Customer.name, Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Book.price = 20000;

-- OUTER 조인(외부 조인)
select * from Customer;
select * from Orders;

select Customer.name, Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
select Customer.name, Orders.saleprice
from Customer
left outer join Orders
on Customer.custid = Orders.custid;

select Customer.name, Orders.saleprice
from Customer
right outer join Orders
on Customer.custid = Orders.custid;
