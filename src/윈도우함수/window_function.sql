show databases;
use sakila;
show tables;
desc actor;
select * from actor limit 30;
select * from actor order by first_name desc;
desc payment;

-- 순위 함수 : 조회 결과에 순위를 부여
-- row_number, rank, dense_rank, ntile

-- 1. row_number : 유일한 값으로 순위를 부여하는 함(모든 행에 유일한 값으로 부여한다)
select * from payment;

select row_number() over(order by amount desc) as num, customer_id, amount
from (
	select customer_id, sum(amount) as amount
    from payment
    group by customer_id
) as x;

-- 임의의 동점인 amount에 대해서 순위를 mysql이 임의로 부여하지 않게 하기 위해서 order by문에 저렬 조건을 추가
select row_number() over(order by amount desc, customer_id desc) as num, customer_id, amount
from (
	select customer_id, sum(amount) as amount
    from payment
    group by customer_id
) as x;

-- rank(우선 순위를 고려하지 않고 순위를 부여하는 함수) : 같은 순위를 처리하는 방식이 row_number와 다르다.
-- rank 함수를 활용시에는 우선순위를 따지지 않고 같은 순위를 부여한다.
select rank() over(order by amount desc) as num, customer_id, amount
from(
	select customer_id, sum(amount) as amount from payment group by customer_id
)as x; -- 결과 확인 시, amount 값이 같을 경우 같은 순위를 부여한 것이 확인된다잉.
	   -- 공동 순위가 부여괴도, 그 다음 순위는 같은 순위에 있는 데이터 갯수만큼 뛴 순위가 부여된다잉.

-- partition by 사용하기(학년별 석차등급 구하기 이런거에 활용하면 좋으메~~)
select staff_id, row_number() over(partition by staff_id order by amount desc, customer_id desc) as num, customer_id, amount
from (
	select customer_id, staff_id, sum(amount) as amount
    from payment
    group by customer_id, staff_id
) as x;

-- dense_rank :
select rank() over(order by amount desc) as num, customer_id, amount
from(
	select customer_id, sum(amount) as amount from payment group by customer_id
)as x;

select dense_rank() over(order by amount desc) as num, customer_id, amount
from(
	select customer_id, sum(amount) as amount from payment group by customer_id
)as x;

-- ntile() : 그룹순위 인자로 지정한 개수만큼 데이터 행을 그룹화 한 다음 각 그룹에 순위를 부여하는 함수이다.
-- 각 그룹에 1부터 순위로 매겨지고, 순위는 각 행의 순위가 아니라 행이 속한 그룹의 순위이다.
-- 그룹에 대한 혜택을 차등으로 지급할 때 활용하기 좋은 함수.
select ntile(100) over(order by amount desc) as num, customer_id, amount
from (
select customer_id, sum(amount) as amount from payment group by customer_id
)as x;

-- 분석함수 : 데이터그룹을 기반으로 앞뒤 행을 계산하거나 그룹에 대한 누적분포나 상대 순위를 계산할 때 사용한다.
-- 집계함수와 달리 분석함수는 그룹마다 여러 행을 반환 할 수 있어서 활용도가 높다.
-- lag() : 현재 행에서 바로 앞의 행을, lead() : 현재 행에서 바로 뒤의 행을 조회.
-- 정리 : lag(), lead() 함수를 이용하면 전후 데이터 차이값을 자유롭게 연산할때 편리하게 확인 및 사용할 수 있다.
select x.payment_date, lag(x.amount) over(order by x.payment_date asc) as lag_amount, amount, lead(x.amount) over (order by x.payment_date asc) as lead_amount
from (
		select date_format(payment_date, '%y-%m-%d') as payment_date, sum(amount) as amount
        from payment
        group by date_format(payment_date, '%y-%m-%d')
) as x
order by x.payment_date;

select x.payment_date, lag(x.amount, 2) over(order by x.payment_date asc) as lag_amount, amount, lead(x.amount, 2) over (order by x.payment_date asc) as lead_amount
from (
		select date_format(payment_date, '%y-%m-%d') as payment_date, sum(amount) as amount
        from payment
        group by date_format(payment_date, '%y-%m-%d')
) as x
order by x.payment_date;

-- 누적분포를 계산함수 cum_dist() : 그룹내에서 누적분포를 계산하는 함수(그룹에서 데이터값이 포함되는 위치의 누적분포를 계산한다.)
-- 범위는 0초과에서 1이하의 범위값을 반환한다. 같은 값은 항상 같은 누적분포값으로 계산한다.
-- null값은 최하위값으로 처리한다.(가장 낮은 값)
select x.customer_id, x.amount, cume_dist() over(order by x.amount desc)
from (
	select customer_id, sum(amount) as amount from payment group by customer_id
) as x
order by x.amount desc;

-- 상대 순위를 계산하는 함수 percent_rank : 지정한 그룹 또는 쿼리 결과로 이루어진 그룹 내의 상대 순위를 계산할 때 사용하는 함수.
-- cume_dist()와 percent_rank()의 차이는 분포순위를 구한다는 것임.(cume_dist()는 누적분포를 나타내는겨)
select x.customer_id, x.amount, percent_rank() over(order by x.amount desc)
from (
	select customer_id, sum(amount) as amount from payment group by customer_id
) as x
order by x.amount desc;


