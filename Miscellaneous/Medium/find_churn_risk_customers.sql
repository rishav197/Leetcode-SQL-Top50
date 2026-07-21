with cte as (
    select *,
    row_number() over(partition by user_id order by event_date desc) as rnk
    from subscription_events
)
select user_id, plan_name as current_plan, monthly_amount as current_monthly_amount, max(monthly_amount) as max_historical_amount, 
datediff(max(event_date),min(event_date)) as days_as_subscriber
from cte
group by user_id
having plan_name='basic'
and sum(if(event_type='downgrade',1,0))>=1
and monthly_amount/max(monthly_amount)<0.5
and days_as_subscriber>=60
order by days_as_subscriber desc, user_id;