-- A.1 데이터 검색 : SELECT
-- [문제 0] 사원정보(EMPLOYEE) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력 하시오.
-- 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
select e1.employee_id, concat(e1.first_name, e1.last_name) as "Name", e1.salary, j.job_title, j.job_id, e1.hire_date, e1.manager_id
from employees e1, jobs j, employees e2
where e1.job_id = j.job_id and e1.manager_id = e2.employee_id;

-- [문제 1] 사원정보(EMPLOYEES) 테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary,
-- 연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary,
-- 급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오
select concat(first_name, last_name) as Name, job_id as Job, salary as Salary, salary + 100 as "Increased Ann_Salary", (salary + 100) * 12 as Increased_Salary
from employees;

-- [문제 2] 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고,
-- 1 Year Salary라는 별칭을 붙여 출력하시오
select concat(last_name, " : 1 Year Salary = $", salary * 12) as "1 Year Salary"
from employees;

-- [문제 3] 부서별로 담당하는 업무를 한 번씩만 출력하시오
select distinct department_id, job_id
from employees
order by department_id;