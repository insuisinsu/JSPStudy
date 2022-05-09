drop table emp_copy
create table emp_copy
as
select * from employee;
select * from emp_copy