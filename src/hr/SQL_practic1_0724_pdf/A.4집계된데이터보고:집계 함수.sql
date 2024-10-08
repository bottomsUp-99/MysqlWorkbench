-- A.4 집계된 데이터 보고 : 집계 함수
-- [문제 0] 모든 사원은 직속 상사 및 직속 직원을 갖는다.
-- 단, 최상위 또는 최하위 직원은 직속 상사 및 직 원이 없다. 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오
select count(distinct mgr.employee_id)
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id;

-- [문제 1] 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다.
-- 계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오.
-- 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 아래 예시처럼 별칭(alias) 처리 하시오
-- (hint) 출력 양식 정하는 방법 - TO_CHAR(SUM(salary), '$999,999.00')
select department_name, employees.department_id, concat('$', format(sum(salary), '#,#')), concat('$', format(max(salary), '#,#')), concat('$', format(min(salary), '#,#'))
from employees, departments
where employees.department_id is not null and employees.department_id = departments.department_id
group by employees.department_id
order by employees.department_id;

-- [문제 2] 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시 오.
-- 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오
select j.job_title, avg(emp.salary)
from employees emp, jobs j
where emp.job_id = j.job_id and not j.job_id like '%CLERK%'
group by emp.job_id
having avg (emp.salary) >= 10000
order by avg(emp.salary) desc;