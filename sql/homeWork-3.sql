-- HomeWork
-- library
use library

-- dla każdego dorosłego czytenika podaj liczbę jego dzieci
SELECT j.member_no, j.adult_member_no, j.birth_date, m.lastname, m.firstname, m.middleinitial
FROM juvenile j
JOIN member m ON j.adult_member_no = m.member_no
WHERE DATEDIFF(YEAR, j.birth_date, GETDATE()) >= 18;


-- dla każdego dorosłego czytenika mieszkającego w Arizonie (AZ)
-- podaj liczbę jego dzieci
SELECT
    a.member_no,
    a.street,
    a.city,
    a.state,
    a.zip,
    a.phone_no,
    a.expr_date,
    COUNT(j.member_no) AS number_of_children
FROM
    adult a
JOIN
    juvenile j ON a.member_no = j.adult_member_no
WHERE
    a.state = 'AZ' AND DATEDIFF(YEAR, j.birth_date, GETDATE()) >= 18
GROUP BY
    a.member_no,
    a.street,
    a.city,
    a.state,
    a.zip,
    a.phone_no,
    a.expr_date;


-- dla każdego tytułu podaj ile razy któżka danego tytułu była
-- zwrócona do biblioteki w 2001 r

SELECT
    t.title,
    COUNT(*) AS loan_count
FROM
    title t
JOIN
    item i ON t.title_no = i.title_no
JOIN
    loanhist lh ON i.isbn = lh.isbn
WHERE
    YEAR(lh.out_date) = 2001
GROUP BY
    t.title;




-- dla każdego tytułu podaj średną liczbę dni przed które 
-- książka danego tytułu była czytana 2001 r

SELECT
    t.title,
    AVG(DATEDIFF(day, lh.out_date, lh.in_date)) AS avg_days_read
FROM
    title t
JOIN
    item i ON t.title_no = i.title_no
JOIN
    loanhist lh ON i.isbn = lh.isbn
WHERE
    YEAR(lh.out_date) = 2001 AND lh.in_date IS NOT NULL
GROUP BY
    t.title;
