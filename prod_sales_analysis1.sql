select p.product_name, s.year, s.price 
from Sales s LEFT JOIN Product p on s.product_id=p.product_id;
