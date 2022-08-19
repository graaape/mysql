#取得比普通员工(员工代码没有在mgr字段上出现)的最高薪水还要高的领导姓名
select
  max(sal)
from
  emp
where
  empno not in(select distinct mgr from emp where mgr is not null);
select 
  ename,sal
from
  emp
where
  sal>
 (select
      max(sal)
  from
      emp
  where
      empno not in(select distinct mgr from emp where mgr is not null));
  #and empno in(select distinct mgr from emp);
  
