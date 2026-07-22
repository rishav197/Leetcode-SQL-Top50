/* approach : using CTE, groupby with agg funct & Date funct (YEARWEEK(date, mode))

note: Always use YEARWEEK() instead of WEEK() funct
*/

with cte as (
    select employee_id,meeting_date,
    YEARWEEK(meeting_date, 1) as week_monday, 
    sum(duration_hours) as week_hrs, 
    if(sum(duration_hours)>20, 'Y', 'N') as meeting_heavy
    from meetings
    group by employee_id, week_monday 
)
select c.employee_id, e.employee_name, e.department, count(*) as meeting_heavy_weeks 
from cte as c
left join employees e
on c.employee_id = e.employee_id
where c.meeting_heavy='Y'
group by c.employee_id
having meeting_heavy_weeks>=2
order by meeting_heavy_weeks desc, e.employee_name;