-- A.5 여러 테이블의 데이터 표시 : Join
-- [문제 0] hr 스키마에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후
-- Oxford에 근무하는 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 도시명을 출력하시오.
-- 이때 첫 번째 열은 회사명인 ‘Han-Bit’이라는 상수값이 출력되도록 하시오
select 'Han-bit' company, concat(emp.first_name, emp.last_name) Name, emp.job_id, dept.department_name, loc.city
from locations loc, employees emp, departments dept
where loc.location_id = dept.location_id and emp.department_id = dept.department_id and loc.city = 'Oxford';

-- [문제 1] HR 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 사원수가 5명 이상인 부서의 부서명과 사원수를 출력하시오.
-- 이때 사원수가 많은 순으로 정렬하시오
select dept.department_name, count(emp.employee_id)
from employees emp, departments dept
where emp.department_id = dept.department_id
group by dept.department_name
having count(emp.employee_id) >= 5
order by count(emp.employee_id) desc;

-- [문제 2] 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 급여 등급은 JOB_GRADES 테이블에 표시 된다.
-- 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여, 급여등급을 출력하시오
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , d.department_name
     , e.hire_date
     , e.salary
     , jg.grade_level
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         LEFT JOIN job_grades jg ON e.salary BETWEEN jg.lowest_sal AND jg.highest_sal;

-- [문제 3] 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.
-- 예) 홍길동은 허균에게 보고한다 → Eleni Zlotkey report to Steven King
-- 어떤 사원이 어떤 사원에서 보고하는지를 위 예를 참고하여 출력하시오. 단, 보고할 상사가 없는 사원이 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오
SELECT IF(e.manager_id IS NOT NULL
           , CONCAT(e.first_name, ' ', e.last_name, ' report to ', UPPER(m.first_name), ' ', UPPER(m.last_name))
           , CONCAT(e.first_name, ' ', e.last_name, ' report to ')
       ) AS 'report to'
FROM employees e
         LEFT JOIN employees m ON e.manager_id = m.employee_id;