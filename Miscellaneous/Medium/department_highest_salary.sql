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