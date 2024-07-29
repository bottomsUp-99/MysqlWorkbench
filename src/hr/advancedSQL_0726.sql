-- 출력하는 개수를 제한하는 LIMIT
select employee_id, hire_date from employees order by hire_date limit 5;
select employee_id, hire_date from employees order by hire_date limit 1, 6;
select employee_id, hire_date from employees order by hire_date limit 0, 6;

-- 테이블을 복제하는 서브쿼리(select)
-- job_grades 테이블을 job_grades1 이라고 복제하고 job_grades 테이블과 동일한 제약조건을 생성하세요.
create table job_grades1(select * from job_grades);
desc job_grades1;
alter table job_grades1 add constraint pk_job_grades1 primary key (grade_level);

-- insert 문 기본 : 테이블에 데이터를 삽입하는 명령어
-- insert [into] 테이블며[열1 ,열2 ,열3....] values(값1, 값 2.....)alter;
-- 테이블 이름 다음에 나오는 열은 생략가능.
-- 생략할 경우 values 다음에 오는 값들의 순서 및 개수가 테이블이 정의된 열 순서와 개수와 동일해야 함.
create table testtbl ( ind int, username char(5), age int);
insert testtbl values(1, '김마리아', 30);
insert testtbl values(1, '박마리아', 30);
insert testtbl values('박마리아', 1, 30);
insert testtbl (ind, username) values (2, '김진영');
insert testtbl (ind, username) values (3, '박해란');
commit;
select * from testtbl;
rollback;
insert testtbl (ind, username) values (4, '김해란');
select @@autocommit;
set autocommit = 0;
insert testtbl (ind, username) values (5, '고해란');

-- 자동으로 증가하는 auto-increment(insert 할 때는 해당 열이 없다고 생각하고 입력하면 된다.)
-- 자동으로 1부터 증가하는 값을 입력해주는 역할
-- PK, UNIQUE 제약 조건을 지정해야 줘야 한다.
-- 데이터형은 숫자 형식만 사용가능하다.
create table testtbl2 (id int auto_increment primary key, username char(5));
insert testtbl2 values(null, '김유진');
insert testtbl2 values(null, '박유진');
insert testtbl2 values(null, '서유진');
select * from testtbl2;

-- auto_increment를 이용하여 입력된 숫자가 어디까지 증가되었는지 궁금하다면?
select last_insert_id();

-- auto_increment 시작값을 셋팅 가능함.
alter table testtbl2 auto_increment = 100;
insert testtbl2 values(null, '고유진');
select * from testtbl2;
commit;
insert testtbl2 values(null, '유진');
insert testtbl2 values(null, '방유진');

alter table testtbl2 auto_increment = 1000;
set @@auto_increment_increment = 3;
insert testtbl2 values(null, '유진');
insert testtbl2 values(null, '구진');
rollback;

-- 대량의 심플데이터를 생성(입력, insert)
-- insert into 테이블이름(열1, 열2 ....) select문;
select count(employee_id) from employees;

create table testtbl3 (id int, fname varchar(50), lname varchar(50));

insert into testtbl3
	select employee_id, first_name, last_name
    from employees;
select * from testtbl3;
alter table testtbl3 add constraint pk_testtbl3_id primary key(id);

create table testtbl5
	(select employee_id, first_name, last_name from employees);
alter table testtbl5 add constraint pk_testtbl5_id primary key(id);

-- 데이터 수정(update) : 기존의 입력되어 있는 값을 변경하기 위해서 사용하는 명령어
-- [형식] : UPDATE 테이블이름 SET 열이름1 = 값1, 열이름2 = 값2....[WHERE 조건]; WHERE 테이블의 전체 행에 대해 변경이 이루어진다.
select * from testtbl5;
update testtbl5 set last_name = '손열음' where employee_id = 100;

set sql_safe_updates = 0;
rollback;

-- DELETE 데이터의 삭제 명령어(적용단위 : 행) 행단위로 삭제
-- [문법] DELETE FROM 테이블 이름 WHERE 조건; -- WHERE 문이 생략되면 전체 데이터 삭제
select * from testtbl5;
delete from testtbl5 where employee_id = 110;

-- employees 테이블에서 employee_id, first_name, last_name 가져다가 5번 insert하시오.
insert into testtbl5 select employee_id, first_name, last_name from employees;
select count(employee_id) from testtbl5;

delete from testtbl5 where last_name like 'Chen' limit 5;
select * from testtbl5 where last_name like 'Chen';