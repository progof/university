use northwind;

SELECT *, unitprice * quantity * (1-discount) wartosc
FROM [order details]
WHERE orderid = 10250

select top 5 with ties orderid, productid, quantity
from [order details]
order by quantity desc

select count (region)
from employees

SELECT * FROM employees

select quantity
from [order details]
where productid = 1

select sum(quantity)
from [order details]
where productid = 1


-- Cw 1
-- 1. Podaj liczbę produktów o cenach mniejszych niż 10 lub większych niż 20
SELECT COUNT(*) AS Result
FROM Products
WHERE UnitPrice >= 10.00 AND UnitPrice <= 20.00;

select top 1 UnitPrice
from Products
where UnitPrice < 20
order by unitprice desc

-- Cw 2
-- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20
SELECT MAX(UnitPrice)
FROM Products
WHERE UnitPrice < 20;

-- Cw 3
-- Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottleʼ)
SELECT MAX(UnitPrice) AS MAX_Price, MIN(UnitPrice) AS MIN_Price, AVG(UnitPrice) AS AVG_Price
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

-- Cw 4
-- Wypisz informację o wszystkich produktach o cenie powyżej średniej
SELECT *
FROM Products
WHERE unitprice > (SELECT AVG(UnitPrice) FROM Products);


-- Cw 5
-- Podaj sumę/wartość zamówienia o numerze 10250
SELECT * FROM [order details] WHERE OrderID = 10250

SELECT SUM(UnitPrice * Quantity (1 - Discount)) AS SumOrder
FROM [order details] 
WHERE OrderID = 10250;

SELECT sum(UnitPrice * Quantity * (1 - Discount)) AS SumOrder
FROM [order details] 
WHERE OrderID = 10252;


SELECT * FROM orderhist


select productid, sum(quantity) as total_quantity
from [order details]
where productid <= 10
group by productid





-- "Home Work"
-- Zad dom 2_0-grupowanie

-- Cwiczenia
--  . Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
FROM [Order Details]
GROUP BY OrderID;

--  . Podaj dla kazdego zamowiena jego wartosc
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS FullPrice
FROM [Order Details]
GROUP BY OrderID;


--  . Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
FROM [Order Details]
GROUP BY OrderID
ORDER BY MaxPrice DESC;


--  . Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID AS "Order", MAX(UnitPrice) AS MaxPrice, Min(UnitPrice) AS MinPrice
FROM [Order Details]
GROUP BY OrderID


--  . Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
SELECT ShipVia, Count(*) OrderShipped
FROM Orders
GROUP BY ShipVia


--  . Który z spedytorów był najaktywniejszy w 1997 roku
SELECT top 1 ShipVia as ShipperID, COUNT(*) as OrderShipped
    FROM Orders
    WHERE YEAR(ShippedDate) = 1997
    GROUP BY ShipVia
    ORDER BY OrderShipped DESC

SELECT TOP 1 ShipVia AS 'Shipper'
FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY COUNT(*) DESC
