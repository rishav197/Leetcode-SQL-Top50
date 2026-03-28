-- approach : using Substr() function
select 
    user_id, 
    concat(upper(substr(name, 1, 1)), lower(substr(name, 2, length(name)))) as name
from Users
order by user_id;



-- approach : using left() & right() functions
select 
    user_id, 
    concat(upper(left(name, 1)), lower(right(name, length(name)-1))) as name
from Users
order by user_id;