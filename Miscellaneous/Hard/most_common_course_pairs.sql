-- approach 1 : Wind funct ( LEAD() ), CTE & groupby used
with top_perf as (
    select user_id
    from course_completions
    group by user_id
    having count(distinct course_id)>=5 and avg(course_rating)>=4
), 
course_info as (
    select *, LEAD(course_name, 1) over(partition by user_id order by completion_date) as second_course
    from course_completions
    where user_id in (
        select user_id
        from top_perf
    )
)
select course_name as first_course, second_course, count(distinct user_id) as transition_count 
from course_info
where second_course is not null
group by first_course, second_course
order by transition_count desc, first_course, second_course;


-- approach 2 : Self-Join, RANK(), CTE & groupby used
with cte as (
    select *,
    row_number() over(partition by user_id order by completion_date) as rnk
    from course_completions
    where user_id in (
        select user_id
        from course_completions
        group by user_id
        having count(distinct course_id)>=5 and avg(course_rating)>=4
    )
)
select c1.course_name as first_course, c2.course_name as second_course, count(*) as transition_count 
from cte c1, cte c2
where c1.user_id=c2.user_id and c1.rnk=c2.rnk-1
group by c1.course_id, c2.course_id
order by transition_count desc, c1.course_name, c2.course_name