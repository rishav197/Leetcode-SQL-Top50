-- approach 1: using Window Function
with cte as (
    SELECT
    student_id,
    subject,
    FIRST_VALUE(score) OVER(PARTITION BY student_id,subject ORDER BY exam_date) AS first_score,
    FIRST_VALUE(score) OVER(PARTITION BY student_id,subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores
)
select distinct *
from cte
where latest_score>first_score
order by student_id,subject;



-- approach 2: using Window Function & Join
with cte as (
    SELECT s1 .* , 
    s2.exam_date AS nxt_date, s2.score AS nxt_score, ROW_NUMBER() OVER(PARTITION BY s1.student_id, s1.subject ORDER BY s1.exam_date,s2.exam_date DESC) AS rnk
    FROM Scores AS s1
    LEFT JOIN Scores AS s2
    ON s1.student_id = s2.student_id
    AND s1.subject = s2.subject
    AND s1. exam_date < s2.exam_date
    WHERE s2. exam_date IS NOT NULL
)
select student_id, subject, score as first_score, nxt_score as latest_score
from cte 
where rnk=1 and nxt_score>score;

