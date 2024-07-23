use CARRENT;

create table cmpcarcompany(
	cmpcarcompany_id int not null comment '캠핑카대여회사ID',
	cmpcarcompany_name varchar(20) not null comment '회사명',
	cmpcarcompany_address varchar(40) not null comment '주소',
	cmpcarcompany_phonenum char(13) not null comment '전화번호',
	cmpcarcompany_managername varchar(10) not null comment '담당자이름',
	cmpcarcompany_manageremail varchar(30) not null unique comment '담당자이메일'
);

alter table cmpcarcompany add constraint cmpcarcompany_id_pk primary key(cmpcarcompany_id);

CREATE TABLE cmpcar (
	cmpcar_id int not null COMMENT '캠핑카등록ID',
    cmpcarcompany_id int not null COMMENT '캠핑카대여회사ID',
	cmpcar_name varchar(20) not null COMMENT '캠핑카이름',
	cmpcar_num int not null comment '캠핑카차량번호',
	cmpcar_numofriders int not null comment '캠핑카승차인원',
	cmpcar_image blob not null comment '캠핑카이미지',
	cmpcar_detail varchar(100) comment '캠핑카상세정보',
	cmpcar_price int not null comment '캠핑카대여비용',
	cmpcar_registerdate date not null comment '캠핑카등록일자'
);

alter table cmpcar add constraint cmpcar_id_pk primary key(cmpcar_id, cmpcarcompany_id);
alter table cmpcar add constraint cmpcar_1 foreign key(cmpcarcompany_id) references cmpcarcompany(cmpcarcompany_id);

create table customer(
	customer_license varchar(20) not null comment '운전면허증',
	customer_name varchar(10) not null comment '고객명',
	customer_address varchar(30) not null comment '고객주소',
	customer_phone char(13) not null comment '고객전화번호',
	customer_email varchar(30) not null comment "고객이메일",
	previous_rentaldate date comment '이전캠핑카사용날짜',
	previous_rentalcmpcar varchar(20) comment '이전캠핑카사용종류'
);

alter table customer add constraint customer_license_pk primary key(customer_license);

CREATE TABLE rentalcmpcar (
	rentalcmpcar_no int not null comment '대여번호',
	cmpcar_id int not null COMMENT '캠핑카등록ID',
	customer_license varchar(20) not null comment '운전면허증',
	cmpcarcompany_id int not null comment '캠핑카대여회사ID',
	rental_startdate date not null comment '대여시작일',
	rental_enddate date not null comment '대여기간',
	rental_charge int not null comment '청구요금',
	rental_chargeduedate date not null comment '납입기한',
	other_chargecontent varchar(100) comment '기타청구내역',
	other_chargeprice int comment '기타청구요금'
);

alter table rentalcmpcar add constraint rentalcmpcar_no_pk primary key(rentalcmpcar_no);
alter table rentalcmpcar add constraint rentalcmpcar_1 foreign key(cmpcar_id) references cmpcar(cmpcar_id);
alter table rentalcmpcar add constraint rentalcmpcar_2 foreign key(customer_license) references customer(customer_license);
alter table rentalcmpcar add constraint rentalcmpcar_3 foreign key(cmpcarcompany_id) references cmpcarcompany(cmpcarcompany_id);

create table cmpcarrepairshop (
	cmpcarrepairshop_id int not null comment '캠핑카정비소ID',
	cmpcarrepairshop_name varchar(20) not null comment '정비소명',
	cmpcarrepairshop_address varchar(30) not null comment '정비소주소',
	cmpcarrepairshop_phonenum char(13) not null comment "정비소전화번호",
	cmpcarrepairshop_managername varchar(10) not null comment "담당자이름",
	cmpcarrepairshop_manageremail varchar(30) not null comment '담당자이메일'
);

alter table cmpcarrepairshop add constraint cmpcarrepairshop_id_pk primary key(cmpcarrepairshop_id);

create table cmpcarrepairinfo (
	cmpcarrepairinfo_num int not null comment '정비번호',
	cmpcar_id int not null COMMENT '캠핑카등록ID',
	cmpcarrepairshop_id int not null comment '캠핑카정비소ID',
	cmpcarcompany_id int not null comment '캠핑카대여회사ID',
	customer_license varchar(20) not null comment '고객운전면허증번호',
	cmpcarrepairinfo_detail varchar(100) not null comment '정비내역',
	cmpcarrepairinfo_date date not null comment '수리날짜',
	cmpcarrepairinfo_price int not null comment '수리비용',
	cmpcarrepairinfo_priceduedate date not null comment '납입기한',
	other_cmpcarrepairinfo varchar(100) comment '기타정비내역'
);

alter table cmpcarrepairinfo add constraint cmpcarrepairinfo_num primary key(cmpcarrepairinfo_num);
alter table cmpcarrepairinfo add constraint cmpcarrepairinfo_1 foreign key(cmpcar_id) references cmpcar(cmpcar_id);
alter table cmpcarrepairinfo add constraint cmpcarrepairinfo_2 foreign key(cmpcarrepairshop_id) references cmpcarrepairshop(cmpcarrepairshop_id);
alter table cmpcarrepairinfo add constraint cmpcarrepairinfo_3 foreign key(cmpcarcompany_id) references cmpcarcompany(cmpcarcompany_id);
alter table cmpcarrepairinfo add constraint cmpcarrepairinfo_4 foreign key(customer_license) references customer(customer_license);