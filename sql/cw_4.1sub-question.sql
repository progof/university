------------------------
-- Sub question tasks --
------------------------


-- Ćwiczenie 1.
-- 1.1 Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)
SELECT Orders.OrderID
    ,(SELECT SUM(UnitPrice * Quantity * (1 - Discount))  
        FROM [Order Details] 
        WHERE [Order Details].OrderID = Orders.OrderID) + Orders.Freight AS TotalOrderValue
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderID = 10250;


-- 1.2 Podaj łączną wartość każdego zamówienia (uwzględnij cenę za przesyłkę)
SELECT distinct Orders.OrderID
    ,(SELECT SUM(UnitPrice * Quantity * (1 - Discount))  
        FROM [Order Details] 
        WHERE [Order Details].OrderID = Orders.OrderID) + Orders.Freight AS TotalOrderValue
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID

-- 1.3 Dla każdego produktu podaj maksymalną wartość zakupu tego produktu
SELECT ProductID
        ,(SELECT MAX(UnitPrice * Quantity) 
        FROM [Order Details] AS OD2 
        WHERE OD2.ProductID = OD.ProductID) AS MaxPurchaseValue
FROM [Order Details] AS OD
GROUP BY ProductID;

-- 1.4 Dla każdego produktu podaj maksymalną wartość zakupu tego produktu w 1997r
SELECT ProductID
        ,(SELECT MAX(UnitPrice * Quantity) 
        FROM [Order Details] AS OD2 
        WHERE OD2.ProductID = OD.ProductID) AS MaxPurchaseValue
FROM [Order Details] AS OD
WHERE OD.OrderID IN (SELECT OrderID FROM Orders WHERE YEAR(OrderDate) = 1997)
GROUP BY ProductID;

-- Ćwiczenie 2.
-- 2.1 Dla każdego klienta podaj łączną wartość jego zamówień (bez opłaty za przesyłkę) z 1996r

SELECT COUNT(*) FROM Customers


SELECT Customers.CustomerID, Customers.CompanyName, ISNULL(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 0) AS TotalOrderValue
FROM Orders AS o
    JOIN [Order Details] AS od ON o.OrderID = od.OrderID
AND YEAR(o.OrderDate) = 1996
    RIGHT JOIN Customers ON Customers.CustomerID = o.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName
ORDER BY TotalOrderValue DESC


SELECT ISNULL(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 0) AS TotalOrderValue
FROM Orders AS o
    JOIN [Order Details] AS od ON o.OrderID = od.OrderID
AND YEAR(o.OrderDate) = 1996 AND o.CustomerID =  'FOLKO'



SELECT c.CustomerID, c.CompanyName,
    (
        SELECT ISNULL(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)+ o.Freight), 0) 
        FROM Orders AS o
            JOIN [Order Details] AS od ON o.OrderID = od.OrderID
            AND YEAR(o.OrderDate) = 1996 AND o.CustomerID =  c.CustomerID
    ) AS TotalOrderValue
FROM Customers AS c
ORDER BY TotalOrderValue DESC


-- 2.2 Dla każdego klienta podaj łączną wartość jego zamówień 
-- (uwzględnij opłatę za przesyłkę) z 1996r
SELECT c.CustomerID, c.CompanyName,
        (
            SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
            FROM [Order Details] AS od 
            JOIN Orders AS o ON o.OrderID = od.OrderID
            WHERE YEAR(o.OrderDate) = 1996 AND  o.CustomerID = c.CustomerID
        )
        +
        (
            SELECT SUM(Freight) 
            FROM Orders AS o
            WHERE o.CustomerID = c.CustomerID AND YEAR(o.OrderDate) = 1996
        ) AS OrderSum
FROM Customers AS c
ORDER BY OrderSum DESC

SELECT 
(SELECT SUM(Freight) 
FROM Orders AS o
WHERE o.CustomerID = 'QUICK' AND YEAR(o.OrderDate) = 1996 )
+
(SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
FROM [Order Details] AS od
    JOIN Orders AS o ON o.OrderID = od.OrderID
    WHERE o.CustomerID = 'QUICK' AND YEAR(o.OrderDate) = 1996)

-- 2.3 Dla każdego klienta podaj maksymalną wartość zamówienia złożonego przez tego klienta w 1997r

SELECT c.CustomerID, c.CompanyName, MAX(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS MaxOrderValue
FROM Customers AS c
    JOIN Orders AS o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] AS od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997 
GROUP BY c.CustomerID, c.CompanyName


SELECT c.CustomerID, c.CompanyName, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalOrderValue
FROM Customers AS c
    JOIN Orders AS o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] AS od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1996 AND c.CompanyName LIKE 'Alfreds Futterkiste'
GROUP BY c.CustomerID, c.CompanyName



-- Ćwiczenie 3.
-- 3.1 Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko oraz liczbę jego dzieci.
-- 3.2 Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci, liczbę zarezerwowanych książek oraz liczbę wypożyczonych książek.
-- 3.3 Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci, oraz liczbę książek zarezerwowanych i wypożyczonych przez niego i jego dzieci.
-- 3.4 Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2001r
-- 3.5 Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2002r


-- Ćwiczenie 4.
-- 4.1 Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
select cu.CompanyName, cu.Address, cu.City
from Customers as cu
where cu.CustomerID not in (select c.CustomerID
                            from Customers as c
                            left join Orders as o on c.CustomerID = o.CustomerID
                            where YEAR(o.OrderDate) = 1997)

-- 4.2 Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma United Package.
SELECT distinct c.CompanyName, c.Phone, s.CompanyName
FROM Orders AS o
    JOIN Customers AS c ON o.CustomerID = c.CustomerID
    JOIN Shippers AS s ON s.ShipperID = o.ShipVia 
WHERE YEAR(o.OrderDate) = 1997 AND s.CompanyName = 'United Package'
ORDER BY c.CompanyName


select distinct CustomerID, CompanyName, Phone
from Customers
where CustomerID in (select CustomerID from Orders where YEAR(OrderDate) = 1997 and
                    ShipVia in (select ShipperID from Shippers where CompanyName = 'United Package'))


-- 4.3 Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłek nie dostarczała firma United Package.
SELECT distinct c.CompanyName, c.Phone, s.CompanyName
FROM Orders AS o
    JOIN Customers AS c ON o.CustomerID = c.CustomerID
    JOIN Shippers AS s ON s.ShipperID = o.ShipVia 
WHERE YEAR(o.OrderDate) = 1997 AND s.CompanyName = 'United Package'
ORDER BY c.CompanyName



-- 4.4 Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.
SELECT distinct c.CompanyName, c.Phone, cat.CategoryName
FROM Orders AS o
    JOIN Customers AS c ON o.CustomerID = c.CustomerID
    JOIN [Order Details] AS od ON od.OrderID = o.OrderID
    JOIN Products AS p ON p.ProductID = od.ProductID
    JOIN Categories AS cat ON cat.CategoryID = p.CategoryID 
WHERE cat.CategoryName = 'Confections'
ORDER BY c.CompanyName

SELECT DISTINCT c.CompanyName, c.Phone
FROM Customers AS c
WHERE c.CustomerID IN (
    SELECT o.CustomerID
    FROM Orders AS o
    JOIN [Order Details] AS od ON od.OrderID = o.OrderID
    JOIN Products AS p ON p.ProductID = od.ProductID
    JOIN Categories AS cat ON cat.CategoryID = p.CategoryID
    WHERE cat.CategoryName = 'Confections'
)
ORDER BY c.CompanyName;


-- 4.5 Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.

SELECT DISTINCT c.CompanyName, c.Phone
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT o.CustomerID
    FROM Orders AS o
    JOIN [Order Details] AS od ON od.OrderID = o.OrderID
    JOIN Products AS p ON p.ProductID = od.ProductID
    JOIN Categories AS cat ON cat.CategoryID = p.CategoryID
    WHERE cat.CategoryName = 'Confections' AND o.CustomerID = c.CustomerID
) 
ORDER BY c.CompanyName;


SELECT DISTINCT c.CompanyName, c.Phone
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT o.CustomerID
    FROM Orders AS o
    JOIN [Order Details] AS od ON od.OrderID = o.OrderID
    JOIN Products AS p ON p.ProductID = od.ProductID
    JOIN Categories AS cat ON cat.CategoryID = p.CategoryID
    WHERE cat.CategoryName = 'Confections' AND o.CustomerID = c.CustomerID
) 
ORDER BY c.CompanyName;


-- 4.6 Wybierz nazwy i numery telefonów klientów, którzy w 1997r nie kupowali produktów z kategorii Confections.
SELECT DISTINCT c.CompanyName, c.Phone
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT o.CustomerID
    FROM Orders AS o
    JOIN [Order Details] AS od ON od.OrderID = o.OrderID
    JOIN Products AS p ON p.ProductID = od.ProductID
    JOIN Categories AS cat ON cat.CategoryID = p.CategoryID
    WHERE cat.CategoryName = 'Confections' AND o.CustomerID = c.CustomerID AND YEAR(o.OrderDate) = 1997
) 
ORDER BY c.CompanyName;

-- Ćwiczenie 5.
-- 5.1 Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu
SELECT * FROM Products

SELECT *
FROM Products
WHERE UnitPrice < (SELECT MAX(UnitPrice) 
                    FROM Products WHERE UnitPrice > 0);

SELECT *
FROM Products
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products);


-- 5.2 Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu danej kategorii
SELECT ProductName, 
    ( SELECT CategoryName
        FROM Categories AS c
        WHERE p.CategoryID = c.CategoryID
     ) as Category
FROM Products AS p
WHERE UnitPrice < (SELECT MAX(UnitPrice) 
                    FROM Products WHERE UnitPrice > 0);
-- 5.3 Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich produktów oraz różnicę między ceną produktu a średnią ceną wszystkich produktów
-- 5.4 Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią cenę wszystkich produktów danej kategorii oraz różnicę między ceną produktu a średnią ceną wszystkich produktów danej kategorii


-- Ćwiczenie 6.
-- 6.1 Podaj produkty kupowane przez więcej niż jednego klienta
-- 6.2 Podaj produkty kupowane w 1997r przez więcej niż jednego klienta
-- 6.3 Podaj nazwy klientów którzy w 1997r kupili co najmniej dwa różne produkty z kategorii 'Confections'


-- Ćwiczenia 7
-- 7.1 Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika, przy obliczaniu wartości zamówień uwzględnij cenę za przesyłkę
-- 7.2 Który z pracowników był najaktywniejszy (obsłużył zamówienia o największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika
-- 7.3 Ogranicz wynik z pkt 1 tylko doo pracowników
-- a) którzy mają podwładnych
-- b) którzy nie mają podwładnych
-- 7.4 Zmodyfikuj rozwiązania z pkt 3 tak aby dla pracowników pokazać jeszcze datę ostatnio obsłużonego zamówienia


