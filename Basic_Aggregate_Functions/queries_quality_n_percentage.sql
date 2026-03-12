select query_name, 
ROUND(avg(rating/position), 2) as quality, 
ROUND(avg(if(rating<3, 1, 0))*100, 2) as poor_query_percentage
from Queries group by query_name;