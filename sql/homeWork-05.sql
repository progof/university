use northwind;
-- Ćwiczenia 1
-- 1.1 Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza northwind)
SELECT 
    e.EmployeeID AS EmployeeID,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName,
    e.ReportsTo AS ReportsTo,
    m.FirstName AS ManagerFirstName,
    m.LastName AS ManagerLastName
FROM Employees AS e
LEFT JOIN Employees AS m ON e.ReportsTo = m.EmployeeID
ORDER BY ReportsTo, EmployeeID;


USE Northwind
SELECT emp1.firstname + emp1.lastname AS 'Pracownik', emp2.firstname + emp2.lastname AS 'Podwładny' 
FROM Employees AS emp1
INNER JOIN Employees AS emp2 ON emp1.Employeeid = emp2.reportsTo

SELECT * FROM EMPLOYEES

-- 1.2 Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
SELECT 
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName,
    m.FirstName AS ManagerFirstName,
    m.LastName AS ManagerLastName
FROM Employees AS e
LEFT JOIN Employees AS m ON e.ReportsTo = m.EmployeeID
WHERE e.EmployeeID NOT IN (SELECT DISTINCT ReportsTo FROM Employees WHERE ReportsTo IS NOT NULL);


SELECT emp1.firstname + emp1.lastname AS 'podwladny' 
FROM Employees AS emp1
LEFT OUTER JOIN Employees AS emp2 ON emp1.Employeeid = emp2.reportsTo
WHERE emp2.Employeeid IS NULL

-- 1.3 Napisz polecenie, które wyświetla pracowników, którzy mają podwładnych (baza northwind)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName
FROM Employees AS e
WHERE e.EmployeeID IN (SELECT DISTINCT ReportsTo FROM Employees WHERE ReportsTo IS NOT NULL);


use library;
-- Ćwiczenia 2
-- 2.1 Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają  więcej niż dwoje dzieci zapisanych do biblioteki
SELECT member.lastname, member.firstname, adult.state, COUNT(*) AS liczba 
FROM member
INNER JOIN adult ON member.member_no = adult.member_no
INNER JOIN juvenile ON juvenile.adult_member_no = adult.member_no
WHERE adult.state = 'AZ'
GROUP BY member.firstname, member.lastname, member.member_no, adult.state
HAVING COUNT (*) > 2

-- 2.2 Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają  więcej niż dwoje dzieci zapisanych do biblioteki 
-- oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki
SELECT member.lastname, member.firstname, adult.state, COUNT(*) AS liczba 
FROM member
INNER JOIN adult ON member.member_no = adult.member_no
INNER JOIN juvenile ON juvenile.adult_member_no = adult.member_no
WHERE adult.state = 'AZ'
GROUP BY member.firstname, member.lastname, member.member_no, adult.state
HAVING COUNT (*) > 2
UNION
SELECT member.lastname, member.firstname, adult.state, COUNT(*) AS liczba 
FROM member
INNER JOIN adult ON member.member_no = adult.member_no
INNER JOIN juvenile ON juvenile.adult_member_no = adult.member_no
WHERE adult.state = 'CA'
GROUP BY member.firstname, member.lastname, member.member_no, adult.state
HAVING COUNT (*) > 3