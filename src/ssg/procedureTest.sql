use bookstore;
DELIMITER $$
create procedure userProc()
begin
	select * from usertbl;
end $$
DELIMITER ;
call userProc();

DELIMITER $$
create procedure userProc1(IN userName varchar(10))
begin
	select * from usertbl where name = userName;
end $$
DELIMITER ;
call userProc1('조용필');

-- userProc2를 생성하세요. (조건 : 1970년 이후에 태어나고 키가 178 이상인 고객리스트 출력)
DELIMITER $$
create procedure userProc2(in birth1 int, in height1 smallint)
begin
	select * from usertbl where birthYear >= birth1 and height >= height1;
end $$
DELIMITER ;
drop procedure userProc2;
call userProc2(1970, 178);

DELIMITER $$
create procedure userProc3(in txtValue char(10), out outValue int)
begin
	insert into testTbl values(null, txtValue);
    select max(id) into outValue from testTbl;
end $$
DELIMITER ;

create table testTbl(id int auto_increment primary key, tet char(10));
call userProc3('테스트2', @myValue);
select concat('현재 입력된 ID 값 ==>', @myValue);

create table gugudan(txt varchar(100));
DElIMITER $$
create procedure guguProc()
begin
	declare str varchar(100);
    declare i int;
    declare k int;
    set i = 2;
	while(i < 10) do
		set str = '';
		set k = 1;
		while(k < 10) do
			set str = concat(str, ' ', i, ' * ', k, ' = ', i * k);
			set k = k + 1;
		end while;
		set i = i + 1;
		insert into gugudan values(str);
    end while;
end $$
DELIMITER ;
call guguProc();
select * from gugudan;
drop procedure guguproc;

-- 저장된 프로시저의 이름과 내용 확인 : information_schema 데이터베이스 routines 테이블 조회
select * from information_schema.routines where routine_schema = 'bookstore' and routine_type = 'PROCEDURE';

-- 저장된 프로시저의 파라미터의 내용 확인 : information_schema의 parameters 테이블 조회
select * from information_schema.parameters where specific_name = 'userProc3';

show create procedure bookstore.userProc3;

-- 프로시저에 내가 원하는 테이블이름을 전달하여 조회해보기(동적 쿼리 만들기)

DELIMITER $$
create procedure nameTableProc(in tblName varchar(30))
begin
	set @sqlQuery = concat('select * from ', tblName);
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
DELIMITER ;
drop procedure nameTableProc;
call nameTableProc('book');
call nameTableProc('buytbl');
call nameTableProc('orders');

-- 점수를 전달 받아 90점 이상이면 A, 80점 이상이면  B, 70점 이상이면 C, 60점 이상이면 D, 나머지는 F로 처리하는 프로시저를 작성하라.
-- 프로시저명 : GradeProc() / 최종출력 : 당신의 학접은 ====> A 입니다.
DELIMITER $$
create procedure GradeProc1(in jumsu int)
begin
	declare point int;
    declare credit char(1);
    set point = jumsu;

    case
		when point >= 90 then
			set credit = 'A';
        when point >= 80 then
			set credit = 'B';
        when point >= 70 then
			set credit = 'C';
        when point >= 60 then
			set credit = 'D';
        else
			set credit = 'F';
	end case;
    select concat('당신의 학점은 ===>', credit, '입니다.');
end $$
DELIMITER ;
call GradeProc1(85);


DELIMITER $$
create procedure GradeProc2(in jumsu int, out outComment varchar(50))
begin
	declare point int;
    declare credit char(1);
    set point = jumsu;

    case
		when point >= 90 then
			set credit = 'A';
        when point >= 80 then
			set credit = 'B';
        when point >= 70 then
			set credit = 'C';
        when point >= 60 then
			set credit = 'D';
        else
			set credit = 'F';
	end case;
    select concat('당신의 학점은 ===>', credit, '입니다.') into outComment;
end $$
DELIMITER ;
call GradeProc2(85, @getComment);
select @getComment;

-- 문제1. bookstore.buytbl 구매액(price*amount)이 1500원 이상인 고객은 '최우수 고객'
-- 1000원 이상인 고색은 '우수 고객', 1원 이상인 고객은 '일반 고객'으로 출력하세요.
-- 전혀 구매 실적이 없는 '유령 고객'으로 출력해주세요.
-- 정렬조건 : 구매액이 높은 순으로 정렬해주세요.
delimiter $$
create procedure CustomerGradeProc1()
begin
	select B.userId, U.name, sum(price*amount) as '총구매액',
	case
		when (sum(price*amount) >= 1500) then '최우수고객'
        when (sum(price*amount) >= 1000) then '우수고객'
        when (sum(price*amount) >= 1) then '일반고객'
        else '유령고객'
	end as '고객등급'
	from buytbl B right outer join userTbl U on B.userId = U.userId
	group by B.userId, U.name
	order by sum(price*amount) desc;
end $$
delimiter ;
call CustomerGradeProc1;

-- 1부터 100까지의 합을 출력하는 WhileProc1을 작성하시오.
delimiter $$
create procedure WhileProc1()
begin
	declare i int;
    declare sum int;
    set i = 1;
    set sum = 0;
    while (i <= 100) do
		set sum = sum + i;
        set i = i + 1;
	end while;
    select sum;
end $$
delimiter ;
call WhileProc1();

-- 1부터 100까지의 합계에서 7읠 배수를 제외한 값을 출력하되, 누적값이 10000이 넘어가면 while문을 종료할 수 있게끔 하는 출력하는 WhileProc1을 작성하시오.
delimiter $$
create procedure WhileProc2()
begin
	declare i int;
    declare sum int;
    set i = 1;
    set sum = 0;
    myWhile : while (i <= 100) do
			  if(i%7=0) then
					set i = i + 1;
                    iterate myWhile; -- continue와 동일한 역할.
			  end if;

			  set sum = sum + i;

              if(sum > 10000) then
				  leave myWhile;
			  end if;

			  set i = i + 1;
			  end while;
			  select sum;
end $$
delimiter ;
drop procedure WhileProc2;
call WhileProc2();

-- MySQL 사용자 오류처리
-- declare 액션 handler for 오류조건 처리할 문장;
delimiter $$
create procedure errProc()
begin
	declare continue handler for 1146 select '테이블이 존해하지 않습니다.' as '메세지';
    select * from noTable;
end $$
delimiter ;
drop procedure errProc;
call errProc();

delimiter $$
create procedure errProc3()
begin
	declare continue handler for sqlexception
    begin
		show errors;
        select '오류가 발생하여 작업을 취소시켰습니다.' as '메시지';
        rollback;
    end;
		insert into usertbl values('LSG', '이승기', 1988, '서울', null, null, 170, current_date());
end $$
delimiter ;
call errProc3;