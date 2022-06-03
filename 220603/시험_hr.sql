-- 3 
select employee_id, last_name, salary, department_id
from employees
where salary between 7000 and 12000
and upper(last_name) like 'H%';

-- 4
select last_name, hire_date,
       add_months(hire_date, 6) "입사 6개월 후",
       next_day(hire_date, '금요일') "입사 후 첫 금요일",
       trunc(months_between(sysdate, hire_date)) "근무개월수",
       add_months(hire_date, 1) "첫 급여일"
from employees
order by hire_date;
       
-- 5 
select employee_id, last_name, to_char(hire_date, 'yy/mm/dd day') "입사일", to_char(salary*commission_pct, '$9,999.99') "수당"
from employees
where commission_pct is not null
order by "수당" desc;

-- 6
select employee_id, last_name, job_id, salary, department_id
from employees
where department_id in(50, 60)
and salary > 5000;

-- 7
select employee_id, last_name, salary*(1+nvl(commission_pct,0))*12 "연봉", to_char(hire_date, 'yyyy') "입사연도", 
       case when commission_pct is null then 'NO COMM'
       else 'COMM' end "비고",
       department_id
from employees
order by department_id, "연봉";

-- 8
select employee_id, last_name, department_id,
       case department_id when 20 then 'Canada' 
                          when 80 then 'UK'
                          else 'USA' end "근무지역"
from employees;

-- 9
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- 10
select last_name, hire_date, 
       case when to_char(hire_date, 'yyyy') >= 2000 then 'New employee'
       else 'Career employee' end "사원구분"
from employees
where employee_id = &no;

-- 11
select last_name, salary, 
       case when salary <= 5000 then salary * 1.2
            when salary <= 10000 then salary * 1.15
            when salary <= 15000 then salary * 1.1
            else salary end "인상된 급여"
from employees
where employee_id = &no;

-- 12
select d.department_id, d.department_name, l.city
from departments d, locations l
where d.location_id = l.location_id;

-- 13
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- 14
select employee_id, last_name, job_id
from employees
where department_id = (select department_id
                       from departments
                       where lower(department_name) = 'it');

-- 15
select department_id, count(*) "부서별인원수", trunc(avg(nvl(salary,0))) "부서별평균급여"
from employees
group by department_id;

-- 16
CREATE TABLE prof
(profno number(4),
 name varchar2(15) not null,
 id varchar(15) not null,
 hiredate date,
 pay number(4));
 
-- 17
insert into prof
values (1001, 'Mark', 'm1001', '07/03/01', 800);
 
insert into prof(profno, name, id, hiredate)
values (1003, 'Adam', 'a1003', '11/03/02');
 
commit;

update prof
set pay = 1200
where profno = 1001;

delete prof
where profno = 1003;

commit;

-- 18
create index prof_name_idx
on prof(name);

alter table prof
add constraint prof_no_pk primary key(profno);

alter table prof
add (gender char(3));

alter table prof
modify (name varchar2(20)); 

desc prof;
-- 19

create view prof_vu(pno, pname, id)
as select profno, name, id
   from prof;
   
create or replace view prof_vu(pno, pname, id, hiredate)
as select profno, name, id, hiredate
   from prof;

create synonym p_vu 
for prof_vu;

-- 21
drop table prof;
