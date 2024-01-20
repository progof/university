-- Grupa 1 
-----------

-- Zadanie 1
-- Napisz polecenie, które dla wszystkich dorosłych członków biblioteki tworzy listę „proponowanych loginów e- mail”. "Proponowany_login" 
-- powinien zostać utworzony poprzez połączenie imienia członka biblioteki, trzech pierwszych liter nazwiska, oraz numeru karty bibliotecznej 
-- (member_no) - wszystko małymi literami. Interesują nas tylko dorośli czytelnicy, których nazwisko zaczynają się na literę z zakresu A do F. 
-- (zwróć uwagę na możliwe występowanie spacji w imieniu/nazwisku). Zbiór wynikowy powinien zawierać nr karty bibliotecznej (member_no), imię, nazwisko 
-- i wygenerowaną kolumnę "proponowany_login" (baza library)
use library;

select lower(replace(member.firstname, ' ', '') +
             substring(replace(member.lastname, ' ', ''), 1, 3) +
             replace(str(adult.member_no), ' ', '')
        ) as proponowany_login
from dbo.member right join dbo.adult
    on member.member_no = adult.member_no
where member.lastname like '[A-F]%';

SELECT CONCAT(FirstName, ' ', LastName) AS full_name FROM employees;

SELECT SUBSTRING('Hello, World!' FROM 1 FOR 5) AS result;

GETUTCDATE()

-- Zadanie 2
-- Dla każdego pracownika podaj jego imię, nazwisko, liczbę miesięcy które przepracował w firmie oraz 
-- liczbę zamówień obsłużonych przez tego pracownika w marcu 1997 (baza northwind)

SELECT e.FirstName, e.LastName, DATEDIFF(MONTH, e.HireDate, GETDATE()) AS MonthsWorked,
       COUNT(o.OrderID) AS OrdersInMay1997
FROM Employees AS e
LEFT JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 5
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.HireDate

-- Zadanie 3
-- Wyświetl listę dzieci będących członkami biblioteki, które w dniu '2001-12-14' zwróciły do biblioteki książkę dla której title_no = 12. 
-- Zbiór wynikowy powinien zawierać identyfikatory (member_no) tych dzieci (baza library)

SELECT DISTINCT m.member_no
FROM member AS m
JOIN loan AS i ON m.member_no = i.member_no
WHERE i.due_date > '2001-12-14'
    AND i.out_date = '2001-12-14'
    AND i.title_no = 12;

select *
from member right join juvenile
    on member.member_no = juvenile.member_no
left join dbo.loan on member.member_no = loan.member_no
where title_no = 12 and due_date = '2001-12-14';


SELECT * from loan

-- Zadanie 4
-- Wyświetl zamówienia złożone w 1997r. dla których krajem odbiorcy jest Argentyna. Zbiór wynikowy powinien zawierać nr zamówienia, 
-- datę wysyłki, opłatę za przesyłkę oraz nazwę przewoźnika (spedytora) (baza northwind)

SELECT o.OrderID, o.ShippedDate, o.Freight, s.CompanyName
FROM Orders as o JOIN Shippers as s
ON o.ShipVia = s.ShipperID
WHERE YEAR(o.OrderDate) = 1997 AND o.ShipCountry = 'Argentina'

EXCEPT

select OrderID, ShippedDate, Freight, Shippers.CompanyName
from dbo.Orders join dbo.Shippers on Orders.ShipVia = Shippers.ShipperID
where ShipCountry = 'Argentina' and Year(OrderDate) = 1997;

-- Zadanie 5
-- Wyświetl imiona i nazwiska pracowników, którzy nie obsługiwali zamówień w dniu 1997-09-05. Zbór wynikowy powinien zawierać imię, nazwisko 
-- oraz wiek (liczbę lat) pracownika (baza northwind)

SELECT e.LastName, e.FirstName, Year(CURRENT_TIMESTAMP) - Year(e.BirthDate)as Age
FROM employees as e LEFT JOIN orders as o
ON e.EmployeeID = o.EmployeeID 
WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 9 AND DAY(o.OrderDate) = 5 AND o.OrderDate IS NULL
group by e.EmployeeID having count(o.OrderID) = 0;
use Northwind;

select FirstName, LastName, Year(CURRENT_TIMESTAMP) - Year(BirthDate) as Old
from dbo.Employees where EmployeeID in (select Employees.EmployeeID
    from dbo.Employees left join dbo.Orders
        on Employees.EmployeeID = Orders.EmployeeID and OrderDate = '1997-09-05'
    group by Employees.EmployeeID having count(OrderID) = 0);

    

select  firstname + ' ' + lastname as name,city, postalcode
from employees
union
select companyname, city, postalcode
from customers

select t.orderid, t.CustomerID
 from (select orderid, customerid
         from orders) as t