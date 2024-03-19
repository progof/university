-- 2_0-grupuwanie -> "contunie"
use northwind;

select productid, sum(quantity) as total_quantity
from orderhist
WHERE productid < 3
group by productid
having sum(quantity)>=30

-- Wyświetl listę identyfikatorów produktów i ilość dla tych produktów, których zamówiono ponad 1200 jednostek
select productid, sum(quantity) as total_quantity
from [order details]
group by productid
having sum(quantity)>1200

-- Ćwiczenia
--  1 Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
SELECT OrderID
FROM [order details]
GROUP BY OrderID
HAVING COUNT(*)>5

--  2 Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień 
--  (wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
SELECT
    Customers.CustomerID,
    Customers.CompanyName,
    COUNT(Orders.OrderID) AS OrdersCount,
    SUM(Orders.Freight) AS TotalFreight
FROM
    Customers, Orders
WHERE
    Customers.CustomerID = Orders.CustomerID
    AND YEAR(Orders.OrderDate) = 1998
GROUP BY
    Customers.CustomerID, Customers.CompanyName
HAVING
    COUNT(Orders.OrderID) > 8
ORDER BY
    TotalFreight DESC;


select CustomerID, count(*) as NumberOfOrders, sum(Freight) as TotalFreight
from dbo.Orders
where year(OrderDate) = 1998
group by CustomerID
having count(*) > 8
order by TotalFreight desc;

select CustomerID
from dbo.Orders
where year(OrderDate) = 1998
group by CustomerID
having count(*) > 8
order by sum(Freight) desc;


-- 2.1-grupowanie zad koncowe

-- Ćwiczenia 1.
--  1.1 Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia 
--  w tablicy order details i zwraca wynik posortowany w malejącej kolejności (wg wartości sprzedaży).
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalSales
FROM [Order Details]
GROUP BY OrderID
ORDER BY TotalSales DESC;


--  1.2 Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało pierwszych 10 wierszy
SELECT TOP 10 OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalSales
FROM [Order Details]
GROUP BY OrderID
ORDER BY TotalSales DESC;


-- Ćwiczenie 2.
--  2.1 Podaj liczbę zamówionych jednostek produktów dla produktów, dla których jest mniejszy niż 3
SELECT ProductID, SUM(Quantity) AS TotalOrderedUnits
FROM [Order Details]
WHERE Quantity < 3
GROUP BY ProductID;


--  2.2 Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę zamówionych jednostek produktu dla wszystkich produktów
SELECT ProductID, SUM(Quantity) AS TotalOrderedUnits
FROM [Order Details]
GROUP BY ProductID;


--  2.3 Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których łączna 
-- liczba zamawianych jednostek produktów jest większa niż 250
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS OrderValue
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) > 250;


-- Ćwiczenie 3.
--  3.1 Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień
SELECT EmployeeID, COUNT(OrderID) AS OrdersHandled
FROM Orders
GROUP BY EmployeeID;

--  3.2 Dla każdego spedytora/przewoźnika podaj łączną wartość "opłat za przesyłkę" dla przewożonych przez niego zamówień
SELECT ShipVia, SUM(Freight) AS TotalFreightCost
FROM Orders
GROUP BY ShipVia;

--  3.3 Dla każdego spedytora/przewoźnika podaj łączną wartość "opłat za przesyłkę" 
-- przewożonych przez niego zamówień w latach o 1996 do 1997
SELECT ShipVia, SUM(Freight) AS TotalFreightCost
FROM Orders
WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997 
GROUP BY ShipVia;


-- Ćwiczenie 4.
--  4.1 Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata i miesiące
SELECT EmployeeID, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, COUNT(OrderID) AS OrdersHandled
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate);


--  4.2 Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej kategorii
SELECT CategoryID, MAX(UnitPrice) AS MaxPrice, MIN(UnitPrice) AS MinPrice
FROM Products
GROUP BY CategoryID;


