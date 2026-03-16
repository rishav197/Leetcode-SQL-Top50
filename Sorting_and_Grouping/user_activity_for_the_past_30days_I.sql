-- Approach 1 : using date_sub() method
select activity_date as day, count(distinct user_id) as active_users 
from Activity where activity_date 
between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
group by day;


-- Approach 2 : Without using date_sub() method
select activity_date as day, count(distinct user_id) as active_users 
from Activity where activity_date>='2019-06-28' and activity_date<='2019-07-27'
group by day;