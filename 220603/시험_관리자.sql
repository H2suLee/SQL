grant create view to hr;
grant create synonym to hr;

-- 20
create user std
identified by yd2460;

grant connect, resource
to std;

grant create view, create synonym
to std;

grant select
on hr.employees
to std;
