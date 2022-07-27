-- 220727  

set serveroutput on;

-- 연습문제1
declare
  v_no employees.employee_id%TYPE;
  v_name employees.last_name%TYPE;
  v_salary employees.salary%TYPE;
  v_salary_increased employees.salary%TYPE;
  v_dept_name departments.department_name%TYPE;
begin
  select e.employee_id, e.last_name, e.salary, upper(d.department_name)
  into v_no, v_name, v_salary, v_dept_name
  from employees e, departments d
  where e.department_id = d.department_id and employee_id=&id;
  
  if v_dept_name = 'IT_PROG'
  then 
  v_salary_increased := v_salary * 1.1;
  elsif v_dept_name = 'ST_CLERK'
  then 
  v_salary_increased := v_salary * 1.2;
  elsif v_dept_name = 'ST_MAN'
  then 
  v_salary_increased := v_salary * 1.3;
  else
  v_salary_increased := v_salary;
  end if;
  dbms_output.put_line(v_no || ' ' || v_name || ' ' || v_salary_increased || ' ' || v_dept_name);
end;
/ 

select * from employees;
select * from departments;

-- 연습문제2
declare
 v_no employees.employee_id%TYPE;
 v_name employees.last_name%TYPE;
 v_salary employees.salary%TYPE;
 v_dname departments.department_name%TYPE;
begin
 select e.employee_id, e.last_name, e.salary, d.department_name
 into v_no, v_name, v_salary, v_dname
 from departments d, employees e
 where e.department_id = d.department_id 
 and e.salary = (select max(salary,0) 
                 from employees 
                 where department_id=&did 
                 group by department_id);

 dbms_output.put_line(v_no || ' ' || v_name || ' ' || v_salary || ' ' || v_dname);
end;
/

-- loop

declare
 v_countryid locations.country_id%TYPE := 'CA';
 v_loc_id    locations.location_id%TYPE;
 v_counter   number(2) := 1;
 v_new_city  locations.city%TYPE := 'Montreal';
begin
 select max(location_id)
 into v_loc_id 
 from locations
 where country_id = v_countryid;
 loop
   insert into locations(location_id, city, country_id)
   values ((v_loc_id + v_counter), v_new_city, v_countryid);
   v_counter := v_counter+1;
   exit when v_counter > 3;
 end loop;
end;
/

select * from locations;

-- while loop

declare
 v_countryid locations.country_id%TYPE := 'CA';
 v_loc_id    locations.location_id%TYPE;
 v_counter   number(2) := 1;
 v_new_city  locations.city%TYPE := 'Montreal';
begin
 select max(location_id)
 into v_loc_id 
 from locations
 where country_id = v_countryid;
 while v_counter <= 3 loop
   insert into locations(location_id, city, country_id)
   values ((v_loc_id + v_counter), v_new_city, v_countryid);
   v_counter := v_counter+1;
 end loop;
end;
/

-- for loop

declare
 v_countryid locations.country_id%TYPE := 'CA';
 v_loc_id    locations.location_id%TYPE;
 v_new_city  locations.city%TYPE := 'Montreal';
begin
 select max(location_id)
 into v_loc_id 
 from locations
 where country_id = v_countryid;
 for i in 1..3 loop
   insert into locations(location_id, city, country_id)
   values ((v_loc_id+i), v_new_city, v_countryid);
 end loop;
end;
/

-- 연습문제
create table aaa
(a number(3));

create table bbb
(b number(3));

-- 1
begin
 for i in 1..10 loop 
  insert into aaa
  values (i);
  end loop;
end;
/
select * from aaa;

-- 2
declare
 v_sum number :=0;
begin
 
 for i in 1..10 loop 
  v_sum := v_sum + i;
 end loop;
  insert into bbb
  values (v_sum);
end;
/

-- 3
begin
  for i in 1..10 loop
    if mod(i,2)=0
    then 
     insert into aaa
     values(i);
    end if; 
  end loop;
end;
/

-- 4
declare
 v_sum number :=0;
begin
  for i in 1..10 loop
   if mod(i,2)=0
   then 
    v_sum := v_sum+i;
   end if;
  end loop;
  insert into bbb
  values (v_sum);
end;
/

-- 5
-- 루프안에 인서트 넣으니까 다섯행씩 생김
-- sum 변수 두 개로 나눠서 최종 한 번 넣게 함
declare
  v_oddsum number := 0;
  v_evensum number := 0;
begin
  for i in 1..10 loop
   if mod(i,2)=0
   then
    v_evensum := v_evensum+i;
   elsif mod(i,2) =1
   then
    v_oddsum := v_oddsum+i;
   end if;
  end loop;
  
  insert into aaa
  values (v_evensum);
  
  insert into bbb
  values (v_oddsum);
  
end;
/

select * from aaa;
select * from bbb;
truncate table bbb;
truncate table aaa;

-- 별찍기
begin
  for i in 1..5 loop
    for j in 1..i loop
      dbms_output.put('*');
    end loop;
    dbms_output.put_line('');
  end loop;
end;
/

-- 거꾸로 별찍기 어떻게?

begin
  for i in 1..5 loop
    for j in 5..1 loop
      if j>=i
      then
      dbms_output.put('*');
      end if;
    end loop;
    dbms_output.put_line('');
  end loop;
end;
/

-- 구구단-1
declare 
 v_num number := &num;
begin
 for i in 1..9 loop
   dbms_output.put_line(v_num || '*' || i || '=' || v_num*i);
 end loop;
end;
/

-- 구구단-2
begin
 for i in 2..9 loop
   dbms_output.put_line('');
   dbms_output.put_line(i || '단');
  for j in 1..9 loop
   dbms_output.put_line(i || '*' || j || '=' || i*j);
  end loop;
 end loop;
end;
/

-- 구구단-3
begin
 for i in 2..9 loop
   if mod(i,2) = 1 then
     dbms_output.put_line('');
     dbms_output.put_line(i || '단');
     for j in 1..9 loop
       dbms_output.put_line(i || '*' || j || '=' || i*j);
     end loop;
   end if;
 end loop;
end;
/

-- 레코드
declare 
  type t_rec is record
   (v_sal number(8),
    v_minsal number(8) default 1000,
    v_hire_date employees.hire_date%type,
    v_rec1 employees%rowtype);
  v_myrec t_rec;
begin
  v_myrec.v_sal := v_myrec.v_minsal + 500;
  v_myrec.v_hire_date := sysdate;
  select * 
  into v_myrec.v_rec1
  from employees 
  where employee_id = 100;
  dbms_output.put_line(v_myrec.v_rec1.last_name || ' ' ||
                       to_char(v_myrec.v_hire_date) || ' ' ||
                       to_char(v_myrec.v_sal)); 
end;
/
-- sysout () 안에 데이터 타입을 맞춰주는 것이 좋다
-- 그래서 to_char 쓰는 것임

create table retired_emps (empno, ename, job, mgr, hiredate,
                           leavedate, sal, comm, deptno)
as
  select employee_id, last_name, job_id, manager_id, hire_date,
         sysdate, salary, commission_pct, department_id
  from   employees
  where  employee_id = 0;


declare
  v_employee_number number := 124;
  v_emp_rec employees%ROWTYPE;
begin
  select *
  into v_emp_rec 
  from employees
  where employee_id = v_employee_number;
  
  insert into retired_emps(empno, ename, job, mgr, hiredate, leavedate, sal, comm, deptno)
  values (v_emp_rec.employee_id, 
          v_emp_rec.last_name, 
          v_emp_rec.job_id,
          v_emp_rec.manager_id,
          v_emp_rec.hire_date,
          SYSDATE,
          v_emp_rec.salary,
          v_emp_rec.commission_pct,
          v_emp_rec.department_id);
end;
/

select * from retired_emps;
select * from emp10;

-- 예제 2-1
-- 레코드를 하나하나 집어넣을거면 괄호 안에 넣고 통째로 넣을거면 괄호 빼야됨
declare
  v_emp_rec employees%rowtype;
  v_did employees.department_id%TYPE := &did;
begin
  select *
  into v_emp_rec                                          
  from employees
  where department_id=v_did;
  
  if v_did = 10
  then
    insert into emp10
    values v_emp_rec;
  elsif v_did = 20
  then
    insert into emp20
    values v_emp_rec;
  elsif v_did = 30
  then
    insert into emp30
    values v_emp_rec;
  elsif v_did = 40
  then
    insert into emp40
    values v_emp_rec;
  elsif v_did = 50
  then
    insert into emp50
    values v_emp_rec;
  else
    insert into emp00
    values v_emp_rec;
  end if;  
end;
/

set verify off;

declare 
  v_employee_number number := 124;
  v_emp_rec retired_emps%rowtype;
begin
  select *
  into v_emp_rec
  from retired_emps;
  
  v_emp_rec.leavedate := current_date-1;
  
  update retired_emps 
  set row=v_emp_rec 
  where empno=v_employee_number;
end;
/

select * from retired_emps;

-- 테이블

declare 
  type dept_table_type is table of
     departments%rowtype index by pls_integer;
  dept_table dept_table_type;   
begin
  select *
  into dept_table(2)
  from departments
  where department_id = 20;
  
  dbms_output.put_line(dept_table(2).department_id || ' ' || 
                       dept_table(2).department_name || ' ' || 
                       dept_table(2).manager_id);
end;
/