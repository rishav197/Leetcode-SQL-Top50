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

-- approach 2: Join, Window Funct, Case Statement & CTE used
WITH ranking AS (
    SELECT 
        pr.employee_id, 
        e.name,
        pr.rating,
        RANK() OVER (PARTITION BY pr.employee_id ORDER BY pr.review_date DESC) AS ranks
    FROM performance_reviews pr
    JOIN employees e ON pr.employee_id = e.employee_id
),
pivoted AS (
    SELECT 
        employee_id,
        name,
        MAX(CASE WHEN ranks = 1 THEN rating END) AS latest_rating,
        MAX(CASE WHEN ranks = 2 THEN rating END) AS sec_rating,
        MAX(CASE WHEN ranks = 3 THEN rating END) AS third_latest_rating
    FROM ranking
    GROUP BY employee_id, name
)
SELECT 
    employee_id,
    name,
    latest_rating - third_latest_rating AS improvement_score
FROM pivoted
WHERE latest_rating IS NOT NULL 
  AND third_latest_rating IS NOT NULL
  AND latest_rating > third_latest_rating 
  AND sec_rating > third_latest_rating
ORDER BY improvement_score DESC, name;