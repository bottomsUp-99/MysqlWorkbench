-- 피봇(pivot) : 한 열에 포함된 여러값을 출력하고, 여러 열로 변환하여 테이블 반환 식을 회전하고 필요하면 집계까지 수행하는 과정을 의미한다.
create table pivotTest(
	uName char(5), -- 판매자(김진수, 윤민수)
    season char(2), -- 시즌
    amount int -- 수량
);

insert into pivotTest values('김진수', '겨울', 10), ('윤민수', '여름', 15), ('김진수', '가을', 25), ('김진수', '봄', 3), ('김진수', '봄', 37), ('윤민수', '겨울', 40), ('윤민수', '여름', 64), ('김진수', '여름', 14), ('김진수', '겨울', 22);
commit;
truncate pivotTest;

select * from pivotTest;
-- 판매자 별로 판매 계절, 판매 수량 : sum(), if() 함수 활용해서 피벗테이블을 생성
select uName,
	sum(if(season = '봄', amount, 0)) as 봄,
    sum(if(season = '여름', amount, 0)) as 여름,
    sum(if(season = '가을', amount, 0)) as 가을,
    sum(if(season = '겨울', amount, 0)) as 겨울,
    sum(amount) as 합계
from pivotTest
group by uName;

-- 계절 별로 그룹핑 해서 판매자의 판매 수량을 집계하여 출력하는 피벗테이블을 생성
select season, sum(if(uName = '김진수', amount, 0)) '김진수 판매량', sum(if(uName = '윤민수', amount, 0)) '윤민수 판매량'
from pivotTest
group by season;

-- JSON 데이터
-- 웹과 모바일 응용프로그램에서는 데이터를 교환하기 위해 개발형 표준 포맷인 JSON을 활용한다.
-- JSON은 속성(key)와 값(value)으로 쌍으로 구성되어 있다. 독립적인 데이터 포맷이다. 포맷이 단순하고 공개되어 있어 여러 프로그래밍 언어에서 채택하고 있다.
/*
{
	"userName" : "김삼순",
    "birthYear" : 2002,
    "address" : "서울 성동구 북가좌동",
    "mobile" : "01012348989"
}
*/
select * from usertbl;
select Json_object('name', name, 'height', height) as '키 180 이상 회원의 정보'
from usertbl
where height >= 180;

-- JSON 을 위한 MYSQL은 다양한 내장함수를 제공한다.
set @json = '{
	"usertbl1" : [
		{"name": "임재범", "height": 182},
        {"name": "이승기", "height": 182},
        {"name": "성시경", "height": 186}
    ]
}';

select json_valid(@json) as json_valid; -- 문자열이 json 형식을 만족하면 1, 만족하지 않으면 0 반환
select json_search(@json, 'all', '성시경') as json_search;
select json_insert (@json, '$.usertbl1[0].mDate', '2024-07-29') as json_insert;
select json_replace (@json, '$.usertbl1[0].name', '임영웅') as json_replace;
select json_remove (@json, '$.usertbl1[1]') as json_remove;

-- 제어흐름 함수, 문자열 함수, 수학함수, 날짜/시간 함수, 전체 텍스트 검색 함수, 형변환 함수
-- 1. 제어흐름함수 -> if, ifnull, nullif, case~when~else~end
-- 1-1. if(수식) -> 수식이 참인지 거짓인지 결과에 따라 분기
select if(100 > 200, '참', '거짓');

-- 1.2 ifnull(수식1, 수식2) -> 수식1이 null이면 수식1이 반환되고, 수식1이 null이면 수식2 반환.
select ifnull(null, '널이네'), ifnull(100, '널이군요');

-- 1.3 nullif(수식1, 수식2) -> 수식1과 수식2가 같으면 null을 반환하고, 다르면 수식1 반환한다.
select nullif(100, 100), nullif(200, 100);

-- 1.4 cae~when~else~end 함수는 아니지만 연산자(Operator)로 분류된다. 다중분기 + 내장함수
select case 5
	when 1 then '일'
	when 3 then '삼'
	when 5 then '오'
	else '모름'
end as 'case test';


-- 2. 문자열 함수 활용도 갑!
-- 2.1 ASCII(아스키코드), char(숫자)
select ascii('A'), char(65);

-- mysql은 기본 utf-8 코드를 사용하기 때문에 영문자는 한글자당 1byte, 한글은 한글자당 3byte 할당한다.
-- bit_length() -> bit 크기 또는 문자 크기 전환
-- char_length() -> 문자의 개수 반환
-- length() -> 할당된 byte 수 반환
select bit_length('abc'), char_length('abc'), length('abc'); -- 24	3	3
select bit_length('가나다'), char_length('가나다'), length('가나다'); -- 72	3	9

-- concat(문자열1, 문자열2...), concat_ws(구분자, 문자열 1, 문자열 2) -> 구분자와 함께 문자열을 이어준다.
select concat_ws('-', '2024', '해커톤 우승자', '래리 킴');
select elt(2, 'one', 'two', 'three'), field('둘', 'one', '둘', 'three'), find_in_set('둘', 'one, two, 둘'), instr('하나둘셋', '둘'), locate('둘', '하나둘셋');

-- format(숫자, 소숫점 자릿수) : 숫자를 소수점 아래 자릿수까지 표현, 1000단위로 콤마(,)로 표시
select format(123456.123456, 4);

-- 10진수를 2진수, 16진수, 8진수로 변환
select bin(31), hex(31), oct(31);

-- insert(기준문자열, 위치, 길이, 삽입할 문자열) 기준 문자열의 위치부터 길이만큼 지우고 삽입할 문자열 끼워넣기
select insert('abcdefghijk', 3, 4,'#');

-- 왼쪽 오른쪽 문자열의 길이만큼 반환한다.
select left('abcdefghi', 3), right('abcdefghi', 3);

-- upper(문자열), lower(문자열)
select lower('ABC'), upper('def');
select lcase('ABC'), ucase('def');

-- lpad(문자열, 채울 문자열), rpad(문자열, 채울 문자열)
select lpad('SSG', 5, '&');

-- trim() 양쪽 공백 제거
select trim('   신세계 자바 프로그래밍   ');

-- substring(문자열, 시작위치, 길이) substring(문자열 from 시작위치 for 길이)
select substring('자바프로그래밍', 3, 2);

-- 날짜 및 시간 함수
-- 1. adddate(날짜, 차이), subsate(날짜, 차이)
select adddate('2025-01-01', interval 31 day);
select subdate('2025-01-01', interval 31 day);
select subdate('2025-01-01', interval 31 month);
select addtime('2025-01-01 23:59:59', '1:1:1');
select subtime('2025-01-01 23:59:59', '1:1:1');

-- 2. curdate() : 현재 연-월-일 / curtime() : 현재 시:분:초 now(),sysdate(),localtime(), localstamp() -> 연-월-일-시:분:초
-- 3. year(날짜), month(날짜), day(날짜), hour(시간), minute(시간), second(시간), microsecond(시간)
select year(curdate());
select month(curdate());
select day(curdate());
select hour(curtime());
select microsecond(current_time);

select date(now()), time(now());

