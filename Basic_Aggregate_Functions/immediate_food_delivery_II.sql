-- approach : Optimized approach (without any CTE)
select 
    ROUND((sum(if(order_date=customer_pref_delivery_date, 1, 0))/count(distinct customer_id))*100, 2) as immediate_percentage
from Delivery 
where (customer_id, order_date) in (
    select customer_id, MIN(order_date) as first_order_date
    from Delivery
    group by customer_id
);


-- approach : Brute Force
with cte1 as (
select *,
first_value(order_date) over(partition by customer_id order by order_date) as first_order
from Delivery order by customer_id, order_date
), 
cte2 as (
select *,
case 
    when first_order!=customer_pref_delivery_date then 'scheduled'
    else 'immediate' 
end as delivery_type
from cte1
group by customer_id, first_order)
select ROUND((sum(delivery_type='immediate')/count(*))*100, 2) as immediate_percentage 
from cte2;
