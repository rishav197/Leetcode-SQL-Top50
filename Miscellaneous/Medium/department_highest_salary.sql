-- approach 1: using Co-related Subquery
select  
    d.name as Department,
    e1.name as Employee,
    e1.salary as Salary
from Employee e1 inner join Department d
on e1.departmentId = d.id
where 1 = (
    select count(distinct (e2.Salary))
    from Employee e2
    where e2.Salary >= e1.Salary and e1.DepartmentId=e2.DepartmentId
);


-- approach 2: using Window Function 
select Department, name as Employee, salary as Salary
from (
    select 
        d.name as Department, e.name, e.salary, 
        dense_rank() over(partition by d.name order by e.salary desc) as row_num
    from Employee e inner join Department d 
    on e.departmentId=d.id
    order by e.salary desc
) as temp
where temp.row_num=1
order by Department