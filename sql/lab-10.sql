-- Podzapytania

USE Northwind

select t.orderid, t.customerid  
 from (select orderid, customerid  
         from orders) as t


select productname, unitprice  
     , (select avg(unitprice) from products) as average  
from products;


select productname, unitprice  
     , (select avg(unitprice) from products) as average 
     , UnitPrice -  (select avg(unitprice) from products) as diff
from products
where UnitPrice >  (select avg(unitprice) from products)

EXCEPT -- prownanie rozwiazan

SELECT *, UnitPrice - average as diff from
    (select productname, unitprice  
        , (select avg(unitprice) from products) as average  
    from products ) as t
where UnitPrice > average



---------------------------
-- Podzapytania skorelowane

select avg(unitprice)  
from products as p_in  
where p_in.categoryid = 1

-- trochy gorsze rozwiazanie (bardzie skomplikowane)
select productname, categoryid, unitprice  
    ,( select avg(unitprice)  
        from products as p_in  
        where p_in.categoryid = p_out.categoryid ) as average  
    , UnitPrice - ( select avg(unitprice)  
        from products as p_in  
        where p_in.categoryid = p_out.categoryid ) as diff
from products as p_out
where UnitPrice > ( select avg(unitprice)  
        from products as p_in  
        where p_in.categoryid = p_out.categoryid )

-- lepsze rozwiazanie (lite)
SELECT * , unitprice - average diff from 
(select productname, categoryid, unitprice  
     ,( select avg(unitprice)  
        from products as p_in  
        where p_in.categoryid = p_out.categoryid ) as average  
from products as p_out ) as t
where UnitPrice > average



;with t as (  
   select productname, categoryid, unitprice  
        ,( select avg(unitprice)  
           from products as p_in  
           where p_in.categoryid = p_out.categoryid ) as average  
   from products as p_out  
)  
select *, UnitPrice - average as diff from t
order by productname 




SELECT  productname, p.categoryid, unitprice, avegage, UnitPrice - avegage as diff 
from products p JOIN 
    (select categoryid, avg(unitprice) avegage  
    from products  
    group by categoryid) av ON av.CategoryID = p.CategoryID
where UnitPrice > avegage
order by productname 





;with av as (
    (select categoryid, avg(unitprice) avegage  
    from products  
    group by categoryid)
)

select productname, p.categoryid, unitprice, avegage, UnitPrice - avegage as diff
from products p join av on p.CategoryID = av.CategoryID
ORDER by ProductName


-- Podzapytania skorelowane c.d. - przykład


SELECT orderid, Customerid
from orders o 
order by OrderID

-- JOIN
select o.orderid, o.customerid, c.companyname  
from customers c join orders o  on c.customerid = o.customerid
order by OrderID

-- Podzapytania
select orderid, customerid,  
       (select companyname from customers c 
        where c.customerid = o.customerid) companyname 
from orders o


-- Zapytanie zwraca listę wszystkich pracowników którzy obsługiwali zamówienia w dniu '1997-09-05'

-- podzapytania
select lastname, employeeid  
 from employees as e  
 where employeeid in (select employeeid from orders as o  
                 where  o.orderdate = '1997-09-05')

select lastname, employeeid  
 from employees as e  
 where employeeid not in (select employeeid from orders as o  
                 where  o.orderdate = '1997-09-05')

-- JOIN 
select distinct lastname, e.employeeid  
 from orders as o  
 inner join employees as e  
  on o.employeeid = e.employeeid  
 and o.orderdate = '1997-09-05'
 where orderid is NULL


select distinct lastname, e.employeeid  
 from orders as o  
 right outer join employees as e  
  on o.employeeid = e.employeeid  
 and o.orderdate = '1997-09-05'
 where orderid is NULL


----------
-- Except

select lastname, employeeid from employees
except
select  lastname, e.employeeid
 from orders as o
 inner join employees as e
  on o.employeeid = e.employeeid
 where o.orderdate = '1997-09-05'

EXECUTE sp_generate_dependencies_diagram 
    @database_name = 'Northwind',
    @table_name = 'Orders';