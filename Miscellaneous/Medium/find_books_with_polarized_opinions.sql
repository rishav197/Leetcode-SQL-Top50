with cte as (
    select book_id, SUM(IF(session_rating>=4,1,0)) as high_ratings,
    SUM(IF(session_rating<=2,1,0)) as low_ratings, (max(session_rating)-min(session_rating)) as rating_spread, 
    ROUND(SUM(IF(session_rating>=4 or session_rating<=2,1,0))/count(*), 2) as polarization_score 
    from reading_sessions
    group by book_id
    having count(*)>=5
    and high_ratings>=1 and low_ratings>=1
    and polarization_score>=0.6
)
select c.book_id, b.title, b.author, b.genre, b.pages, c.rating_spread, c.polarization_score
from cte c
left join books b
on c.book_id=b.book_id
order by polarization_score desc, title desc;