select emp2.name as Employee 
from Employee emp1, Employee emp2
where emp1.id=emp2.managerId and emp2.salary>emp1.salary;