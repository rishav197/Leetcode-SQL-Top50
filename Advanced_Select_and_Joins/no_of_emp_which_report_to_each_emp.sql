select emp1.employee_id, emp1.name, count(*) as reports_count, round(avg(emp2.age), 0) as average_age  
from Employees emp1, Employees emp2
where emp1.employee_id=emp2.reports_to
group by emp1.employee_id
order by emp1.employee_id;


-- approach : a bit diff approach
select 
    e1.employee_id, 
    e1.name, 
    count(e2.employee_id) as reports_count, 
    ROUND(avg(e2.age), 0) as average_age
from Employees e1 inner join Employees e2
on e1.employee_id=e2.reports_to
group by e1.employee_id
order by e1.employee_id;
