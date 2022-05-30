-- 220530
-- �� �� ���󰡼� ������ ��ũ��Ʈ ���� ��.��


select deptno, max(sal)
from emp
group by deptno
having max(sal) >2900;

select deptno, max(sal)
from emp
group by deptno;

select job, sum(sal)
from emp
where job <> 'SALESMAN'
group by job
having sum(sal) > 3000
order by sum(sal);

select max(avg(sal))    --�׷��Լ��� ��ø�� ��� select ���� ��ø�� �׷��Լ��� �����ϰ�� ��� �÷��� �� �� ����.
from emp
group by deptno;

select *
from emp;

select *
from dept;

select ename, dname
from emp, dept;     --ī�׽þ� ���δ�Ʈ

select ename, dname
from emp, dept
where emp.deptno = dept.deptno;     --join (Oracle)

select ename, dname
from emp cross join dept;   --cross join (ANSI)

--------------------------------------------------------------------------------
select emp.empno, emp.ename, emp.deptno, dept.deptno, dept.loc  --�������̸� ���̺���� ���°��� ����.
from emp, dept
where emp.deptno= dept.deptno;

select e.empno, e.ename, e.deptno, d.deptno, d.loc
from emp e, dept d      --���̺� �� ���� ����.
where e.deptno= d.deptno;

select *
from salgrade;

select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal BETWEEN s.losal and s.hisal;

select '�����ȣ' || worker.empno || '�� '|| worker.ename ||'�� ����ڴ� �����ȣ '||
    manager.empno|| '�� '|| manager.ename ||'�̴�.'
    as "Employeee And Manager"
from emp worker, emp manager
where worker.mgr = manager.empno;

--ANSI
select ename, dname
from emp cross join dept;

select empno, ename, deptno, dname
from emp natural join dept
where deptno =20;

select e.empno, e.ename, d.dname
from emp e join dept d using (deptno);

select e.empno, e.ename, e.deptno, d.deptno, d.loc  --ANSI ���� ON��
from emp e join dept d
    on e.deptno =d.deptno;

select e.empno, e.ename, e.deptno, d.deptno, d.loc  --���� On���� Oracle �������� ��ȯ (����� �ʴ�!)
from emp e, dept d
where e.deptno = d.deptno;

select empno, grade, dname
from emp e
    join dept d on d.deptno = e.deptno
    join salgrade s on e.sal BETWEEN losal and hisal;
    
select empno, grade, dname
from emp e
    join dept d on d.deptno = e.deptno
/*and, where*/    join salgrade s on e.sal BETWEEN losal and hisal;     --ANSI�� from���� join������ ���´�. �׷��� where, and ������ join������ ����� �� ����.

select e.empno, e.ename, e.deptno, d.deptno, d.loc
from emp e join dept d on (e.deptno = d.deptno)
and e.mgr = 7839;

-- ��������

SELECT job
FROM emp
WHERE empno = 7782;

SELECT ename, job
FROM emp
WHERE UPPER(job)= 'MANAGER';

-- ���������� ����ϸ� �� �� ���Ǹ� �ϳ��� ��ĥ �� �ִ�

SELECT ename, job
FROM emp
WHERE job = (SELECT job
             FROM emp
             WHERE empno = 7782);
