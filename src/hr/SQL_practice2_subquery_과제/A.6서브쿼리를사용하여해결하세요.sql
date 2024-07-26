-- A.6 서브쿼리를 이용하여 해결하세요.
-- [문제 1] HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다.
-- Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오

-- 1. Tucker의 급여 확인하기
select last_name, salary
from employees
where last_name = 'Tucker' or 'tucker';

-- 2.
select concat(e.first_name, ' ', e.last_name), e.job_id, e.salary
from employees e
where e.salary > (
	select e2.salary
	from employees e2
	where e2.last_name = 'Tucker' or 'tucker'
);

-- [문제 2] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오

-- 1. 업무별 최소 급여
select distinct job_id, min(salary)
from employees
group by job_id;

-- 2.
select e1.last_name, e1.job_id, e1.hire_date, e1.salary
from employees e1
join (
	select job_id, min(salary) as min_salary
	from employees
	group by job_id
) e2 on e1.job_id = e2.job_id and e1.salary = e2.min_salary
order by e1.job_id;

-- [문제 3] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오

select department_id, avg(salary)
from employees
group by department_id;

select concat(e.first_name, ' ', e.last_name) Name, e.salary, e.department_id, e.job_id
from employees e
where e.salary > any (
	select avg(salary)
	from employees
	group by department_id
)
order by e.department_id;

-- [문제 4] 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 'O' 로 시작하는 지역에 살고 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오

-- 1. 도시 이름이 영문 'O' 로 시작하는 지역
select city
from locations
where city like 'O%';

-- 2.
select distinct concat(e.first_name, ' ', last_name), e.job_id, e.hire_date
from employees e, departments dept, locations loc
where e.department_id = (
	select d2.department_id
    from departments d2
    where d2.location_id = (
		select location_id
		from locations
		where city like 'O%'
    )
)
order by e.hire_date;

-- [문제 5] 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부 서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오

select concat(emp.first_name, ' ', emp.last_name) as 이름, jobs.job_title as 업무, emp.salary as 급여, emp.department_id as 부서번호, avg_sal.평균연봉 as '부서 평균연봉'
from employees emp, departments dept, jobs,
	(
		select dept.department_id 사번, avg(salary) 평균연봉
		from employees emp, departments dept
		where emp.department_id = dept.department_id
		group by emp.department_id
	) avg_sal
where emp.department_id = dept.department_id and emp.job_id = jobs.job_id and dept.department_id = avg_sal.사번;

-- [문제 6] ‘Kochhar’의 급여보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오.

-- 1. ‘Kochhar’의 급여
select salary
from employees
where concat(first_name, ' ', last_name) like '%Kochhar%';

-- 2.
select e.employee_id, concat(e.first_name, ' ', e.last_name), j.job_title, e.salary
from employees e, jobs j
where e.job_id = j.job_id and e.salary > (
	select salary
	from employees
	where concat(first_name, ' ', last_name) like '%Kochhar%'
);

-- [문제 7] 급여의 평균보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오

-- 1. 급여의 평균
select avg(e2.salary)
from employees e2;

-- 2.
select e1.employee_id, concat(e1.first_name, ' ', e1.last_name), j.job_title, e1.salary, e1.department_id
from employees e1, departments dept, jobs j
where e1.department_id = dept.department_id
and e1.job_id = j.job_id
and e1.salary < (
	select avg(e2.salary)
	from employees e2
);

-- [문제 8] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오

-- 1. 100번 부서의 최소 급여
select min(e1.salary)
from employees e1
where e1.department_id = 100;

select min(e1.salary)
from employees e1, departments dept
where e1.department_id = dept.department_id and dept.department_id = 100;

-- 2.
select emp.department_id
from employees emp, departments d
where emp.department_id = d.department_id
group by emp.department_id
having min(emp.salary) > (
	select min(e1.salary)
	from employees e1
	where e1.department_id = 100
);

select emp.department_id
from employees emp, departments d
where emp.department_id = d.department_id
group by emp.department_id
having min(emp.salary) > (
	select min(e1.salary)
	from employees e1, departments dept
	where e1.department_id = dept.department_id and dept.department_id = 100
);

-- [문제 9] 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오 출력시 업무별로 정렬하시오

SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Name, e.job_id, e.department_id
FROM employees e JOIN (SELECT MIN(salary) salary, job_id
						FROM employees
						GROUP BY job_id) AS ms
                        ON e.salary = ms.salary AND e.job_id = ms.job_id;


-- [문제 10] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오

-- 1. 100번 부서의 최소 급여
select min(salary)
from employees
where department_id = 100;

-- 2.
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (
	select min(salary)
	from employees
	where department_id = 100
);

-- [문제 11] 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.
select concat(first_name, ' ', last_name), job_id, department_name, street_address
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id
where job_id = any(
select 'SA_MAN'
from jobs
);

select j.job_title, d.department_id, j.job_id, concat(e.first_name, ' ', e.last_name) Name
from jobs j
join employees e on e.job_id = j.job_id
join departments d on d.department_id = e.department_id
where j.job_id = 'SA_MAN';

select concat(e.first_name, ' ', e.last_name) Name, e.job_id, d.department_name, l.city
from (select first_name, last_name, job_id, department_id from employees where job_id = 'SA_MAN') e,
	(select department_id, department_name, location_id from departments) d,
	(select location_id, city from locations) l
where e.department_id = d.department_id and d.location_id = l.location_id;

-- [문제 12] 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오
select manager_id
from employees e
group by manager_id
order by count(manager_id) desc;

select e.employee_id, concat(e.first_name, ' ', e.last_name) Name
from employees e
where e.employee_id = (
	select manager_id
	from employees e
	group by manager_id
	order by count(manager_id) desc
	limit 1
);

-- [문제 13] 사원번호가 123인 사원의 업무가이 같고 사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 사원번호,이름,직업,급여를 출력하시오

-- 1. 사원번호가 123인 사원
select job_id
from employees
where employee_id = 123; -- ST_MAN

-- 2. 사원번호가 192인 사원의 급여(SAL)
select salary
from employees
where employee_id = 192; -- 4000.00

-- 3. 사원의 사원번호,이름,직업,급여를 출력하시오
select e.employee_id, concat(e.first_name, ' ', e.last_name), j.job_title, e.salary
from employees e join jobs j
on e.job_id = j.job_id
where e.job_id = (
	select job_id
	from employees
	where employee_id = 123
) and e.salary > (
	select salary
	from employees
	where employee_id = 192
);

-- [문제 14] 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일 자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.

-- 1.50번 부서에서 최소 급여
select min(salary)
from employees
where department_id = 50; -- 2100.00

-- 2.사원의 사원번호,이름,업무,입사일 자,급여,부서번호를 출력하시오
select e.employee_id, concat(e.first_name, ' ', e.last_name), j.job_title, e.hire_date, e.salary, e.department_id
from employees e join jobs j on e.job_id = j.job_id
where e.salary > (
	select min(salary)
	from employees
	where department_id = 50
) and e.department_id <> 50
order by e.salary;

-- [문제 15] (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일 자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.

-- 1. 50번 부서의 최고 급여
select max(salary)
from employees
where department_id = 50; -- 8200.00

-- 2. 사원의 사원번호,이름,업무,입사일 자,급여,부서번호를 출력하시오
select e.employee_id, concat(e.first_name, ' ', e.last_name), j.job_title, e.hire_date, e.salary, e.department_id
from employees e join jobs j on e.job_id = j.job_id
where e.salary > (
	select max(salary)
	from employees
	where department_id = 50
)and e.department_id <> 50
order by e.salary;