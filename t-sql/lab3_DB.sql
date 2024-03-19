use ortynsky

select * from orders

/*
Zmienne declere
*/

declare @i int, @j int  
declare @first varchar(50)  
declare @last varchar(50)  
  
set @i = 10  
set @j = @i + 5  
set @first = 'Oleh'  
select @last = 'gold'  
  
print @i  
print @j  
print @first  
print @last


/* IF example 1 */

declare @i int  
  
set @i = 1  
  
if @i > 2  
  print 'i is > 2'  
else  
  print 'i is <= 2'

/* IF example 1 */

declare @i int  
  
set @i = 1  

if @i > 2  
begin  
  print 'i is > 2'  
  select * from employees  
end  
else  
begin  
  print 'i is <= 2'  
  select * from orders  
end

/* Lopp While */

declare @j int = 1  
  
while @j <= 5  
begin  
  print @j  
  set @j = @j + 1  
end


/* While c.d. */
declare @j int = 1  
  
while @j <= 5  
begin  
  print @j  
  select lastname from employees where employeeid = @j  
  set @j = @j + 1  
end


/* Podstawienie wartoœci pod zmienn¹ */
declare @first varchar(50)  
declare @last varchar(50)

--declare @companyName varchar(50)  
--declare @contactName varchar(50) 
  
--set @first = (select firstname from employees where employeeid > 1)  
--print @first  
  
select @last = lastname from employees where employeeid > 1  
print @last  
  
select @first = firstname, @last = lastname  from employees where employeeid = 3  
print @first + ' ' + @last


/*
Podstawowe konstrukcje sterujace
*/


/* CURSOR */

declare @id int  
declare @last varchar(50)  
  
declare emp_cursor cursor  
    for select employeeid, lastname from employees  
open emp_cursor  
fetch next from emp_cursor into @id, @last  
  
print @id  
print @last

close emp_cursor  
deallocate emp_cursor  
  
/* CURSOR c.d. */

declare @sum decimal(10,2) = 0, @fr decimal(10,2)
  
declare od_cursor cursor  
    for select freight from orders where customerid = 'ALFKI'  
open od_cursor  
  
  
fetch next from od_cursor into @fr 

if @@FETCH_STATUS <> 0  
    print 'empty set'  
  
while @@FETCH_STATUS = 0  
begin  
    print @fr
    set @sum = @sum + @fr 
    fetch next from od_cursor into @fr  
end  
  
close od_cursor  
deallocate od_cursor  
  
print @sum





/*
Widok - View
*/



create view vw_emp_names  
as  
select firstname + ' ' + lastname as name  
from employees

select * from vw_emp_names

/*
create view -> create
update view -> alter
delete view -> drop
*/

/* Widoki c.d. */
create or alter view vw_product_ok
as  
select productid, categoryid, supplierid, productname, unitprice, unitsinstock  
from products  
where discontinued = 0

select * from vw_product_ok

/* Widoki c.d. */
create view vw_avail_product  
as  
select productid, categoryid, supplierid, productname, unitprice, unitsinstock  
from vw_product_ok  
where unitsinstock > 0

select count(*) from vw_avail_product


/* Widoki c.d. */
create or alter view vw_order_details  
as  
select orderid, productid, unitprice, quantity, discount,  
       cast(unitprice * quantity * (1-discount) as decimal(10,2)) as value  
from orderdetails


select * from orderdetails  
where orderid = 10250

select * from vw_order_details  
where orderid = 10250


/* Widoki c.d. */
create or alter view vw_order_total_1  
as  
select orderid, cast(sum(unitprice * quantity * (1-discount)) as decimal(10,2)) as total  
from orderdetails  
group by orderid


create or alter view vw_order_total_2  
as  
select orderid, sum(value) as total  
from vw_order_details  
group by orderid


select * from vw_order_total_1  

select * from vw_order_total_2 


/* Widoki c.d. */
create or alter view vw_order_total_3  
as  
select o.orderid, cast(o.orderdate as date) orderdate, o.customerid, c.companyname,  
       sum(value) as total  
from vw_order_details od join orders o on od.orderid = o.orderid  
join customers c on o.customerid = c.customerid  
group by o.orderid, o.orderdate,  o.customerid, c.companyname

select * from vw_order_total_3
order by orderid


/*Home  work zaprojektowac 3 view i zaimplemintowac*/

/* 1. View: pokazujacy product z dostawca i kategoria danego produktu*/
create or alter view vw_show_prod_supplier_cat 
as  
select p.ProductName, s.CompanyName, cat.CategoryName
from products as p
	JOIN suppliers as s ON p.supplierid = s.supplierid
	JOIN categories as cat ON p.categoryid = cat.categoryid

select * from vw_show_prod_supplier_cat 
where productid = 1

/* 2. View: pokazujacy orders polaczenie z shippers*/
/* 3. View: nazwe klienta i order id + suma zamuwienia */