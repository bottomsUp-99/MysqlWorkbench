-- abs 함수 : 절댓값을 구하는 함수
select abs(-78), abs(78);

-- ROUND 함수 : 반올림한 값을 구하는 함수
select round(4.875, 1);

-- 고객별 평균 주문 금액을 밴 원 단위로 반올림한 값을 구허시오.
use bookstore;
select custid, round(sum(saleprice) / count(*), -2)
from Orders
group by custid;

-- replace : 문자열을 치환하는 함수
-- 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
select *
from Book
where bookname like '%야구%';
select replace(bookname, '야구', '농구') bookname from book;

-- length : 글자의 수를 세어주는 함수(단위가 바이트(byte)가 아닌 문자 단위
-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하시오.
select bookname, char_length(bookname) '문자 수', length(bookname) '바이트 수'
from Book
where publisher = '굿스포츠';

-- substr : 지정한 길이만큼의 문자열을 반환하는 함수
-- 서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나
select *
from Customer;

select substr(name, 1,1), count(*)
from customer
group by substr(name, 1, 1);

-- 서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
select orderid, orderdate, adddate(orderdate, interval 10 day)
from Orders;

-- 서점이 2014년 7월 7일에 주문 받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오.
-- 단 주문일 '%Y-%m-%d' 형태로 표시한다.
select orderid, date_format(orderdate, '%Y-%m-%d'), custid, bookid
from Orders
where orderdate = str_to_date('20140707', '%Y%m%d');

select sysdate(), date_format(sysdate(), '%Y/%m/%d %a %h:%i');
select sysdate(), now(), date_format(sysdate(), '%Y/%m/%d %a %h:%i');

create table Mybook(
	bookid int primary key,
    price int
);
insert into Mybook values(1, 10000);
insert into Mybook values(2, 20000);
insert into Mybook values(3, null);

select sum(price)
from Mybook;
select price + 100 from Mybook where bookid = 3;
select sum(price), avg(price), avg(price), count(*), count(price) from mybook;
select * from Mybook where price is null;
select * from Mybook where price = '';
select name, ifnull(phone, '전화번호가 없음ㅋㅋ') from customer;
set @seq:=0;
select (@seq:=@seq+1)'순번', custid, name, phone
from Customer
where @seq < 2;

-- VIEW
create view Vorders
as select o.orderid, o.custid, c.name, o.bookid, b.bookname, o.saleprice, o.orderdate
from Customer c, Orders o, Book b
where c.custid = o.custid and b.bookid = o.bookid;

select * from Vorders;

create view vm_Book_ball
as select *
from Book
where bookname like '%축구%';

select * from vm_Book_ball;

create view vw_customer
as select custid, name, phone
from Customer
where address like '%대한민국%';

select * from vw_customer;

select * from Vorders where name = '김연아';

create or replace view vw_customer(custid, name, address)
as select custid, name, address
from Customer
where address like '%영국%';

drop view vw_customer;

-- 판매가격이 20000원이상인 도서의 도서번, 도서이름, 고객이름, 출판사, 판매가격을 보여주는 highorders뷰를 생성하시옹.
create view highorders
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice
from Customer c, Book b, Orders o
where c.custid = o.custid and o.bookid = b.bookid and o.saleprice >= 20000;

select * from highorders;

-- 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL문을 작성하시오.
select bookname, name from highorders;

-- higjorders 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오.
-- 삭제 후, (2)번 SQL문을 다시 수행하시오.
create or replace view highorders(custid, name, address)
as select custid, name, address
from Customer c, Book b, Orders o
where c.custid = o.custid and o.bookid = b.bookid and o.saleprice >= 20000;

-- 인덱스
create index ix_Book on Book(bookname);
create index ix_Book2 on Book(publisher, price);
show index from book;

select *
from Book
where publisher = '대한미디어' and price >= 30000;

analyze table Book;
drop index ix_Book on Book;
drop index ix_Book2 on Book;