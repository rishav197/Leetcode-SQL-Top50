select distinct s.product_id, p.product_name
from Sales s left join product p
on s.product_id=p.product_id
where s.sale_date>='2019-01-01' and s.sale_date<='2019-03-31' 
and s.product_id not in (
    select product_id 
    from Sales
    where sale_date<'2019-01-01' or sale_date>'2019-03-31'
);