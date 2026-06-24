select product_id, store, price
from 
(    
    select *,
    case 
        when rnk=1 then 'store1'
        when rnk=2 then 'store2'
        else 'store3'
    end as store,
    case 
        when rnk=1 then store1
        when rnk=2 then store2
        else store3
    end as price
    from (
        select prod3.*, row_number() over(partition by prod3.product_id order by prod3.product_id) as rnk
        from Products prod1, Products prod2, Products prod3
        
    ) as temp
    where rnk<=3
) as rslt
where price is not null;