#取得部门中平均的薪水等级
select
  e.deptno,avg(s.grade)
from
  emp e
join
  salgrade s
on 
  e.sal between s.losal and s.hisal
group by
  e.deptno
order by
  e.deptno;
