-- 220530
-- 내 거 날라가서 은지님 스크립트 받음 ㅜ.ㅜ


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

select max(avg(sal))    --그룹함수를 중첩할 경우 select 절에 중첩한 그룹함수를 제외하고는 어떠한 컬럼도 올 수 없다.
from emp
group by deptno;

select *
from emp;

select *
from dept;

select ename, dname
from emp, dept;     --카테시안 프로덕트

select ename, dname
from emp, dept
where emp.deptno = dept.deptno;     --join (Oracle)

select ename, dname
from emp cross join dept;   --cross join (ANSI)

--------------------------------------------------------------------------------
select emp.empno, emp.ename, emp.deptno, dept.deptno, dept.loc  --가급적이면 테이블명을 적는것이 낫다.
from emp, dept
where emp.deptno= dept.deptno;

select e.empno, e.ename, e.deptno, d.deptno, d.loc
from emp e, dept d      --테이블 명 지정 가능.
where e.deptno= d.deptno;

select *
from salgrade;

select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal BETWEEN s.losal and s.hisal;

select '사원번호' || worker.empno || '인 '|| worker.ename ||'의 상급자는 사원번호 '||
    manager.empno|| '인 '|| manager.ename ||'이다.'
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

select e.empno, e.ename, e.deptno, d.deptno, d.loc  --ANSI 구문 ON절
from emp e join dept d
    on e.deptno =d.deptno;

select e.empno, e.ename, e.deptno, d.deptno, d.loc  --위의 On절을 Oracle 구문으로 변환 (어렵지 않다!)
from emp e, dept d
where e.deptno = d.deptno;

select empno, grade, dname
from emp e
    join dept d on d.deptno = e.deptno
    join salgrade s on e.sal BETWEEN losal and hisal;
    
select empno, grade, dname
from emp e
    join dept d on d.deptno = e.deptno
/*and, where*/    join salgrade s on e.sal BETWEEN losal and hisal;     --ANSI는 from절에 join조건을 적는다. 그래서 where, and 구문에 join조건을 사용할 수 없다.

select e.empno, e.ename, e.deptno, d.deptno, d.loc
from emp e join dept d on (e.deptno = d.deptno)
and e.mgr = 7839;

-- 서브쿼리

SELECT job
FROM emp
WHERE empno = 7782;

SELECT ename, job
FROM emp
WHERE UPPER(job)= 'MANAGER';

-- 서브쿼리를 사용하면 위 두 질의를 하나로 합칠 수 있다

SELECT ename, job
FROM emp
WHERE job = (SELECT job
             FROM emp
             WHERE empno = 7782);
