use moviedb;
create table movietbl(
	movie_id int,
	movie_title varchar(30),
	movie_director varchar(20),
	movie_star varchar(20),
	movie_script longtext,
	movie_film longblob
) default charset = utf8mb4;

ALTER TABLE movietbl MODIFY movie_script TEXT CHARACTER SET utf8mb4;

insert into movietbl values(1, '쉰들러리스트', '스티븐 스필버그', '리암 니슨', load_file('/Users/zoohwan_99/Desktop/movies/Schindler_utf8.txt'), load_file('/Users/zoohwan_99/Desktop/movies/Schindler.mp4'));
insert into movietbl values(2, '쇼생크탈출', '프랭크 다라본트', '팀 로빈스', load_file('/Users/zoohwan_99/Desktop/movies/Shawshank_utf8.txt'), load_file('/Users/zoohwan_99/Desktop/movies/Shawshank.mp4'));
insert into movietbl values(3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스', load_file('/Users/zoohwan_99/Desktop/movies/Mohican_utf8.txt'), load_file('/Users/zoohwan_99/Desktop/movies/Mohican.mp4'));
truncate movietbl;
drop table movietbl;
select * from movietbl;

-- movie_script와 movie_film 입력되지 않은 이유 알아보기
-- 1. 최대 패킷 크기(최대 파일 크기) 시스템 변수 확인 : max_allowed_packet 값 조회
show variables like 'max_allowed_packet'; -- 67108864 => 67mega
-- 2. 파일을 업로드/다운로드 할 폴더 경로를 별도로 허용해주어야한다. (MY-SQL Server) 'secure_file_priv' 조회
show variables like 'secure_file_priv';

-- 다운로드 하기
select movie_script from movietbl where movie_id = 1;
SELECT movie_script FROM movietbl WHERE movie_id = 1 INTO OUTFILE 'C:/study/database/movies/Schindler_out.txt' LINES TERMINATED BY '\\n';    -- 줄바꿈 문자도 그대로 다운받아서 저장한다. 옵션