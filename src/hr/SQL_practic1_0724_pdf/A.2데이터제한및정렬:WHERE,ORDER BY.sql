-- A.2 데이터 제한 및 정렬 : WHERE, ORDER BY
-- [문제 0] HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다.
-- 사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인
-- 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오(75행).
select concat(last_name, first_name) as Name, salary
from employees
where salary not between 7000 and 10000
order by salary asc;

-- [문제 1] 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오.
-- 이때 머리글은 ‘e and o Name’라고 출력하시오
select emp.employee_id, concat(emp.first_name, emp.last_name)
from employees emp
where emp.last_name like '%a%' or '%o%';

-- [문제 2] 현재 날짜 타입을 날짜 함수를 통해 확인하고, 2006년 05월 20일부터 2007년 05월 20일 사이에
-- 고용된 사원들의 성과 이름(Name으로 별칭), 사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오
select now();
select current_date();

select concat(emp.first_name, emp.last_name) Name, emp.employee_id, emp.hire_date
from employees emp
where hire_date between str_to_date('2006-05-20', '%Y-%m-%d') and str_to_date('2007-05-20', '%Y-%m-%d')
order by hire_date;

-- [문제 3] HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다.
-- 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오.
-- 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
select concat(emp.first_name, emp.last_name) Name, emp.salary, emp.job_id, emp.commission_pct
from employees emp
where emp.commission_pct is not null
order by salary desc, emp.commission_pct desc;