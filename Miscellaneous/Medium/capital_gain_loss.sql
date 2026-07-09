-- approach1 : using Case Statement & group by
select stock_name,
sum(case
        when operation='Buy' then -1*price
        else price
    end) as capital_gain_loss 
from Stocks
group by stock_name


-- approach2 : using CTE & group by
with cte as (
select stock_name,
    sum(if(operation='Buy',price,0)) as buy,
    sum(if(operation='Sell',price,0)) as sell
from stocks 
group by stock_name 
)
select stock_name, (sell-buy) as capital_gain_loss   
from cte;