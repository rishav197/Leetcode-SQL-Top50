with act_cte as 
    (select a1.machine_id, ROUND(a2.timestamp-a1.timestamp, 3) as time from Activity a1, Activity a2 
    where a1.activity_type='start' and a2.activity_type='end' and a1.machine_id=a2.machine_id and a1.process_id=a2.process_id)
select machine_id, ROUND(avg(time), 3) as processing_time from act_cte group by machine_id;
