-- Lab_5 3_1_join_cw
use joindb

SELECT * FROM Produce
SELECT * FROM Buyers
SELECT * FROM Sales

select b.buyer_name, s.buyer_id, prod_id, qty
from buyers as b inner join sales as s
on b.buyer_id = s.buyer_id

select buyer_name, s.buyer_id, s.prod_id, qty
from buyers as b, sales as s
where s.buyer_id = b.buyer_id

select buyer_name, s.buyer_id, qty
from buyers as b inner join sales as s
on b.buyer_id = s.buyer_id

-- Przykład
-- Napisz polecenie zwracające nazwy produktów i firmy je dostarczające (baza
-- northwind)
-- tak aby produkty bez dostawców i dostawcy bez produktów nie pojawiali się w
-- wyniku
use northwind;

select productid, productname, companyname, s.SupplierID
from products as p
     inner join suppliers as s
                on p.supplierid = s.supplierid
                    order by ProductID

SELECT * FROM Products WHERE ProductID = 10
SELECT * FROM Suppliers WHERE SupplierID = 4

-- Example error query !!! "p.ProductID = s.supplierid" != p.supplierid = s.supplierid
select productid, productname, companyname, s.SupplierID
from products as p
     inner join suppliers as s
                on p.ProductID = s.supplierid
                    order by ProductID

-- Przykład
-- Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po
-- 01 marca 1998 (baza northwind)
use northwind;

--  distinct -> usuwa duplikaty
SELECT distinct companyname 
FROM Customers as c join orders as o on c.customerid = o.CustomerID
WHERE  orderdate > '1998-03-01'


-- Ćwiczenia
-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy
-- 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
use Northwind;

SELECT ProductName, UnitPrice
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20.00 AND 30.00;

-- 2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych
-- przez firmę ‘Tokyo Tradersʼ
SELECT p.ProductName, p.UnitsInStock, p.UnitsOnOrder
FROM Products as p
JOIN Suppliers as s ON p.SupplierID = s.SupplierID
WHERE s.CompanyName = 'Tokyo Traders';


-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to
-- pokaż ich dane adresowe
SELECT c.CompanyName, c.Address
FROM Customers c
        LEFT JOIN Orders o 
                    ON c.CustomerID = o.CustomerID AND YEAR(o.OrderDate) = 1997
                                                            WHERE o.CustomerID IS NULL;

select c.CompanyName, c.Address, c.City, c.Region, c.PostalCode, c.Country
from Customers c
where c.CustomerID not in (select o.CustomerID
                           from dbo.Orders o
                           where o.OrderDate between '1997-01-01' and '1997-12-31');


-- 4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których
-- aktualnie nie ma w magazynie.
SELECT s.CompanyName, s.Phone
FROM Suppliers as s
JOIN Products as p ON s.SupplierID = p.SupplierID
WHERE p.UnitsInStock = 0;


-- Przykład Outer Join
use joindb;

select buyer_name, s.buyer_id, qty
from buyers b left outer join sales s
on b.buyer_id = s.buyer_id

select buyer_name
from buyers b left outer join sales s
on b.buyer_id = s.buyer_id
where s.buyer_id is null


-- Przykład
-- Napisz polecenie zwracające wszystkich klientów z datami zamówień (baza
-- northwind).
use northwind;

select companyname, customers.customerid, orderdate
from customers
     left outer join orders
                     on customers.customerid = orders.customerid
                                                where OrderID is NULL

select companyname, customers.customerid, orderdate
from customers
    join orders
        on customers.customerid = orders.customerid 




