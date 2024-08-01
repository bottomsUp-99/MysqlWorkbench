DROP DATABASE IF EXISTS 정규화;

CREATE DATABASE 정규화 DEFAULT CHARSET  utf8mb4 COLLATE  utf8mb4_general_ci;

USE 정규화;

CREATE TABLE 동아리가입학생학과(
동아리번호 CHAR(2),
동아리명 varchar(50) not null,
동아리개설일 date not null,
학번 int,
이름 varchar(30) not null,
동아리가입일 date not null,
학과번호 CHAR(2),
학과명 varchar(30),
primary key(동아리번호,학번)
 ) DEFAULT CHARSET=utf8mb4;


 insert into 동아리가입학생학과 values('c1','지구한바퀴여행','2000-02-01',231001,'문지영','2023-04-01','D1','화학공학과');
 insert into 동아리가입학생학과 values('c1','지구한바퀴여행','2000-02-01',231002,'배경민','2023-04-03','D4','경영학과');
 insert into 동아리가입학생학과 values('c2','클래식연주동아리','2010-06-05',232001,'김명희','2023-03-22','D2','통계학과');
 insert into 동아리가입학생학과 values('c3','워너비골퍼','2020-03-01',232002,'천은정','2023-03-07','D2','통계학과');
 insert into 동아리가입학생학과 values('c3','워너비골퍼','2020-03-01',231002,'배경민','2023-04-02','D2','경영학과');
 insert into 동아리가입학생학과 values('c4','쉘위댄스','2021-07-01',231001,'문지영','2023-04-30','D1','화학공학과');
 insert into 동아리가입학생학과 values('c4','쉘위댄스','2021-07-01',233001,'이현경','2023-03-27','D3','역사학과');

select * from  동아리가입학생학과;


create table 동아리(
	동아리번호 CHAR(2) primary key,
	동아리명 varchar(50) not null,
	동아리개설일 date not null
);

create table 동아리가입학생학과2(
	학번 int,
	이름 varchar(30) not null,
	동아리가입일 date not null,
	학과번호 CHAR(2),
	학과명 varchar(30),
	동아리번호 CHAR(2)
);

-- 동아리 테이블과 동아리가입학생학과2 테이블의 관계를 맺어주세요. 동아리 번호는 동아리 테이블과 FK 이며, 동아리가입학생학과2 테이블의 주키는 학번과 동아리 번호입니다.
alter table 동아리가입학생학과2 add constraint pk_동아리가입학생학과2 primary key (학번, 동아리번호);
alter table 동아리가입학생학과2 add constraint fk_동아리가입학생학과2 foreign key (동아리번호) references 동아리(동아리번호);
alter table 동아리가입학생학과2 drop constraint fk_동아리가입학생학과2;

-- 제약 조건 적용 확인
select * from information_schema.table_constraints where table_name = '동아리가입학생학과2';

-- 동아리 테이블에 데이터를 서브 쿼리를 이용하여 삽입해 주세요.
insert into 동아리(동아리번호, 동아리명, 동아리개설일) select 동아리번호, 동아리명, 동아리개설일 from 동아리가입학생학과;
insert into 동아리 values('c1','지구한바퀴여행','2000-02-01');
insert into 동아리 values('c2','클래식연주동아리','2010-06-05');
insert into 동아리 values('c3','워너비골퍼','2020-03-01');
insert into 동아리 values('c4','쉘위댄스','2021-07-01');

-- 동아리가입학생학과2에 서브 쿼리를 이용하여 삽입해주세요.
insert into 동아리가입학생학과2 values(231001,'문지영','2023-04-01','D1','화학공학과', 'c1');
insert into 동아리가입학생학과2 values(231002,'배경민','2023-04-03','D4','경영학과', 'c1');
insert into 동아리가입학생학과2 values(232001,'김명희','2023-03-22','D2','통계학과', 'c2');
insert into 동아리가입학생학과2 values(232002,'천은정','2023-03-07','D2','통계학과', 'c3');
insert into 동아리가입학생학과2 values(231002,'배경민','2023-04-02','D2','경영학과', 'c3');
insert into 동아리가입학생학과2 values(231001,'문지영','2023-04-30','D1','화학공학과', 'c4');
insert into 동아리가입학생학과2 values(233001,'이현경','2023-03-27','D3','역사학과', 'c4');

create table 학생학(
학번 int primary key,
이름 varchar(30) not null,
학과번호 CHAR(2),
학과명 varchar(30)
);

create table 동아리가입(
동아리번호 char(2),
동아리가입일 date not null,
학번 int
);

create table 학과(
학과번호 CHAR(2),
학과명 varchar(30)
);

create table 학생(
학번 int primary key,
이름 varchar(30) not null,
학과번호 CHAR(2)
);

alter table 동아리가입 add constraint fk_동아리가입_학번 foreign key (학번) references 학생(학번);
alter table 동아리가입 add constraint fk_동아리가입_동아리번호 foreign key (동아리번호) references 동아리(동아리번호);
alter table 동아리가입 add constraint pk_동아리가입_학번동아리번호 primary key (학번, 동아리번호);
alter table 학과 add constraint pk_학과_학과번호학과번호 primary key (학과번호, 학과명);
alter table 학생 add constraint fk_학생_학과번호 foreign key (학과번호) references 학과(학과번호);

commit;