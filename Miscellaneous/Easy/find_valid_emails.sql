select *
from Users
where email regexp '^[a-z0-9]+@[a-z]+\\.com$'
order by user_id;
