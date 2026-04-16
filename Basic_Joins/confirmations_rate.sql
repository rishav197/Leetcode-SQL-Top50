-- Approach: Using IFNULL()
select s.user_id, IFNULL(ROUND(sum(action='confirmed')/count(*), 2), 0.00) as confirmation_rate
from Signups s left join Confirmations c 
on s.user_id=c.user_id group by s.user_id;


-- Approach: Without using IFNULL()
select s.user_id, ROUND(sum(if(c.action='confirmed', 1, 0))/count(*), 2) as confirmation_rate 
from Signups s left join Confirmations c 
on s.user_id=c.user_id
group by s.user_id;