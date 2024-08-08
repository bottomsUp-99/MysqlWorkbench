create database testDB;
use testDB;
drop table testTbl;
drop trigger testTrg;
create table testTbl(id int, txt varchar(10));
insert into testTbl values (1, '레드벨벳');
insert into testTbl values (2, '잇지');
insert into testTbl values (3, '블랙핑크');
commit;

delimiter $$
create trigger testTrg
	after delete -- before도 가능함.
    on testTbl -- testTbl 테이블에 testTrg를 붙인다.
    for each row -- 각 행마다 적용시키겠다.
begin
	set @msg = '가구 그룹이 삭제됨';
end $$

delimiter ;

set @msg = '';
insert into testTbl values (4, 'BTS');
select @msg;
delete from testTbl where id = 1;














