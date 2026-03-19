-- approach : Using Windo Function for Cumulative Sum
select person_name 
from 
(
    select *,
    sum(weight) over (order by turn) as cumWt 
    from Queue 
    order by turn
) as temp 
where cumWt<=1000 
order by cumWt desc limit 1;