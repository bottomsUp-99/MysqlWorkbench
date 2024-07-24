-- 1. 데이터 검색 (SELECT) : 테이블에 저장된 데이터를 추출 명령어
--    표시하고자 하는 열(column)만 선택하여 출력할 수 있다.(선택 범위 지정 가능)

-- Q. 사원정보에서 사원번호, 이름, 급여, 입사일, 상사의 사원번호를 출력하세요.(이름은 성과 이름을 연결하여 Name이라는 병칠으로 출력)
select employee_id, concat(first_name, last_name) as "Name", salary, hire_date, manager_id
from employees;

-- Q. 사원정보에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 연봉에 100달러의 보너스를 추가하여 계산한 값을 Increased_Salary로 별칭하여 출력하세요.
select concat(first_name, last_name) as Name, job_id as Job, salary as Salary, (salary + 100) * 12 as Increased_Salary
from employees;

-- Q. 부서별로 담당하는 업무를 출력하시오
select distinct department_id, job_id
from employees;
-- order by department_id;

-- Q. 사원정보에서 모든 사원의 이름(last_name)과 연봉을 "이름 : 1 Year Salary = $연봉" 형식으로 출력하고 1 Year Salary라는 별칭으로 출력
select concat(last_name, " : 1 Year Salary = $", salary * 12) as "1 Year Salary"
from employees;
-- order by salary desc;

-- Q. HR부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다.
--    사원정보에서 급여 $7000 ~ $10000범위 이외의 사람의 성과 이름(Name) 별칭, 급여를 급여가 작은 순으로 출력하세요.
select concat(last_name, first_name) as Name, salary
from employees
where salary not between 7000 and 10000
order by salary asc;

select concat(last_name, first_name) as Name, salary
from employees
where salary <= 7000 or salary >= 10000
order by salary asc;

select concat(last_name, first_name) as Name, salary
from employees
where salary >= 10000
order by salary asc;

select concat(last_name, first_name) as Name, salary
from employees
where salary <= 7000
order by salary asc;

select e1.last_name, e2.last_name
from employees e1, employees e2
where e1.employee_id = e2.manager_id and e1.last_name = 'Higgins';