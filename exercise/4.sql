#不用组函数max，取得最高薪水
#第一种方式
select ename,sal from emp order by sal desc limit 1;
#第二种方式：表的自连接
select 
  sal 
from
  emp 
where 
  sal not in(
  select 
     distinct a.sal 
  from
     emp a 
  join
     emp b 
  on
     a.sal<b.sal);
