-- approach 1 : bruteforce
with cte1 as (
    select s.store_id, s.store_name, s.location, i.product_name, i.quantity, i.price,
    row_number() over(partition by s.store_id order by price desc) as rnk1
    from stores s
    left join inventory i
    on s.store_id=i.store_id
    group by s.store_id, i.inventory_id
),
cte2 as (
select s.store_id, i.product_name, i.quantity, i.price,
row_number() over(partition by s.store_id order by price) as rnk2
from stores s
left join inventory i
on s.store_id=i.store_id
group by s.store_id, i.inventory_id
),
rslt as (
    select
    c1.store_id, c1.store_name, c1.location, c1.product_name as most_exp_product, c1.quantity as qty1,
    c2.product_name as cheapest_product, c2.quantity as qty2, ROUND(c2.quantity/c1.quantity, 2) as imbalance_ratio,
    count(*) as cnt
    from cte1 c1, cte2 c2
    where c1.store_id=c2.store_id and c1.rnk1=c2.rnk2
    group by c1.store_id
    having cnt>=3 and c1.quantity<c2.quantity
    order by imbalance_ratio desc, store_name
)
select store_id, store_name, location, most_exp_product, cheapest_product, imbalance_ratio
from rslt;



-- approach 2 : Optimized approach (Prefer this)
with cte as (
    select *,
    row_number() over(partition by store_id order by price desc) as exp_rnk,
    row_number() over(partition by store_id order by price) as chp_rnk
    from inventory
), cte2 as (
select store_id, 
max(case when exp_rnk=1 then product_name else null end) as most_exp_product,
sum(case when exp_rnk=1 then quantity else 0 end) as exp_qty,
max(case when chp_rnk=1 then product_name else null end) as cheapest_product,
sum(case when chp_rnk=1 then quantity else 0 end) as chp_qty,
ROUND(sum(case when chp_rnk=1 then quantity else 0 end)/sum(case when exp_rnk=1 then quantity else 0 end), 2) as imbalance_ratio
from cte
group by store_id
having count(distinct product_name)>=3
)
select s.*, most_exp_product, cheapest_product, imbalance_ratio 
from cte2
left join stores as s
on cte2.store_id=s.store_id
where cte2.exp_qty<cte2.chp_qty
order by imbalance_ratio desc, store_name;
