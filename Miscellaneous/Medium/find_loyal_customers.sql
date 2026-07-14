with cte as (
    select *, 
    count(transaction_id) as Cnt,
    sum(if(transaction_type='refund', 1, 0))/count(transaction_id) as refundRate, 
    datediff(max(transaction_date), min(transaction_date)) as activeDays
    from customer_transactions
    group by customer_id
    having activeDays>=30 and count(transaction_id)>=3
    and refundRate<0.2
)
select customer_id  
from cte; 