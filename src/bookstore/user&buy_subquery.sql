-- 1. 1970년 이후에 출생하고 키가 182 이상인 회원의 아이디와 이름을 조회하세요.
select userID, name
from usertbl
where birthYear >= 1970 and height >= 182;

select userID, name
from usertbl
where birthYear >= 1970 or height >= 182;

-- 2. 키가 180에서 183 사이의 회원의 정보를 조회하세요.
select *
from usertbl
where height between 180 and 183;

-- 3. 지역이 '경남'이나 '전남'이나 '경북'에서 거주하는 회원의 이름을 조회하세요.
select name
from usertbl
where addr in('경남', '전남', '경북'); -- 연속적인 값이 아닌 이산적인 값을 위해 in 연산자를 사용한다.

-- 4. 회원 중에서 김씨의 성을 가진 회원의 정보를 조히하세요.
select *
from usertbl
where name like '김%';

-- ANY / ALL / SOME
-- 김경호 회원보가 키가 크거나 같은 사람의 이름과 키를 조회하세요.
select name, height
from usertbl
where height >= (select height from usertbl where name = '김경호') ;

-- 지역이 '경남'인 회원의 사람의 키보다 크거나 같은 회원의 이름을 조회하세요.
select name, height
from usertbl
where height >= ANY(select height from usertbl where addr = '경남');

select name, height
from usertbl
where height >= ALL(select height from usertbl where addr = '경남');

select name, height
from usertbl
where height >= SOME(select height from usertbl where addr = '경남');

select name, height
from usertbl
where height = ANY(select height from usertbl where addr = '경남');

select name, height
from usertbl
where height = ALL(select height from usertbl where addr = '경남');

-- 서브쿼리는 테이블을 복사할때 많이 활용됨.
create table usertbl2(select * from usertbl);
alter table usertbl2 add constraint usertbl2_pk primary key(userID);

-- 1.buytbl 테이블에서 사용자가 구매한 물품의 개수를 조회하세요.
select userID, sum(amount)
from buytbl
group by userID;

-- 2.buytbl 테이블에서 사용자가 구매한 구매액의 총합을 구하세요.
select userID 사용자, sum(amount * price) '구매액의 총합'
from buytbl
group by userID;

-- 3.휴대폰이 있는 사용자의 수를 조회하세요.
select count(*)
from usertbl;

select count(mobile1)
from usertbl;

-- 4. 회원 중에서 총 구매액이 1000 이상인 최원에게만 사은용품을 증정하려고 한다. 해당 회원의 정보를 조회하세요.
select userID, sum(price * amount) '회원님 총 구매액'
from buytbl
group by userID
having sum(price * amount) > 1000;

select *
from usertbl u
where u.userID in (select b.userID
from buytbl b
group by b.userID
having sum(b.price * b.amount) > 1000);

-- 5. 총합 중간합계가 필요한 경우가 있다. GROUP BY 절과 WITH ROLLUP문을 사용한다.
-- 분류 별로
select * from buytbl;
select groupName, sum(price * amount) '총 결제 금액'
from buytbl
group by groupName
with rollup;