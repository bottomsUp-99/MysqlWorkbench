-- create user ssgdoctor@localhost identified by 'ssg';
-- create database hospital;
-- grant all privilegs on hospital.* to ssgdoctor@localhost with grant option;
-- flush privilegs;

USE hospital;

-- 의사 테이블
CREATE TABLE doctors
(
    doc_id   INT UNSIGNED  AUTO_INCREMENT COMMENT '의사 ID',
    major_treat VARCHAR(10)  NOT NULL COMMENT '담당 진료 과목',
    doc_name        VARCHAR(20)  NOT NULL COMMENT '의사 이름',
    doc_gender      CHAR(1)      NOT NULL COMMENT '의사 성별 (M, F, N)',
    doc_phone       VARCHAR(15)  NOT NULL COMMENT '의사 전화번호',
    email       VARCHAR(50)  NOT NULL UNIQUE COMMENT '의사 이메일',
    position    VARCHAR(20)  NOT NULL COMMENT '의사 직급',

);

ALTER TABLE doctors
          ADD CONSTRAINT doc_id_pk PRIMARY KEY(doc_id);

-- 간호사 테이블
CREATE TABLE Nurses
(
    nurs_id      INT UNSIGNED    AUTO_INCREMENT COMMENT '간호사 ID',
    major_job VARCHAR(25)  NOT NULL COMMENT '담당 업무',
    nur_name          VARCHAR(20)  NOT NULL COMMENT '간호사 이름',
    nur_gender        CHAR(1)      NOT NULL COMMENT '간호사 성별 (M, F, N)',
    nur_phone         VARCHAR(15)  NOT NULL COMMENT '간호사 전화번호',
    nur_email         VARCHAR(50)  NOT NULL UNIQUE COMMENT '간호사 이메일',
    nur_position      VARCHAR(20)  NOT NULL COMMENT '간호사 직급',

);
ALTER TABLE Nurses
          ADD CONSTRAINT nur_id_pk PRIMARY KEY(nur_id);

-- 환자 테이블
CREATE TABLE Patients
(
    pat_id INT UNSIGNED  AUTO_INCREMENT COMMENT '환자 ID',
    nur_id   INT UNSIGNED NOT NULL COMMENT '간호사 ID',
    doc_id  INT UNSIGNED NOT NULL COMMENT '의사 ID',
    pat_name       VARCHAR(20)  NOT NULL COMMENT '환자 이름',
    pat_gender     CHAR(1)      NOT NULL COMMENT '환자 성별 (M, F, N)',
    pat_resident   VARCHAR(14)  NOT NULL UNIQUE COMMENT '환자 주민등록번호',
    pat_address    VARCHAR(100)  NOT NULL COMMENT '환자 주소',
    pat_phone      VARCHAR(15)  NOT NULL COMMENT '환자 전화번호',
    pat_email      VARCHAR(50) NOT NULL UNIQUE COMMENT '환자 이메일',
    pat_job        VARCHAR(20) COMMENT '환자 직업',
   );


ALTER TABLE Patients
          ADD CONSTRAINT pat_id_pk PRIMARY KEY(pat_id);

ALTER TABLE Patients
          ADD (CONSTRAINT R_2 FOREIGN KEY (doc_id) REFERENCES Doctors(doc_id));

ALTER TABLE Patients
          ADD (CONSTRAINT R_3 FOREIGN KEY (nur_id) REFERENCES Nurses(nur_id);




-- 진료 테이블
CREATE TABLE Treatments
(
    treat_id     INT UNSIGNED AUTO_INCREMENT COMMENT '진료 ID',
    pat_id       INT UNSIGNED NOT NULL COMMENT '환자 ID',
    doc_id      INT UNSIGNED NOT NULL COMMENT '의사 ID',
    treat_contents       VARCHAR(1000) NOT NULL COMMENT '진료 내용',
    treat_date            DATE  NOT NULL COMMENT '진료 날짜'
   );


ALTER TABLE Treatments
          ADD CONSTRAINT treat_id_pk PRIMARY KEY(treat_id,pat_id,doc_id);

ALTER TABLE Treatments
          ADD (CONSTRAINT R_5 FOREIGN KEY (pat_id) REFERENCES Patients(pat_id);

ALTER TABLE Treatments
          ADD (CONSTRAINT R_6 FOREIGN KEY (doc_id) REFERENCES Doctors(doc_id);




-- 차트 테이블
CREATE TABLE Charts
(
    chart_id     INT UNSIGNED  AUTO_INCREMENT COMMENT '차트 ID',
    treat_id      INT UNSIGNED NOT NULL COMMENT '진료 ID',
    doc_id       INT UNSIGNED NOT NULL COMMENT '의사 ID',
    pat_id       INT UNSIGNED NOT NULL COMMENT '환자 ID',
    nur_id       INT UNSIGNED NOT NULL COMMENT '간호사 ID',
    chart_contents     VARCHAR(1000) NOT NULL COMMENT '차트 내용'
 );


ALTER TABLE Charts
          ADD CONSTRAINT chart_treat_doc_pat_id_pk PRIMARY KEY(chart_id,treat_id,pat_id,doc_id);

ALTER TABLE Treatments
          ADD (CONSTRAINT R_4 FOREIGN KEY (nur_id) REFERENCES Nurses(nur_id);

ALTER TABLE Treatments
          ADD (CONSTRAINT R_7 FOREIGN KEY (treat_id,pat_id,doc_id) REFERENCES Treatments(tread_id,pat_id,doc_id);





