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


-- approach : Using JOINS only
select q1.person_name
from Queue q1 inner join Queue q2
on q1.turn>=q2.turn
group by q1.turn
having sum(q2.weight)<=1000
order by sum(q2.weight) desc
limit 1;
