select id, 
    sum(IF(month="Jan", revenue, NULL)) as Jan_Revenue, 
    sum(IF(month="Feb", revenue, NULL)) as Feb_Revenue, 
    sum(IF(month="Mar", revenue, NULL)) as Mar_Revenue,
    sum(IF(month="Apr", revenue, NULL)) as Apr_Revenue, 
    sum(IF(month="May", revenue, NULL)) as May_Revenue, 
    sum(IF(month="Jun", revenue, NULL)) as Jun_Revenue,
    sum(IF(month="Jul", revenue, NULL)) as Jul_Revenue, 
    sum(IF(month="Aug", revenue, NULL)) as Aug_Revenue, 
    sum(IF(month="Sep", revenue, NULL)) as Sep_Revenue,
    sum(IF(month="Oct", revenue, NULL)) as Oct_Revenue, 
    sum(IF(month="Nov", revenue, NULL)) as Nov_Revenue, 
    sum(IF(month="Dec", revenue, NULL)) as Dec_Revenue
from Department
group by id
order by id;