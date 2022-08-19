
# MySQL笔记
## MySQL服务的启停
在命令提示符中：
- 启动：```net start 服务名称```
- 停止：```net stop 服务名称```
## MySQL常用命令
注意：不区分大小写。输入分号表示语句结束。
- 查看MySQL中的数据库：```show databases;```
- 使用某个数据库：```use 数据库名;```
- 创建一个数据库：```create database 数据库名;```
- 查看数据库中的表：```show tables;```
- 查看表中数据：```select*from 表名;```
- 导入数据命令：```source 路径```
	- 导入数据前需要先选择要使用的数据库。
- 查看表的结构：```desc 表名;```
- 查看MySQL数据库的版本号：```select version();```
- 查看当前使用的数据库名称：```select database();```
## 表的理解
- 数据库中最基本的单位是表（table）。
- 任何一张表都有行和列：
	- 行（row）：被称为数据/记录。
	- 列（column）：被称为字段。
- 补充：
	- 每一个字段都有字段名、数据类型、约束等属性。
	- 字段名即一个容易理解的名字。
	- 数据类型：字符串、数字、日期等。
	- 约束：有很多约束。比如唯一性约束，某个字段添加该约束后，这个字段中的数据不能重复。
## SQL语句的分类
- DQL：数据查询语言。带有select关键字。
- DML：数据操作语言。对表中的数据进行增删改。关键字：insert delete update
- DDL：数据定义语言。主要操作表的结构。关键字：create drop alter
- TCL：事务控制语言。关键字：commit rollback
- DCL：数据控制语言。关键字：grant revoke 等
## 简单查询
- 查询一个字段：```select 字段名 from 表名```
- 查询两个或多个字段：```select 字段名1,字段名2... from 表名```
- 查询所有字段
	- 方式1：添加所有字段名。
	- 方式2：使用*。
		- 缺点：运行效率低。可读性差。
- 改变列的显示名称：```select 字段名 as 别名 from 表名;```
	- 不改动原表的列名。
	- 可以省略as。
	- 若别名中带有空格，需要在别名前后加上引号，建议使用单引号。
- 字段中可以使用数学表达式，比如：```select sal*12 '年薪' from emp;//计算年薪```
## 条件查询
- 语法格式：```select 字段名 from 表名 where 条件;```
- 条件：
	- 等于：=
	- 不等于：!=或<>
	- 小于：<
	- 小于等于：<=
	- 大于：>
	- 大于等于：>=
	- between ... and ...
		- 等同于>= and <=，要遵循“左小右大”
	- 为空：is null
		- null不是一个值，不能使用=替换is
	- 并且：and
	- 或者：or
		- and优先级高于or
	- 包含：in
		- 相当于多个or
	- 取非：not
	- 模糊查询：like
		- 支持%或下划线匹配
			- %匹配任意个字符
			- 一个下划线只匹配一个字符，在下划线前加\查询带有下划线的数据
## 排序
- 语法格式：```select 字段名 from 表名 order by 字段名;```
	- 默认升序排序。
- 指定降序排序：```select 字段名 from 表名 order by 字段名 desc;```
- 指定升序排序：```select 字段名 from 表名 order by 字段名 asc;```
- 按照多个字段排序，比如按薪资升序排序，薪资一样的情况下按名字升序排序：
	```mysql
	select ename,sal from emp order by sal asc,ename asc;
	```
- 可以根据字段的位置排序，比如：```select ename，sal from emp order by 2;//按照查询结果的第二列sal排序```
- 排序总是最后执行。
## 单行处理函数
- 特点：一个输入对应一个输出。
- 常见的单行处理函数
	- 转换小写：lower
	- 转换大写：upper
	- 取子串：substr
	- 字符串的拼接：concat
	- 取长度：length
	- 去空格：trim
	- 将字符串转换成日期：str_to_date
	- 格式化日期：date_format
	- 设置千分位：format
	- 四舍五入：round
	- 生成随机数：rand()
	- 将null转换为具体值：ifnull
		- null参与的运算，结果都为null
	- case...when...then...else...end
##  分组函数
- 特点：输入多行，输出一行。
- 必须先进行分组再使用。没有进行分组，默认整张表为一组。
- 自动忽略null。
- 分组函数不能直接使用在where子句中。
- 常见分组函数：
	- 计数：count
	- 求和：sum
	- 平均值：avg
	- 最大值：max
	- 最小值：min
## 分组查询
- 关键字顺序（不能颠倒）：
	1. select
	2. from
	3. where
	4. group by
	5. order by
- 执行顺序：
	1. from
	2. where
	3. group by
	4. select
	5. order by 
- 使用having可以对分完组之后的数据进行进一步过滤。
	- having不能替代where，需要和group by联合使用。
	- 优先选择where。
## 去除查询结果中的重复记录
- 使用distinct 关键字。
-  distinct只能出现在所有字段的最前方。
- distinct将后面的字段联合起来去重。
## 连接查询
- 从一张表中单独查询，称为单表查询。
- 多张表联合起来查询数据，称为连接查询。
- 按表连接的方式分类：
	- 内连接
		- 等值连接
		- 非等值连接
		- 自连接
	- 外连接
		- 左外连接
		- 右外连接
	- 全连接
- 当没有任何条件限制，对两张表进行连接查询，最终查询结果条数是两张表条数的乘积，这种现象称为笛卡尔积现象。
### 内连接
#### 等值连接
>eg. 查询每个员工所在部门名称，显示员工名和部门名。
>SQL92语法：
>```mysql
>select
>    e.ename,d.dname
>from
>    emp e,dept d
>where
>    e.deptno=d.deptno;       
>```
>SQL99语法：
>```
>select
>    e.ename,d.dname
>from
>    emp e
>join
>    dept d
>on
>    e.deptno=d.deptno;    
>```
#### 非等值连接
>eg. 找出每个员工的薪资等级，要求显示员工名、薪资、薪资等级。
>```
>select
>    e.ename,e.sal,s.grade
>from
>    emp e
>join
>    salgrade s
>on
>    e.sal between s.losal and s.hisal;
>```
#### 自连接
>eg. 查询员工的上级领导，要求显示员工名和领导名。
> ```
>select
>    a.ename '员工名',b.ename '领导名'
>from
>    emp a
>join
>    emp b 
>on 
>    a.mgr=b.empno;
> ```
### 外连接
- 两张表连接，产生了主次关系。
#### 右外连接
>```
>select
>    e.ename,d.dname 
>from
>    emp e right join dept d 
>on
>    e.deptno=d.deptno;
>```
- right表示将join关键字右边的这张表看作主表，主表的数据全部表示，顺便显示左边的表的数据。
#### 左外连接
>```
>select
>    e.ename,d.dname 
>from
>    emp e left join dept d 
>on
>    e.deptno=d.deptno;
>```
- left表示join关键字左边的表是主表。
## 子查询
- select语句中嵌套select语句，被嵌套的select语句称为子查询。
- 子查询可以出现在select、from、where中。
### 在where 中使用子查询
>eg.显示所有工资高于最低工资的员工名。
>```
>select
>    ename 
>from
>    emp 
>where
>    sal>(select min(sal) from emp);
>```
### 在from中使用子查询
>eg.显示各工作岗位的平均工资及其对应的工资等级。
>```
>select 
>    t.*,s.grade
>from
 >    (select job,avg(sal) avgsal from emp group by job) t
>join 
>    salgrade s
>on
>    t.avgsal between s.losal and s.hisal;
>```
### 在select中使用子查询
>eg.显示所有员工名及其对应的工作岗位。
>```
>select
>    ename,(select dname from dept d where e.deptno=d.deptno) dname
>from
>    emp e;
>```
## union 合并查询结果集
- union可以在减少匹配次数的情况下，完成两个结果集的拼接。
- union在进行结果集合并时，要求两个结果集的列数相同。
- 两个结果集对应的列的数据类型最好也要一致。
## limit
- 作用：取出查询结果集的一部分。
- 通常使用在分页查询当中。
- 在order by后执行。 
## 表的创建
- 语法格式：
```create table 表名(字段名1 数据类型，字段名2 数据类型...);```
	- 用default指定默认值
	- 表名建议以t_或tbl_开始
- 快速创建表：
	```create table 新表名 as select 字段名 from 表名;```
	-	将查询结果当作一张表新建
### MySQL中常见的数据类型
- varchar：可变长度字符串
- char：定长字符串
- int：整数型
- bigint：长整型
- float：单精度浮点型
- double：双精度浮点型
- date：短日期类型，只包括年月日
- datetime：长日期类型，包括年月日时分秒
- clob：字符大对象，最多可以存储4G的字符串
- blob：二进制大对象
### 删除表
语法格式：```drop table if exists 表名;```
## 插入数据 insert
- 语法格式：
```insert into 表名(字段名1，字段名2，字段名3...)values(值1，值2，值3...);```
- 插入多条数据：
```insert into 表名(字段名1，字段名2，字段名3...)values(),()...;```
- 将查询结果插入到表中：
```insert into 表名 select 字段名 from 表名;```

	- 字段名和值要对应
	- 如果省略字段名，需要把值全部写上
### 数字格式化
语法格式：
```
select ename,format(sal,'$999,999') sal from emp;
```
### 字符串转换成日期
语法格式：
```
str_to_date('日-月-年','%d-%m-%Y')
```
### 日期转换成特定格式的字符串
语法格式：
```
date_format(date类型数据,'%m/%d%/Y')
```
## 修改数据 update
- 语法格式：
	```update 表名 set 字段名1=值1,字段名2=值2，字段名3=值3... where 条件;```
	- 注意：没有条件限制会导致所有数据更新。
## 删除数据 
### delete
- 语法格式：
```delete from 表名 where 条件;```
	-	注意：没有条件限制将删除表中所有数据。
- 属于DML语句。
- 使用delete删除数据后，真实存储空间不会被释放。
- 缺点：删除效率比较低。
- 优点：支持回滚(rollback)，可以恢复数据。
### truncate
- 语法格式：
```truncate table 表名;```
- 属于DDL操作。
- 缺点：不支持回滚。
- 优点：删除效率高。
## 约束
- 在创建表的时候，可以给表中的字段加上约束，来保证表中数据的完整性、有效性。
- 直接添加在列后的约束为列级约束。
- 没有直接添加在列后的约束为表级约束。
### 常见的约束
- 非空约束：not null
- 唯一约束：unique key
- 主键约束：primary key
- 外键约束：foreign key
### 非空约束
- not null约束的字段不能为NULL。
### 唯一性约束
- unique约束的字段不能重复，但是可以为NULL。
- 联合两个字段：
```unique(字段名1，字段名2)```
### 主键约束
- 一张表中只能添加一个主键约束。
- 添加了主键约束的字段被称为主键字段。
- 在MySQL中，如果一个字段同时被not null和unique约束的话，该字段自动变成主键字段。
- 主键字段中的每个值都是主键值。
	- 主键值是每行记录的唯一标识。
- 自然主键：主键值是一个自然数，和业务没有关系。
- 业务主键：主键值和业务紧密关联。
	- 实际开发中多使用自然主键。
- 使用auto_increment可以自动维护一个主键值。auto_increment从1开始递增。
### 外键约束
- 语法格式：
```foreign key(字段名) references 表名(字段名)```
- 外键值可以为NULL。
- 被引用的外键字段不必为主键，只要满足唯一性。
## 存储引擎
- 存储引擎是MySQL中特有的术语。
- 存储引擎是一个表存储/组织数据的方式。
- 不同的存储引擎，表存储数据的方式不同。
- 可以在建表的时候，使用ENGINE关键字给表指定存储引擎。
- MySQL默认的存储引擎是InnoDB。
## 事务
- 一个事务是一个完整的业务逻辑。多条DML语句同时成功或同时失败。
- 只有DML语句与事务有关，即insert delete update。
- 事务的执行过程中，每一条DML的操作都会记录到“事务性活动的日志文件”中。
- MySQL默认为自动提交事务，即执行一条DML语句就提交一次事务。
### 常用命令：
- 提交事务：```commit;```
- 回滚事务：```rollback;```
- 开始事务：```start transaction;```
### 事务的特性
- 原子性：说明事务是最小的工作单元，不可再分。
- 一致性：在同一个事务中，所有操作必须同时成功或者同时失败，以保证数据的一致性。
- 隔离性：A事务和B事务之间具有一定的隔离。
- 持久性：事务提交，就相当于将还未保存到硬盘的数据保存到硬盘上。
### 事务特性之一：事务的隔离性
事务和事务之间有四个隔离级别：
- 读未提交：read uncommitted（最低的隔离级别）
	- 事务A可以读取到事务B未提交的数据。
	- 存在的问题：脏读。
- 读已提交：read committed
	- 事务A只能读取到事务B已提交的数据。
	- 这种隔离级别解决了脏读现象。每一次读到的数据是真实的。
	- 存在的问题：不可重复读取。
- 可重复读：repeatable read
	- 事务A开启后，每次在事务A中读取到的数据是一致的，即使事务B此时修改了数据，事务A所读取到的数据不会发生改变。
	- MySQL中默认的事务隔离级别。
	- 存在的问题：会出现幻影读。每一次读取到的数据不够真实。
- 序列化/串行化：serializable（最高的隔离级别）
	- 表示事务排队，不能并发。
>#### 查看隔离级别
>```select @@tx_isolation;```

>#### 设置全局隔离级别
>```set global trasaction isolation level 隔离级别;```
## 索引
- 索引是在数据库的字段上添加的，为了提高查询效率存在的一种机制。
- 可以给一个字段或多个字段的联合添加索引。
- MySQL数据库中的索引需要排序，是一个二叉树数据结构。
	- 按左小右大原则存放，采用中序遍历方式取数据。
- 在任何数据库中主键上都会自动添加索引对象。在MySQL中，一个字段上如果有unique约束，也会自动创建索引对象。
- 在MySQL中，索引是一个单独的对象，在不同的存储引擎中存储在不同的位置。
>### 创建索引
>eg.给emp表的ename字段添加索引，起名emp_ename_index
>```create index emp_ename_index on emp(ename);```

>### 删除索引
>eg.删除emp表中emp_ename_index索引对象
>```drop index emp_ename_index on emp;```
### 索引失效的情况
- 模糊查询时以“%”开始。
- 使用or时，or两端其中一个字段没有索引。
- 使用复合索引时，没有使用左侧的列查找。
- 在where中，索引列参加了运算。
- 在where中。索引列使用了函数。
## 视图
- 以不同角度看待同一份数据。
- 创建视图对象：```create view 视图名 as select 字段名 from 表名;```
	- as 后的语句必须是DQL语句。
- 删除视图对象：```drop view 视图名;```
- 对视图对象进行增删改查，会影响原表的数据。
## DBA命令
- 导出数据 ：
	- 在windows的dos命令窗口中。
	```mysqldump 数据库名 >导出路径 -u用户名 -p密码```
	
- 导入数据：
	- 需要先登录到MySQL数据库服务器，然后创建数据库，使用数据库。
	```source 导入路径```
