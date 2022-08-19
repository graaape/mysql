#取得平均薪水最高的部门的部门编号
#方法1
select
  e.deptno,avg(e.sal) avgsal
from
  emp e
group by
  e.deptno
order by
  avgsal desc limit 1;
#方法2
select 
  deptno,avg(sal) avgsal
from
  emp
group by
  deptno
having 
  avgsal=(select max(t.avgsal) from (select avg(sal) avgsal from emp group by deptno) t);