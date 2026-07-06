select employee_id 
from (
    select e.employee_id, name, salary
    from Employees e
    left join Salaries s 
    on e.employee_id=s.employee_id
    where s.salary is null
    union
    select s.employee_id, name, salary
    from Salaries s  
    left join Employees e
    on s.employee_id=e.employee_id
    where name is null
) as temp
order by employee_id;
