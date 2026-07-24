with cte as (
    select customer_id, count(*) as total_orders,
    ROUND((SUM(IF((time(order_timestamp)>='11:00:00' and time(order_timestamp)<='14:00:00') or (time(order_timestamp)>='18:00:00' and time(order_timestamp)<='21:00:00'), 1, 0))/count(*))*100, 0) as peak_hour_percentage, 
    ROUND(avg(order_rating), 2) as average_rating,
    ROUND((sum(if(order_rating is not null, 1, 0))/count(*))*100, 2) as rated_orders
    from restaurant_orders
    group by customer_id
    having total_orders>=3
    and peak_hour_percentage>=60
    and average_rating>=4
    and rated_orders>=50
)
select customer_id, total_orders, peak_hour_percentage, average_rating
from cte
order by average_rating desc, customer_id desc;