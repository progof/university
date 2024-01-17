-- 3.0-join

select companyname, customers.customerid, orderdate  
from customers  
     join orders  
            on customers.customerid = orders.customerid and year(orderdate) = 1997


select companyname, customers.customerid, orderdate  
from customers  
     left outer join orders  
                     on customers.customerid = orders.customerid and year(orderdate) = 1997

-- Cross join
use joindb;

select buyer_name, qty  
from buyers cross join sales

select buyer_name, qty  
from buyers, sales

select buyer_name, qty  
from buyers join sales
on 1=1

-- Łączenie więcej niż dwóch tabel
select buyer_name, s.prod_id, prod_name, qty  
from buyers b 
    inner join sales s 
        on b.buyer_id = s.buyer_id  
    inner join produce p 
        on s.prod_id = p.prod_id

-- Przykład
-- Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08
use Northwind
select distinct productname 
from orders as O  
     inner join [order details] as OD  
                on O.orderid = OD.orderid  
     inner join products as P  
                on OD.productid = P.productid  
where orderdate = '1996-07-08'

-- Ćwiczenia 1
-- 1.1 Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00,
-- dla każdego produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
SELECT ProductName, UnitPrice, s.Address, c.CategoryName
FROM Products as p 
    inner join Suppliers as s
        ON p.SupplierID = s.SupplierID
    inner join Categories as c
        ON c.CategoryID = p.CategoryID
WHERE p.UnitPrice BETWEEN 20.00 AND 30.00 AND c.CategoryName = 'Meat/Poultry'  



-- 1.2 Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
SELECT ProductName, UnitPrice, s.CompanyName ,c.CategoryName
FROM Products as p 
    inner join Suppliers as s
        ON p.SupplierID = s.SupplierID
    inner join Categories as c
        ON c.CategoryID = p.CategoryID
WHERE c.CategoryName like 'Confections'  

select productname, unitprice, CompanyName
from products
join suppliers on suppliers.supplierid = products.supplierid
join categories on categories.categoryid = products.categoryid
where categoryname like 'Confections'

-- 1.3 Dla każdego klienta podaj liczbę złożonych przez niego zamówień. Zbiór wynikowy powinien zawierać nazwę klienta, oraz liczbę zamówień
SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) as 'Order Sum'
FROM Customers as c
    LEFT OUTER JOIN Orders as o
        ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName, c.CustomerID
--HAVING COUNT(OrderID) = 0

-- 1.4 Dla każdego klienta podaj liczbę złożonych przez niego zamówień w marcu 1997r
SELECT c.CompanyName, COUNT(OrderID) as 'Order Sum'
FROM Customers as c
    LEFT OUTER JOIN Orders as o
        ON c.CustomerID = o.CustomerID AND YEAR(OrderDate) = 1997 AND  MONTH(OrderDate) = 3
GROUP BY c.CompanyName, c.CustomerID
HAVING COUNT(OrderID) = 0



-- Ćwiczenia 2
-- 2.1 Który ze spedytorów był najaktywniejszy w 1997 roku, podaj nazwę tego spedytora
SELECT TOP 1 s.SupplierID, s.CompanyName, count(*) AS OrdersShipped 
FROM Suppliers as s 
    JOIN Orders as o
        ON s.SupplierID = o.ShipVia and Year(o.OrderDate) = 1997
group by s.SupplierID, s.CompanyName
order by OrdersShipped DESC

select TOP 1 SupplierID, CompanyName, count(*) as OrdersShipped 
from dbo.Suppliers
    join dbo.Orders
        on SupplierID = Orders.ShipVia and Year(OrderDate) = 1997
group by SupplierID, CompanyName
order by OrdersShipped DESC

-- 2.2 Dla każdego zamówienia podaj wartość zamówionych produktów. Zbiór wynikowy powinien zawierać nr zamówienia,
-- datę zamówienia, nazwę klienta oraz wartość zamówionych produktów
SELECT O.OrderID,O.OrderDate,C.CompanyName,ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)),2) AS OrderValue
FROM dbo.Orders as O
    JOIN dbo.Customers as C
        ON O.CustomerID = C.CustomerID
    JOIN dbo.[Order Details] as OD
        ON o.OrderID = OD.OrderID
GROUP BY o.OrderID, o.OrderDate, C.CompanyName;

-- nie poprawnie dziala
SELECT O.OrderID,O.OrderDate,C.CompanyName,ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)+o.Freight),2) AS OrderValue
FROM dbo.Orders as O
    JOIN dbo.Customers as C
        ON O.CustomerID = C.CustomerID
    JOIN dbo.[Order Details] as OD
        ON o.OrderID = OD.OrderID
GROUP BY o.OrderID, o.OrderDate, C.CompanyName
ORDER BY O.OrderID

SELECT O.OrderID,O.OrderDate,C.CompanyName,ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)),2)+o.Freight AS OrderValue
FROM dbo.Orders as O
    JOIN dbo.Customers as C
        ON O.CustomerID = C.CustomerID
    JOIN dbo.[Order Details] as OD
        ON o.OrderID = OD.OrderID
GROUP BY o.OrderID, o.OrderDate, C.CompanyName
ORDER BY O.OrderID

SELECT
  o.OrderID AS nr_zamowienia,
  o.OrderDate AS data_zamowienia,
  c.CompanyName AS nazwa_klienta,
  SUM(od.UnitPrice * od.Quantity) AS wartosc_produktow
FROM
  Orders o
JOIN
  Customers c ON o.CustomerID = c.CustomerID
JOIN
  [Order Details] od ON o.OrderID = od.OrderID
GROUP BY
  o.OrderID, o.OrderDate, c.CompanyName
ORDER BY
  o.OrderID;

-- poprwane !!!
SELECT O.OrderID,O.OrderDate,C.CompanyName,ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)),2) + MIN(o.Freight) AS OrderValue
FROM dbo.Orders as O
    JOIN dbo.Customers as C
        ON O.CustomerID = C.CustomerID
    JOIN dbo.[Order Details] as OD
        ON o.OrderID = OD.OrderID
GROUP BY o.OrderID, o.OrderDate, C.CompanyName
ORDER BY O.OrderID

-- 2.3 Dla każdego zamówienia podaj jego pełną wartość (wliczając opłatę za przesyłkę). Zbiór wynikowy powinien zawierać 
-- nr zamówienia, datę zamówienia, nazwę klienta oraz pełną wartość zamówienia
SELECT
    Orders.OrderID,
    Orders.OrderDate,
    Customers.CompanyName,
    SUM([Order Details].UnitPrice * [Order Details].Quantity) AS OrderValue
FROM
    dbo.Orders
JOIN
    dbo.Customers ON Orders.CustomerID = Customers.CustomerID
JOIN
    dbo.[Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY
    Orders.OrderID, Orders.OrderDate, Customers.CompanyName;



-- 2.4 Dla każdego produktu podaj wartość sprzedaży tego produktu w marcu 1997



-- !!!!!Home work 3.0 set - all tasks