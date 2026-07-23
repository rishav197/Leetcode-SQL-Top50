-- approach : CTE, datediff(), self-join & groupby with agg funct used
with cte as (
    select c1.*, datediff(min(c2.test_date), min(c1.test_date)) as recovery_time 
    from covid_tests c1 
    inner join covid_tests c2
    on c1.patient_id = c2.patient_id and c1.test_date < c2.test_date 
    and c1.result = 'Positive' and c2.result = 'Negative'
    group by c1.patient_id
) 
select c.patient_id, p.patient_name, p.age, c.recovery_time
from cte c
left join patients p
on c.patient_id=p.patient_id 
order by c.recovery_time, p.patient_name; 