-- approach : using Co-related Subquery
select  
    d.name as Department,
    e1.name as Employee,
    e1.salary as Salary
from Employee e1 inner join Department d
on e1.DepartmentId = d.id
where 3 > (
    select count(distinct (e2.Salary))
    from Employee e2
    where e2.Salary > e1.Salary and e1.DepartmentId=e2.DepartmentId
);



-- approach : using Window Function 
select d.name as Department, e.name as Employee, e.Salary
from Employee e inner join Department d 
on e.departmentId=d.id
where (d.name, e.salary) in (
    select name, salary
    from (
    select distinct d.name, e.salary, dense_rank() over(partition by d.name order by e.salary desc) as row_num
    from Employee e inner join Department d 
    on e.departmentId=d.id
    order by e.salary desc
    ) as top3_sal
    where row_num<=3 
    order by name
)
order by Department;