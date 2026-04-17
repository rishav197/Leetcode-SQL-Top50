select (
    select num
    from MyNumbers
    group by num having count(*)=1
    order by num desc limit 1
) as num


-- approach : almost same as above one
select max(num) as num 
from MyNumbers 
where num in (
    select num
    from MyNumbers
    group by num 
    having count(*)=1
);