use hr;

create table employees
(
    employee_id    int unsigned  not null, -- 사원 번호
    first_name     varchar(20),            -- 성
    last_name      varchar(30)   not null, -- 이름
    email          varchar(25)   not null,
    phone_number   varchar(20),            -- 전화 번호
    hire_date      date          not null, -- 입사일
    job_id         varchar(10)   not null, -- 직무 번호
    salary         decimal(8, 2) not null, -- 월급
    commission_pct decimal(2, 2),          -- 커미션 (수당)
    manager_id     int unsigned,
    department_id  integer unsigned,       -- 부서 아이디
    primary key (employee_id)
);

create table regions(
	region_id int unsigned not null,
    region_name varchar(25),
    primary key (region_id)
);

create table countries(
	country_id char(2) not null,
    country_name varchar(40),
    region_id int unsigned not null,
    primary key (country_id)
);

create table locations(
	location_id int unsigned not null auto_increment,
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(30),
    country_id char(2) not null,
    primary key (location_id)
);

create table departments(
	department_id int unsigned not null,
    department_name varchar(30) not null,
    manager_id int unsigned,
    location_id int unsigned,
    primary key(department_id)
);

create table jobs(
	job_id varchar(20) not null,
    job_title varchar(40) not null,
    min_salary decimal(8,0) unsigned,
    max_salary decimal(8,0) unsigned,
    primary key(job_id)
);

create table job_history(
    employee_id int unsigned not null,
    start_date date not null,
    end_date date not null,
   job_id varchar(20) not null,
   department_id int unsigned not null
);

-- drop table job_history;
commit;

alter table job_history add unique index(
	employee_id, start_date );	-- 사원 이력 관리

-- fk 추가 작업 alter 명령어
alter table countries add foreign key (region_id) references  regions (region_id);
alter table locations add foreign key (country_id) references countries(country_id);
alter table departments add foreign key (location_id) references locations(location_id);
alter table employees add foreign key (department_id) references departments(department_id);
alter table departments add foreign key (manager_id) references employees(employee_id);
alter table employees add foreign key (job_id) references jobs(job_id);
alter table employees add foreign key (manager_id) references employees(employee_id);
alter table job_history add foreign key(employee_id) references employees(employee_id);
alter table job_history add foreign key(job_id) references jobs(job_id);
alter table job_history add foreign key(department_id) references departments(department_id);
commit;

SET FOREIGN_KEY_CHECKS = 0;
SET @tables = NULL;
SELECT GROUP_CONCAT(table_schema, '.', table_name) INTO @tables
    FROM information_schema.tables
    WHERE table_schema = 'hr'; -- specify DB name here.
SET @tables = CONCAT('DROP TABLE ', @tables);
PREPARE stmt FROM @tables;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
commit;