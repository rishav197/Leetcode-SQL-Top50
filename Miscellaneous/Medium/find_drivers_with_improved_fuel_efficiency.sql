with cte as (
    select driver_id,
        sum(if(month(trip_date)<=6, distance_km/fuel_consumed, null))/sum(if(month(trip_date)<=6, 1, 0)) as first_half_avg, 
        sum(if(month(trip_date)>6, distance_km/fuel_consumed, null))/sum(if(month(trip_date)>6, 1, 0)) as second_half_avg
    from trips
    group by driver_id
    having (first_half_avg is not null) and (second_half_avg is not null)
)
select d.*, 
    ROUND(c.first_half_avg, 2) as first_half_avg, 
    ROUND(c.second_half_avg, 2) as second_half_avg, 
    ROUND((second_half_avg-first_half_avg), 2) as efficiency_improvement
from cte c
left join drivers d
on c.driver_id=d.driver_id
where (second_half_avg-first_half_avg)>=0
order by efficiency_improvement desc, driver_name;