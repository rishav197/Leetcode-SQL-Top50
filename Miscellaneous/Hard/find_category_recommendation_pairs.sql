with cte as (
    select pp.product_id, pp.user_id, pi.category   
    from ProductPurchases pp 
    left join ProductInfo pi
    using (product_id)
)
select c1.category as category1, c2.category as category2, count(distinct c1.user_id) as customer_count 
from cte c1, cte c2
where c1.user_id=c2.user_id
and c1.category<c2.category
group by c1.category, c2.category
having customer_count>=3
order by customer_count desc, category1, category2;