#1 取得每个部门最高薪水的人员名称
select
  e.ename,t.*
from
  emp e
join
  (select deptno,max(sal) maxsal from emp group by deptno) t
on 
  t.deptno=e.deptno and e.sal=t.maxsal;