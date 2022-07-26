-- 220726

declare
 v_myName VARCHAR2(20);
BEGIN
 DBMS_OUTPUT.PUT_Line('My name is: ' || v_myName);
 v_myName := 'John';
 DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
END;
/

set serveroutput on;

declare
 v_myName VARCHAR2(20) := 'John';
BEGIN
 v_myName := 'Steven';
 DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
END;
/

-- 아래 예시와 같이 변수 이름과 칼럼 이름을 똑같이 주면 안 됨
-- 컴파일은 되기 때문에 오류는 안 뜨지만..안 하는 걸 권장

declare
  employee_id number(6);
begin
  select employee_id
  into employee_id
  from employees
  where last_name = 'Kochhar';
   DBMS_OUTPUT.PUT_LINE(employee_id);
end; 
/

declare
  v_emp_hiredate employees.hire_date%TYPE;
  v_emp_salary   employees.salary%TYPE;
begin
  select hire_date, salary
  into v_emp_hiredate, v_emp_salary
  from employees
  where employee_id = 100;
  DBMS_OUTPUT.PUT_LINE('Hire date is : ' || v_emp_hiredate);
  DBMS_OUTPUT.PUT_LINE('Salary is : ' || v_emp_salary);
end; 
/

-- 치환변수

select last_name
from employees
where employee_id = &id; -- popup창에 100입력

select &&id, department_id
from employees
where &id=100; -- popup창에 employee_id 

undefine id; -- 치환 변수 해제
print id; -- 선언되지 않았다고 함..

-- 아래 바인드 함수 두 예시는 run sql에서 먹힘 (conn hr/hr)
-- developer에서는 바인드 함수를 지원하지 않는다

variable g_monthly_sal NUMBER;

declare 
  v_sal number(9,2) := &p_annual_sal;
begin
  :g_monthly_sal := v_sal/12;
end;
/

set autoprint on;
print g_monthly_sal;

variable b_emp_salary number;
begin 
  select salary into :b_emp_salary
  from employees where employee_id=178;
end;
/
print b_emp_salary;
select first_name, last_name
from employees
where salary=:b_emp_salary;

declare
    v_outer_variable varchar2(20) := 'GLOBAL VARIABLE';
    begin
        declare
          v_inner_variable varchar2(20) := 'local variable';
        begin
          dbms_output.put_line(v_inner_variable);
          dbms_output.put_line(v_outer_variable);
        end;
      dbms_output.put_line(v_outer_variable);
    end;
/

declare
  v_weight number(3) := 600;
  v_message varchar2(255) := 'Product 10012';
begin
    declare
      v_weight number(7,2) := 50000;
      v_message varchar2(255) := 'Product 11001';
      v_new_locn varchar2(50) := 'Europe';
    begin
      v_weight := v_weight + 1;
      v_new_locn := 'Western ' || v_new_locn;
      dbms_output.put_line(v_weight);
      dbms_output.put_line(v_message);
      dbms_output.put_line(v_new_locn);
    end;
  v_weight := v_weight+1;
  v_message := v_message || ' is in stock';
  --v_new_locn := 'Western ' || v_new_locn;
  dbms_output.put_line(v_weight);
  dbms_output.put_line(v_message);
end;
/
 
declare
  v_fname varchar2(25);
begin
  select first_name
  into v_fname
  from employees
  where employee_id=200;
  dbms_output.put_line('First Name is : ' || v_fname);
end;
/

undefine eid; -- 치환 변수 해제

-- 예제1

declare
  v_no employees.employee_id%TYPE;
  v_name employees.last_name%TYPE;
  v_dname departments.department_name%TYPE;
begin
  select e.employee_id, e.last_name, d.department_name
  into v_no, v_name, v_dname
  from employees e, departments d
  where e.department_id = d.department_id
  and e.employee_id = &eid;
  dbms_output.put_line('ID' || v_no);
  dbms_output.put_line('ENAME' || v_name);
  dbms_output.put_line('DNAME' || v_dname);
end;
/  

-- 예제 2

declare
  v_name employees.last_name%TYPE;
  v_sal employees.salary%TYPE;
  v_annual_sal employees.salary%TYPE;
begin
  select last_name, salary, (salary*12 + (nvl(salary,0)*nvl(commission_pct,0)*12)) as annual
  into v_name, v_sal, v_annual_sal
  from employees
  where employee_id = &eno;
  dbms_output.put_line('ENAME: ' || v_name);
  dbms_output.put_line('SALARY: ' || v_sal || ', ANNUAL SALARY: ' || v_annual_sal);
end;
/  

-- 예제 3-1
-- decode함수는 = 일때만 쓸 수 있다
declare
  v_hdate varchar2(50);
begin
  select case when hire_date >= '2000/01/01' 
              then 'New employee' 
              else 'Career employee' end as hdate
  into v_hdate
  from employees
  where employee_id = &eno;
  dbms_output.put_line('hdate: ' || v_hdate);
end;
/  

-- 예제 3-2
declare
  v_hdate varchar2(50);
begin
  select case when hire_date >= '2000/01/01' 
              then 'New employee' 
              else 'Career employee' end as hdate
  into v_hdate
  from employees
  where employee_id = &eno;
  dbms_output.put_line('hdate: ' || v_hdate);
end;
/  

declare
 v_rows_deleted varchar2(30);
 v_empno employees.employee_id%TYPE := 176;
begin
 delete from employees
 where employee_id = v_empno;
 v_rows_deleted := (SQL%ROWCOUNT || ' row deleted.');
 dbms_output.put_line (v_rows_deleted);
end;
/

-- if
declare
  v_myage number := &no;
begin
  if v_myage < 11
  then 
    dbms_output.put_line(' I am a child ');
  end if;
end;
/

declare
  v_myage number := &no;
begin
  if v_myage < 11
  then 
    dbms_output.put_line(' I am a child ');
  else
    dbms_output.put_line(' I am not a child ');
  end if;
end;
/

declare
  v_myage number := &no;
begin
  if v_myage < 11 
  then
    dbms_output.put_line(' I am a child ');
  elsif v_myage < 20
  then
    dbms_output.put_line(' I am young ');
  elsif v_myage < 30
  then
    dbms_output.put_line(' I am in my twenties ');
  elsif v_myage < 40
  then
    dbms_output.put_line(' I am in my thirties ');
  else
    dbms_output.put_line(' I am always young ');
  end if;
end;
/

-- 예제 4
create table test01(empid, ename, hiredate)
as
  select employee_id, last_name, hire_date
  from   employees
  where  employee_id = 0;

create table test02(empid, ename, hiredate)
as
  select employee_id, last_name, hire_date
  from   employees
  where  employee_id = 0;

declare
  v_no employees.employee_id%TYPE;
  v_name employees.last_name%TYPE;
  v_hdate employees.hire_date%TYPE;
begin
  select employee_id, last_name, hire_date
  into v_no, v_name, v_hdate 
  from employees
  where employee_id=&eno;
  
  if v_hdate >= '2000/01/01'
  then
    insert into test01
    values (v_no, v_name, v_hdate);
  else
    insert into test02
    values (v_no, v_name, v_hdate);
  end if;    
end;
/  

-- 예제 2-2
declare
  v_name employees.last_name%TYPE;
  v_salary employees.salary%TYPE;
  v_salary_increased employees.salary%TYPE;
begin
  select last_name, salary, 
         case when salary <= 5000 then salary*1.2
              when salary <= 10000 then salary*1.15
              when salary <= 15000 then salary*1.1
              else salary end as increased
  into v_name, v_salary, v_salary_increased 
  from employees
  where employee_id=&eno;
  dbms_output.put_line(v_name || ' ' || v_salary || ' ' || v_salary_increased);
end;
/ 

-- 예제 2-2 if 써서
declare
  v_name employees.last_name%TYPE;
  v_salary employees.salary%TYPE;
  v_salary_increased employees.salary%TYPE;
begin
  select last_name, salary
  into v_name, v_salary
  from employees
  where employee_id=&eno;
  
  if v_salary <= 5000
  then 
  v_salary_increased := v_salary * 1.2;
  elsif v_salary <= 10000
  then 
  v_salary_increased := v_salary * 1.15;
  elsif v_salary <= 15000
  then 
  v_salary_increased := v_salary * 1.1;
  else
  v_salary_increased := v_salary;
  end if;
  dbms_output.put_line(v_name || ' ' || v_salary || ' ' || v_salary_increased);
end;
/ 

declare
  -- v_id employees.employee_id%TYPE;
begin
  delete from employees
  where employee_id = &eid;
  
  if SQL%NOTFOUND
  then
  dbms_output.put_line('해당 사원이 없습니다.');
  end if;
end;
/
  
select * from employees;

-- 카톡으로 낸 문제
declare

begin
  update employees
  set salary = salary * (1 + &ratio/100)
  where employee_id = &eno;
  
  if SQL%NOTFOUND
  then
  dbms_output.put_line('해당 사원이 없습니다.');
  else
  dbms_output.put_line(sql%rowcount || '건 수정되었습니다.');
  end if;
end;
/

-- 8.
declare
 v_birth_year number := &by;
 v_year number := extract(year from sysdate);
begin
 if mod(v_year-v_birth_year, 12) = 4
 then 
 dbms_output.put_line('개띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 3
 then 
 dbms_output.put_line('돼지띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 2
 then 
 dbms_output.put_line('쥐띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 1
 then 
 dbms_output.put_line('소띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 0
 then 
 dbms_output.put_line('호랑이띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 11
 then 
 dbms_output.put_line('토끼띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 10
 then 
 dbms_output.put_line('용띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 9
 then 
 dbms_output.put_line('뱀띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 8
 then 
 dbms_output.put_line('말띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 7
 then 
 dbms_output.put_line('양띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 6
 then 
 dbms_output.put_line('원숭이띠입니다.');
 elsif mod(v_year-v_birth_year, 12) = 5
 then 
 dbms_output.put_line('닭띠입니다.');
 else
 dbms_output.put_line('실패');
 end if;
end;
/

rollback;
select * from employees;

-- 예제 2-1
create table emp10
as
  select *
  from   employees
  where  employee_id = 0;
create table emp20
as
  select *
  from   employees
  where  employee_id = 0;  
create table emp30
as
  select *
  from   employees
  where  employee_id = 0;  
create table emp40
as
  select *
  from   employees
  where  employee_id = 0;  
  create table emp50
as
  select *
  from   employees
  where  employee_id = 0;
create table emp00
as
  select *
  from   employees
  where  employee_id = 0;

declare
  v_no employees.employee_id%TYPE;
  v_name employees.last_name%TYPE;
  v_hdate employees.hire_date%TYPE;
begin
  select employee_id, last_name, hire_date
  into v_no, v_name, v_hdate 
  from employees
  where employee_id=&eno;
  
  if v_hdate >= '2000/01/01'
  then
    insert into test01
    values (v_no, v_name, v_hdate);
  else
    insert into test02
    values (v_no, v_name, v_hdate);
  end if;    
end;
/    
select * from test02;  

rollback;
