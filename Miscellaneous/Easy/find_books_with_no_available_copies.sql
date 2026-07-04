select book_id, title, author, genre, publication_year, current_borrowers
from (
    select lb.*,
    sum(if(br.return_date is null, 1, 0)) as current_borrowers 
    from borrowing_records br
    left join library_books lb
    on br.book_id=lb.book_id
    group by lb.book_id
    having current_borrowers=lb.total_copies
) as temp
order by current_borrowers desc, title;
