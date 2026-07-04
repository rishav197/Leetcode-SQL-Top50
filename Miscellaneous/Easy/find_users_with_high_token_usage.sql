-- approach : using group by with agg funcs and derived table
select distinct p.user_id, t.prompt_count, t.avg_tokens
from (
    select user_id, count(*) as prompt_count, ROUND(avg(tokens), 2) as avg_tokens 
    from prompts
    group by user_id
) as t
left join prompts p
using(user_id)
where prompt_count>=3 and tokens>avg_tokens
order by avg_tokens desc, user_id;


-- approach : optimized, a bit diff than above
select user_id, count(*) as prompt_count, ROUND(avg(tokens), 2) as avg_tokens 
from prompts
group by user_id
having prompt_count>=3 and max(tokens)>avg_tokens 
order by avg_tokens desc, user_id;
