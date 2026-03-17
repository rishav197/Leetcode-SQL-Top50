-- approach : using IF() 
select *,
    IF(x+y>z and y+z>x and x+z>y, 'Yes', 'No') as triangle
from Triangle;



-- approach : using CASE statement
select x, y, z, 
case
    when (x + y) > z and (x + z) > y and (y + z) > x then 'Yes'
    else 'No'
end as triangle
from Triangle;