-- Wybór kolumn - ćwiczenia

-- 1. Wybierz nazwy i adresy wszystkich klientów
SELECT CompanyName, Address, City, PostalCode, Country FROM Customers;

-- 2. Wybierz nazwiska i numery telefonów pracowników
SELECT LastName, HomePhone FROM Employees WHERE country = 'usa';

-- 3. Wybierz nazwy i ceny produktów
SELECT ProductName, UnitPrice FROM Products;

-- 4. Pokaż wszystkie kategorie produktów (nazwy i opisy)
SELECT CategoryName, Description FROM Categories;

-- 5. Pokaż nazwy i adresy stron www dostawców
SELECT CompanyName, HomePage FROM Suppliers;

-- Examples 
SELECT orderid, customerid, orderdate
FROM orders
WHERE orderdate < '1996-08-01'


-- Wybór wierszy - ćwiczenia
-- 1. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
SELECT CompanyName, Address, City, PostalCode, Country FROM Customers  WHERE City = 'London';

-- 2. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address, City, PostalCode, Country FROM Customers  WHERE Country = 'France' or Country = 'Spain';

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice between 20.00 and 30.00;
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice >= 20.00 and UnitPrice <= 30.00;

-- 4. Wybierz nazwy i ceny produktów z kategorii 'Meat/Poultry'
SELECT * FROM Categories
SELECT ProductName, UnitPrice FROM Products WHERE CategoryID = 6

DECLARE @id INT
set @id = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Meat/Poultry')
SELECT ProductName, UnitPrice FROM Products WHERE CategoryID = @id

SELECT ProductName, UnitPrice 
FROM Products 
WHERE CategoryID = 
(SELECT CategoryID FROM Categories WHERE CategoryName = 'Meat/Poultry')

SELECT ProductName, UnitPrice
FROM Products JOIN Categories ON
Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Meat/Poultry'


-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders'
SELECT ProductName, UnitsInStock FROM Products WHERE SupplierID = (SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders')

-- 6. Wybierz nazwy produktów których nie ma w magazynie
SELECT ProductName FROM Products WHERE UnitsInStock = 0;

-- Example 
SELECT companyname
FROM customers
WHERE companyname LIKE '%Restaurant%'


-- Porównywanie napisów - ćwiczenie
-- 1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

-- 2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
SELECT EmployeeID, LastName, Title 
FROM Employees 
WHERE LastName LIKE '[B-L]%'

SELECT EmployeeID, LastName, Title 
FROM Employees 
WHERE LastName >= 'B' AND LastName < 'M'

-- 3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
SELECT EmployeeID, LastName, Title FROM Employees WHERE LastName LIKE '[B|L]%'

-- 4. Znajdź nazwy kategorii, które w opisie zawierają przecinek
SELECT CategoryName FROM Categories WHERE Description LIKE '%,%';

-- 5. Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’
SELECT CompanyName FROM Customers WHERE CompanyName LIKE '%Store%';

-- Example
SELECT companyname, fax
FROM suppliers
WHERE fax IS NULL


-- Zadanie Domowe (Ćwiczenie )
-- • Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, 
--- numer klienta dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy 
-- jest Argentyna
--
-- Przeanalizowac diagram  1.2 baza library
-- 1.1-polecenie-select ile sie uda


