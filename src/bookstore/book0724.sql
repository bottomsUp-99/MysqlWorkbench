use bookstore;
-- 1.1
select bookname
from Book
where bookid = 1;
-- 1.2
select bookname
from Book
where price >= 20000;
-- 1.3
select sum(saleprice) as '박지성의 총 구매액'
from Orders
where custid = 1;
-- 1.4
select custid, count(*) as '박지성이 구매한 도서의 수'
from Orders
where custid = 1;
-- 2.1
select count(*)
from Book;
-- 2.2
select count(distinct publisher)
from Book;
-- 2.3
select name, address
from Customer;
-- 2.4
select orderid
from Orders
where orderdate between str_to_date('2024-07-04', '%Y-%m-%d') and str_to_date('2024-07-07', '%Y-%m-%d');

select orderid
from Orders
where orderdate between DATE('2024-07-04') and DATE('2024-07-07');

select orderid
from Orders
where orderdate between ('2024-07-04') and ('2024-07-07');

-- 2.5
select orderid
from Orders
where orderdate not between str_to_date('2024-07-04', '%Y-%m-%d') and str_to_date('2024-07-07', '%Y-%m-%d');
-- 2.6
select name, address
from Customer
where name like '김%';
-- 2.7
select name, address
from Customer
where name like '김%아';

-- 1.1 -- 박지성이 구매한 도서의 출판사 수
select count(distinct Book.publisher)
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Customer.name = '박지성';

-- 1.2 -- 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select Book.bookname, Book.price, (Book.price - Orders.saleprice) as '정가와 판매가격의 차이'
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Customer.name = '박지성';

-- 1.3 -- 박지성이 구매하지 않은 도서의 이름
select distinct Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Customer.name != '박지성';

select distinct Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Customer.name = '박지성';

select distinct Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Customer.name != '김연아';

select distinct Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid and Customer.name = '김연아';

select distinct Book.bookname
from Customer, Book, Orders
where Customer.custid = Orders.custid and Book.bookid = Orders.bookid;

select *
from Book;