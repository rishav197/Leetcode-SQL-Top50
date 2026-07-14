with cte as (
    select pp1.product_id as product1_id, pp2.product_id as product2_id, count(*) as customer_count 
    from ProductPurchases pp1,ProductPurchases pp2
    where pp1.user_id=pp2.user_id and pp1.product_id<pp2.product_id
    group by pp1.product_id, pp2.product_id
    having customer_count>=3), 
cte2 as (
    select product1_id, product2_id, pi.category as product1_category, customer_count  
    from cte
    left join ProductInfo pi
    on product1_id=pi.product_id)
select product1_id, product2_id, product1_category, pi.category as product2_category, customer_count 
from cte2
left join ProductInfo pi
on cte2.product2_id=pi.product_id
order by customer_count desc, product1_id asc, product2_id asc;