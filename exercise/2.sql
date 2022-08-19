#哪些人的薪水在部门的平均薪水之上
select 
  e.ename,e.sal,t.*
from 
  emp e
join
  (select deptno,avg(sal) avgsal from emp group by deptno) t
on
  e.sal>avgsal and e.deptno=t.deptno
order by
  t.deptno;
