select e1.name
from Employee e1 inner join Employee e2 on e1.id=e2.managerID 
group by e2.managerID having count(e2.managerID)>=5;


-- almost same but a bit diff
select e1.name from Employee e1, Employee e2
where e1.id=e2.managerId
group by e1.id having count(*)>=5;