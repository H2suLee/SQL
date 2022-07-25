-- 1
select * 
from employees
where commission_pct is not null; 

-- 2
select employee_id, last_name, salary, hire_date, department_id
from employees
order by salary;

-- 3
select employee_id, last_name, to_char(hire_date, 'yyyy-mm-dd') as hire_date, salary
from employees;

-- 추가
-- 개발시 insert 구문 짤 때 to_date 함수 잘 쓰기
select * from employees
where hire_date=to_date('1997년 9월 17일', 'yyyy"년" mm"월" dd"일"'); 

-- 4
select e.employee_id, e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- 추가
select e.employee_id, e.last_name, d.department_id, d.department_name
from   employees e, departments d
where  e.department_id = d.department_id
and    e.salary >= 4000;

-- 추가
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id=d.department_id
and d.location_id=l.location_id;

-- ANSI
select e.last_name, d.department_name, l.city
from employees e JOIN departments d
                    ON (e.department_id=d.department_id)
                 JOIN locations l
                    ON (d.location_id = l.location_id);

-- 5
select department_id "부서", round(avg(nvl(salary,0))) as "평균급여"
from employees
group by department_id;

-- 추가
select min(avg(nvl(salary,0))) as "최소평균급여" -- 그룹함수를 중첩할 때는 다른 컬럼이 있으면 안됨
from employees
group by department_id;

-- 6
select employee_id, last_name, salary, job_id, department_id
from employees
where department_id = (select department_id from employees where employee_id=142); -- =대신 in을 써도 된다

-- 7
select employee_id, last_name, hire_date, add_months(hire_date,6) as "입사 6개월 후"
from employees;

-- 8
create table sawon
(s_no number(4),
 name varchar2(15) not null,
 id varchar2(15) not null,
 hiredate date,
 pay number(4));
 
-- 추가
alter table sawon
modify s_no number(4) primary key;
-- add primary key(s_no); 도 됨(테이블 레벨)
-- add sawon_s_no_pk primary key(s_no); 로 제약조건 이름을 정해줄 수도 있음

alter table sawon
modify pay number(4) not null; -- 제약조건 추가할 때 데이터타입은 생략 가능

desc sawon;

-- 제약조건은 총 5개
-- not null 제약 조건은 무조건 컬럼 레벨에서 정해줘야 한다

-- 9
 insert into sawon 
 values (101, 'Jason', 'ja101', to_date('17/09/01', 'yy/mm/dd'), 800);
 
 insert into sawon 
 values (104, 'Min', 'm104', '14/07/02', 0);
 
 select * from sawon;
 
 commit;
 
 update sawon set pay=700 where s_no=104;
 
 commit;

-- 10 
 drop table sawon purge; -- purge는 최대한 안 쓰는 걸 권장    
 
 
declare
v_fname varchar2(20);
begin 
select first_name into v_fname from employees
where employee_id=100;
DBMS_OUTPUT.PUT_LINE('The First Name of the Employee is ' || v_fname); -- sysout 같은 존재
end;
/

set serveroutput on;

