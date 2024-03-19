-- Zadanie domowe
-- from file 1_3_polecenie_select_koncowe

USE library;

-- Ćwiczenie 1

-- 1. Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki
SELECT title, title_no FROM title;

-- 2. Napisz polecenie, które wybiera tytuł o numerze 10
SELECT title, title_no 
FROM title 
WHERE title_no = 10;

-- 3. Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tyułu) 
-- i autora z tablicy title dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen
SELECT title_no, author 
FROM title 
WHERE author = 'Charles Dickens' OR  author = 'Jane Austen';


-- Ćwiczenie 2

-- 1. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich książek, których tytuły zawierających słowo „adventure”
SELECT title_no, title 
FROM title 
WHERE title  LIKE '%adventure%';

-- 2. Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę
SELECT member_no, fine_paid 
FROM loanhist
WHERE fine_paid IS NOT NULL;

-- 3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
SELECT DISTINCT city, state FROM adult;

-- 4. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
SELECT title FROM title ORDER BY title ASC;


-- Ćwiczenie 3

-- 1. Napisz polecenie, które:
-- – wybiera numer członka biblioteki (member_no), isbn książki (isbn) i watrość naliczonej kary (fine_assessed) z tablicy loanhist 
-- dla wszystkich wypożyczeń dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed)
-- – stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
-- – stwórz alias ‘double fine’ dla tej kolumny
SELECT member_no, isbn, fine_assessed, fine_assessed * 2 AS [double fine] 
FROM loanhist
WHERE fine_assessed IS NOT NULL;

-- SELECT member_no, isbn, fine_assessed,       fine_assessed * 2 AS double_fine,       (fine_assessed * 2) - fine_assessed AS diffFROM dbo.loanhist 
-- WHERE fine_assessed IS NOT NULL AND (fine_assessed * 2) - fine_assessed > 3ORDER BY diff;


-- Ćwiczenie 4 ???????????

-- 1. Napisz polecenie, które
-- – generuje pojedynczą kolumnę, która zawiera kolumny: firstname (imię członka biblioteki), middleinitial (inicjał drugiego imienia) 
-- i lastname (nazwisko) z tablicy member dla wszystkich członków biblioteki, którzy nazywają się Anderson
-- – nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla kolumny)
-- – zmodyfikuj polecenie, tak by zwróciło „listę proponowanych loginów e-mail” utworzonych przez połączenie imienia członka biblioteki, 
-- z inicjałem drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko małymi małymi literami).
-- – Wykorzystaj funkcję SUBSTRING do uzyskania części kolumny znakowej oraz LOWER do zwrócenia wyniku małymi literami. Wykorzystaj operator (+) do połączenia stringów.
SELECT lower(replace(firstname, ' ', '') + middleinitial + substring(lastname, 1, 2))
FROM member
WHERE lastname = 'Anderson'
ORDER BY firstname;


SELECT 
    CONCAT(LOWER(firstname), 
           IFNULL(CONCAT(SUBSTRING(LOWER(middleinitial), 1, 1), ''), ''), 
           SUBSTRING(LOWER(lastname), 1, 2)
          ) AS email_name
FROM member
WHERE lastname = 'Anderson';


select lower(replace(firstname, ' ', '') + middleinitial + substring(lastname, 1, 2)) as email_namefrom dbo.memberwhere lastname = 'Anderson';

-- Ćwiczenie 5

-- 1.Napisz polecenie, które wybiera title i title_no z tablicy title.
-- Wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie poniżej:
-- The title is: Poems, title number 7
-- Czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu o wyrażenie, które łączy 4 elementy:
-- stała znakowa ‘The title is:’ wartość kolumny title
-- stała znakowa ‘title number’ wartość kolumny title_no

SELECT CONCAT('The title is: ', title, ', title number ', title_no) AS result
FROM title;

SELECT 'The title is: ' + title, + ' title number ' + CAST(title_no AS varchar) AS result
FROM title;