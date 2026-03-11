select p.product_id, IFNULL(ROUND(sum(p.price*us.units)/sum(units), 2), 0)  as average_price 
from Prices p 
left join UnitsSold us 
on p.product_id=us.product_id and us.purchase_date between p.start_date and p.end_date 
group by p.product_id;