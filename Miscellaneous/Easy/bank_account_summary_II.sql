select u.name, sum(amount) as balance
from Transactions t 
left join Users u 
on t.account=u.account
group by t.account
having sum(t.amount)>10000;
