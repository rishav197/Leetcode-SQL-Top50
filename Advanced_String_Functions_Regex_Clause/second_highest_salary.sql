-- approach : Co-related Subquery
select
(
    select distinct(e1.salary) 
    from Employee e1
    where 2 = (
        select count(distinct e2.salary)
        from Employee e2
        where e2.salary>=e1.salary
    )
) as SecondHighestSalary;



-- approach : Using Window Function ( Dense_rank() )
select (
    select distinct salary
    from (
        select 
            salary,
            dense_rank() over (order by salary desc) as rnk
        from Employee
        ) as RankedSalaries
    where rnk=2
) as SecondHighestSalary;


-- approach : Using Limit and Offset
select (
    select distinct(salary)
    from Employee
    order by salary desc
    limit 1 offset 1
) as SecondHighestSalary; 


-- approach : Using Inner Join (least intuitive)
select max(e1.salary) as SecondHighestSalary 
from Employee e1 
inner join Employee e2
where e2.salary>e1.salary;
