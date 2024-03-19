-- Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, 
--- numer klienta dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy 
-- jest Argentyna
SELECT OrderID, OrderDate, CustomerID, ShippedDate 
FROM Orders
WHERE ShipCountry = 'Argentina' AND ShippedDate is NULL;

SELECT OrderID, OrderDate, CustomerID, ShippedDate, ShipCountry
FROM Orders
WHERE ShipCountry = 'Argentina' AND (ShippedDate IS NULL OR ShippedDate > GETDATE())

-- Zakres wartości - ćwiczenie
-- 1. Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
SELECT ProductName, UnitPrice 
FROM Products 
WHERE UnitPrice < 10 OR UnitPrice > 20;

-- 2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
SELECT ProductName, UnitPrice 
FROM Products 
WHERE UnitPrice BETWEEN 20 AND 30;


-- Warunki logiczne - ćwiczenie
-- 1. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) 
-- lub we Włoszech (Italy)
SELECT CompanyName, Country 
FROM Customers 
WHERE Country = 'Japan' OR Country = 'Italy';

SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('Japan', 'Italy');

-- ORDER BY - ćwiczenie
-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, 
-- w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country 
FROM Customers 
ORDER BY Country;

-- 2. Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a 
-- w grupach malejąco wg ceny
SELECT CategoryID, ProductName, UnitPrice 
FROM Products
ORDER BY CategoryID, UnitPrice DESC;

-- 3. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) 
-- lub we Włoszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('France', 'Italy')
ORDER BY Country;



SELECT orderid, unitprice, unitprice * 1.05 as newunitprice, unitprice * 1.05 - unitprice diff
FROM [order details]
WHERE (unitprice * 1.05 - unitprice) > 2
ORDER BY diff


-- iff 
-- ISNULL
-- cast, CONVERT
-- konstrukcja case

SELECT CAST(0.1 as float) + CAST(0.1 as float) + CAST(0.1 as float) - CAST(0.3 as float)

-- 1. Napisz polecenie, które oblicza wartość każdej pozycji zamówienia o numerze 10250
SELECT * , ROUND(UnitPrice * Quantity * (1 - Discount), 2) AS Full_Price
FROM [Order Details]
WHERE OrderID = 10250

-- 2. Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę zawierającą nr telefonu i nr faksu w formacie
-- (numer telefonu i faksu mają być oddzielone przecinkiem)



