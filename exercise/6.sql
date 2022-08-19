#取得平均薪水最高的部门名称
#法1
select
  d.dname,avg(e.sal) avgsal
from
  emp e
join
  dept d
on 
  d.deptno=e.deptno
group by
  e.deptno
order by
  avgsal desc limit 1;
#法2
select
  d.dname,avg(e.sal) avgsal
from
  emp e
join
  dept d
on
  d.deptno=e.deptno
group by
  d.dname
having
  avgsal=(select max(t.avgsal) from (select avg(sal) avgsal from emp e group by e.deptno) t);