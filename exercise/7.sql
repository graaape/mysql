#取得平均薪水的等级最低的部门名称
select
  t.dname '最低平均工资部门',s.grade
from
  (select 
	d.dname,avg(e.sal) avgsal
   from 
	emp e 
   join 
	dept d 
  on 
	e.deptno=d.deptno 
  group by 
	d.dname) t
join
  salgrade s
on 
  t.avgsal between s.losal and s.hisal
where
 s.grade=(select
      	  min(s.grade)
	from
  	  (select 
		d.dname,avg(e.sal) avgsal
 	   from 
		emp e 
   	   join 
		dept d 
  	   on 
		e.deptno=d.deptno 
	  group by 
		d.dname) t
	join
  	  salgrade s
	on 
  	t.avgsal between s.losal and s.hisal);
