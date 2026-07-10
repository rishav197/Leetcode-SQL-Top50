-- approach1: 
select user_id, 
ROUND(sum(if(activity_type='free_trial', activity_duration, 0))/sum(if(activity_type='free_trial', 1, 0)), 2) as trial_avg_duration,
ROUND(sum(if(activity_type='paid', activity_duration, 0))/sum(if(activity_type='paid', 1, 0)), 2) as paid_avg_duration
from UserActivity
where user_id not in (
    select user_id
    from UserActivity
    group by user_id
    having sum(if(activity_type='free_trial' or activity_type='cancelled', 1,0))=count(*)
)
group by user_id
order by user_id;


-- approach2 : optimized approach
select user_id,
ROUND(avg(if(activity_type='free_trial', activity_duration, null)), 2) as trial_avg_duration,
ROUND(avg(if(activity_type='paid', activity_duration, null)), 2) as paid_avg_duration   
from UserActivity
group by user_id
having paid_avg_duration is not null
order by user_id;
