select season, category, total_quantity, total_revenue 
from (
    with cte as (
        select 
        case 
            when month(sale_date) in (12,1,2) then "Winter"
            when month(sale_date) in (3,4,5) then "Spring"
            when month(sale_date) in (6,7,8) then "Summer"
            else "Fall"
        end as season,
        p.category, 
        sum(quantity) as total_quantity,
        sum(s.quantity*s.price) as total_revenue
        from Sales s
        left join Products p
        on s.product_id=p.product_id
        group by season, category
        order by season, total_quantity desc, total_revenue desc, category
)
select *,
row_number() over(partition by season order by total_quantity desc, total_revenue desc, category) as rnk
from cte
) as tmp
where rnk=1;
