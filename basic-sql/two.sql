-- Oleh Ortynskyi
-- 1
use Northwind;
select CompanyName
from dbo.Shippers
except
select CompanyName
from Orders
join Shippers on Orders.ShipVia = Shippers.ShipperID
where Year(ShippedDate) = 1996 and MONTH(ShippedDate) = 7 and Day(ShippedDate) between 5 and 10;

-- 2
use Northwind
select *
from (
    select sum(UnitPrice * Quantity * (1 - Discount)) as OrderPrice, Orders.EmployeeID
    from Orders
    join [Order Details] on Orders.OrderID = [Order Details].OrderID
    right outer join dbo.Employees on Orders.EmployeeID = Employees.EmployeeID
    and Year(OrderDate) = 1997 and Month(OrderDate) = 3
    group by Orders.OrderID, Orders.EmployeeID
) as t;

-- 3
use library;
select t.member_no, count(title_no) as title_read, firstname, lastname, street, city, state
from (
    select juvenile.member_no, title_no, adult_member_no
    from juvenile
    left outer join loanhist on juvenile.member_no = loanhist.member_no
    group by juvenile.member_no, title_no, adult_member_no
) as t
left join member on t.member_no = member.member_no
left join adult on adult_member_no = adult.member_no
group by t.member_no, firstname, lastname, street, city, state
having count(title_no) >= 2;

-- 4
use library;
select count(*)
from member
join (
    select loan.member_no, count(title_no) as titles_count
    from dbo.loan
    join dbo.juvenile on juvenile.member_no = loan.member_no
    group by loan.member_no
    having count(title_no) >= 2
) as t on t.member_no = member.member_no
    join dbo.juvenile on member.member_no = juvenile.member_no
    join dbo.adult on juvenile.adult_member_no = adult_member_no
group by t.member_no;

-- 5
use Northwind;
select CategoryID
from Categories
where CategoryName = 'Seafood';

select Customers.CustomerID, CompanyName
from [Order Details]
join Products on [Order Details].ProductID = Products.ProductID
and CategoryID = (
    select CategoryID
    from Categories
    where CategoryName = 'Seafood'
)
join Orders on [Order Details].OrderID = Orders.OrderID
and Year(OrderDate) = 1997 and Month(OrderDate) = 3
join Customers on Orders.CustomerID = Customers.CustomerID;
