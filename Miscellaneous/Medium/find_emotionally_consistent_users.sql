-- approach1: 
with cte as (
    select *, count(distinct content_id) as react_cnt
    from reactions
    group by user_id, reaction
),
cte2 as (
select user_id, count(*) as cnt
from reactions
group by user_id
having cnt>=5
)
select user_id, reaction as dominant_reaction, ROUND(react_cnt/cnt, 2) as reaction_ratio  
from cte
left join cte2
using (user_id)
having reaction_ratio>=0.6
order by reaction_ratio desc, user_id;


-- approach 2 : optimized
with cte as (
    select user_id, reaction, count(distinct content_id) as num
    from reactions
    group by user_id, reaction
),
cte2 as (
    select *, sum(num) over(partition by user_id) as content_reactions, ROUND(num/sum(num) over(partition by user_id), 2) as reaction_ratio,
    row_number() over(partition by user_id order by num desc) as rnk
    from cte
)
select user_id, reaction as dominant_reaction, reaction_ratio
from cte2
where content_reactions>=5 
and reaction_ratio>=0.6 
and rnk=1
order by reaction_ratio desc, user_id;