-- 하나의 스키마에서 여러 테이블이 존재하고 정보를 저장하고 있다.
-- 테이블간의 관계를 기반으로 수행되는 연산
-- join sql:1999 문법 이전과 이후 구분
-- join 종류는 등가조인(equi join) ==> 오라클 : natural / inner join
-- outer join(외부조인, 포괄조인) ==> left outer join, right outer join
-- self join(자체 조인)
-- 비등가 조인
-- 카티시안 곱 ==> cross join

-- 조인 조건에서 '='을 사용하는 조인은 equi, inner, natural join이라고 함.
select employee_id 사원번호, first_name 이름, emp.department_id 부서번호, dept.department_id 부서번호, dept.department_name 부서이름
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- 지역코드가 1700 사원의 이름과 지역번호, 부서번호, 부서 이름을 출력하시오
select employees.last_name, locations.location_id, employees.department_id, departments.department_name
from departments, locations, employees
where departments.location_id = locations.location_id and departments.department_id = employees.department_id and locations.location_id = 1700;

-- self join
-- 각 사원을 관리하는 상사의 이름을 검색하시오.
select e1.employee_id 사원번호, concat(e1.first_name, e1.last_name) 사원이름, e1.manager_id 상사번호, e2.employee_id 상사의사원번호, concat(e2.first_name, e2.last_name) 상사이름
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- left outer join
select dept.department_id 부서번호, dept.department_name 부서명, emp.first_name 사원명
from departments dept, employees emp
where dept.department_id = emp.department_id;

select dept.department_id 부서번호, dept.department_name 부서명, emp.first_name 사원명
from departments dept, employees emp
where dept.department_id = emp.department_id(+); -- 이거 oracle에서만 가능한건지

-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요.
select concat(emp.first_name, emp.last_name), dept.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- 2. 부서번호 80에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하시오.
select joh.job_id, dept.location_id
from locations loc, job_history joh, departments dept
where loc.location_id = dept.location_id and joh.department_id = dept.department_id and dept.department_id = 80;

-- 3. 커미션을 받는 사원의 이름, 부서 이름, 위치 번호와 도시 명을 조회하세요.
select concat(emp.first_name, emp.last_name), dept.department_name, loc.location_id, loc.city
from locations loc, employees emp, departments dept
where loc.location_id = dept.location_id and emp.department_id = dept.department_id and emp.commission_pct is not null;

-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요.
select concat(emp.first_name, emp.last_name), dept.department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서번호와 부서명을 조회하세요
select concat(emp.first_name, emp.last_name), emp.job_id, dept.department_id, dept.department_name
from locations loc, employees emp, departments dept
where dept.department_id = emp.department_id and dept.location_id = loc.location_id and loc.city = 'Toronto';

-- 6. 사원의 이름과 사원번호를 관리자의 이름과 관리자의 아이디와 함께 표시하고 각각의 컬럼명을 Employee, Emp#, Manager, Mgr#으로 지정하세요.
select concat(e1.first_name, e1.last_name) Employee, e1.employee_id "Emp#", concat(e2.first_name, e2.last_name) Manager, e2.employee_id "Mgr#"
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
select distinct e1.employee_id, concat(e1.first_name, e1.first_name)
from employees e1, employees e2
where e1.employee_id = e2.manager_id and e1.manager_id is null or e1.last_name = 'King'
order by e1.employee_id;

-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요(Marvins로 지정)
select concat(emp.first_name, emp.last_name), emp.employee_id
from employees emp, departments dept
where emp.department_id = dept.department_id and emp.department_id = (select department_id from employees where employees.last_name = 'Marvins');

-- 9. JOB_GRADRES 테이블을 생성하고 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
select
from
where