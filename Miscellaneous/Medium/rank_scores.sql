-- approach: window func used i.e. dense_rank()
select score,
dense_rank() over(order by score desc) as "rank"
from Scores;
