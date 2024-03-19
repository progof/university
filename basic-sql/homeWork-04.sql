-- !!!!!Home work 3.0 set - all tasks


-- Ćwiczenia 1
-- 1.1 Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma ‘United Package’
SELECT DISTINCT c.CompanyName, c.Phone, s.CompanyName
FROM Customers as c JOIN Orders as o
    ON c.CustomerID = o.CustomerID
JOIN Shippers as s
    ON s.ShipperID = o.ShipVia
WHERE s.CompanyName = 'United Package' AND Year(o.OrderDate) = 1997


-- 1.2 Wybierz nazwy i numery telefonów klientów , którym w 1997 roku 
-- przesyłek nie dostarczała firma ‘United Package’
SELECT DISTINCT c.CustomerID, c.CompanyName, c.Phone, s.CompanyName 
FROM Customers as c 
    LEFT OUTER JOIN Orders as o ON c.CustomerID = o.CustomerID
    JOIN Shippers as s ON s.ShipperID = o.ShipVia
WHERE s.CompanyName != 'United Package' AND Year(o.OrderDate) = 1997
ORDER BY c.CompanyName

select customers.customerid, customers.companyname, customers.phone
from orders
join shippers
on orders.shipvia = shippers.shipperid and shippers.CompanyName = 'United Package' and year(orderdate) = 1997
right outer join customers
on customers.customerid = orders.customerid
where orders.orderid is null

-- 1.3 Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty  
-- z kategorii ‘Confections’
SELECT DISTINCT c.CompanyName, c.Phone, cat.CategoryName
FROM Customers as c 
    JOIN Orders as o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] as od ON od.OrderID = o.OrderID
    JOIN Products as p ON p.ProductID = od.ProductID
    Join Categories as cat ON cat.CategoryID = p.CategoryID
        WHERE cat.CategoryName = 'Confections'

-- 1.4 Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii ‘Confections’
SELECT DISTINCT c.CompanyName, c.Phone, cat.CategoryName
FROM Customers as c 
    JOIN Orders as o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] as od ON od.OrderID = o.OrderID
    JOIN Products as p ON p.ProductID = od.ProductID
    Join Categories as cat ON cat.CategoryID = p.CategoryID
        WHERE cat.CategoryName <> 'Confections'

select distinct c.CompanyName, c.Phone
from dbo.Customers as c
where NOT EXISTS(
    select 1
        from dbo.Orders as o
        join dbo.[Order Details] as od on o.OrderID = od.OrderID
        join dbo.Products as p on od.ProductID = p.ProductID
        join dbo.Categories as cat on p.CategoryID = cat.CategoryID
        where c.CustomerID = o.CustomerID and cat.CategoryName = 'Confections')



-- 1.5 Wybierz nazwy i numery telefonów klientów, którzy w 1997r nie kupowali produktów z kategorii ‘Confections’
SELECT DISTINCT c.CompanyName, c.Phone, cat.CategoryName
FROM Customers as c 
    JOIN Orders as o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] as od ON od.OrderID = o.OrderID
    JOIN Products as p ON p.ProductID = od.ProductID
    Join Categories as cat ON cat.CategoryID = p.CategoryID
        WHERE cat.CategoryName <> 'Confections' AND Year(o.OrderDate) = 1997

-- Ćwiczenia 2
-- 2.1 Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). 
-- Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
use library;

SELECT m.lastname, m.firstname, j.birth_date, a.state, a.zip, a.city, a.street
FROM member as m
    JOIN juvenile as j ON j.member_no = m.member_no
    LEFT JOIN adult as a ON a.member_no = m.member_no



-- 2.2 Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). 
-- Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.

-- Ćwiczenia 3

-- 3.1 Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza northwind)
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

-- 3.2 Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
SELECT 
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName,
    m.FirstName AS ManagerFirstName,
    m.LastName AS ManagerLastName
FROM Employees AS e
LEFT JOIN Employees AS m ON e.ReportsTo = m.EmployeeID
WHERE e.EmployeeID NOT IN (SELECT DISTINCT ReportsTo FROM Employees WHERE ReportsTo IS NOT NULL);

-- 3.3 Napisz polecenie, które wyświetla pracowników, którzy mają podwładnych (baza northwind)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName
FROM Employees AS e
WHERE e.EmployeeID IN (SELECT DISTINCT ReportsTo FROM Employees WHERE ReportsTo IS NOT NULL);


--Ćwiczenia 4

-- 4.1 Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają  więcej niż dwoje dzieci zapisanych do biblioteki

-- 4.2 Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają  więcej niż dwoje dzieci zapisanych do biblioteki 
-- oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki