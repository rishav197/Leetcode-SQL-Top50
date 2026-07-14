-- approach : Join, Window Funct & CTE used
with cte as (
    select *,
    row_number() over(partition by employee_id order by review_date desc) as rnk
    from performance_reviews pr
    left join employees e 
    using (employee_id)
), cte2 as (
select *,
IFNULL(LAG(rating) over(partition by employee_id order by review_date), 0) as prevRating
from cte
where rnk<=3
)
select employee_id, name, max(rating)-min(rating) as improvement_score
from cte2
where rating>prevRating
group by employee_id
having count(*)>=3
order by improvement_score desc,name;