use ortynsky


select * from vw_order_total_3
where customerid = 'ALFKI'
order by orderid


select orderid, orderdate, total  
from vw_order_total_3
where customerid = 'ALFKI'
order by orderid


select * from customers


/* Create procedure  */
create or alter proc p_customer_order_total  
@customerid char(5)  
as  
begin  
    if not exists (select * from customers where customerid = @customerid)  
       throw 50001, 'No customer with such id', 1  
  
    select orderid, orderdate, total  
    from vw_order_total_3  
    where customerid = @customerid  
end

/* Example use proc */

select orderid, orderdate, total  
from vw_order_total_3
where customerid = 'ALFKI'
and orderdate >= '1997-01-01' and orderdate <= '1997-12-31'

exec p_customer_order_total 'ALFKI'


/* Create procedure 2 */
create or alter proc p_customer_order_total_2  
@customerid char(5), @start_date date, @end_date date  
as  
begin  
    if @start_date > @end_date  
       throw 50001, 'wrong date rangel', 1  
    if not exists (select * from customers where customerid = @customerid)  
       throw 50001, 'No customer with such id', 1  
  
    select orderid, orderdate, total  
    from vw_order_total_3  
    where customerid = @customerid  
          and orderdate >= @start_date  
          and orderdate <= @end_date  
end

/* Example use proc 2 */
select orderid, orderdate, total  
from vw_order_total_3
where customerid = 'ALFKI'
and orderdate >= '1997-01-01' and orderdate <= '1997-12-31'

exec p_customer_order_total_2 'ALFKI'


/* Function */
create function f_customer_order_total (@customerid char(5))  
returns table  
as return (  
    select orderid, orderdate, customerid, total  
    from vw_order_total_3  
    where customerid = @customerid  
)


/* Example use function  */
select * from f_customer_order_total('ALFKI')
where orderdate >= '1997-01-01' and orderdate <= '1997-12-31'


/* Function 2 */
create function f_customer_order_total_2 
(
@customerid char(5),
@date_from date,
@date_to date
)  
returns table  
as return (  
    select orderid, orderdate, customerid, total  
    from vw_order_total_3  
    where customerid = @customerid
	and orderdate >= @date_from and orderdate <= @date_to
)

select sum(total) from f_customer_order_total_2('ALFKI', '1997-01-01', '1997-12-31')

select sum(total) from f_customer_order_total('ALFKI')
where orderdate >= '1997-01-01' and orderdate <= '1997-12-31'


/* Function scalar */
create function f_max(@a int, @b int)  
returns int  
as  
begin  
  declare @r int  
  if @a > @b set @r = @a else set @r = @b  
  return @r  
end

select dbo.f_max(1,5)


/* Create scalar func 'f_customer_name' */
create function f_customer_name(@customerid char(5))  
returns varchar(100)  
as  
begin  
    declare @companyname varchar(100)  
  
    select @companyname = companyname  
    from customers  
    where customerid = @customerid  
  
    return @companyname  
end

/* Example */

select dbo.f_customer_name('ALFKI')  

print dbo.f_customer_name('ALFKI') 

select orderid, customerid, dbo.f_customer_name(customerid)  
from orders  
order by orderid

select orderid, customerid,
	(select  companyname from customers c where c.customerid = o.customerid )
from orders o
order by orderid


/* Create func scalar 'order_detail_total' */
create function order_detail_total(@orderid int)  
returns decimal(10,2)  
as  
begin  
    declare @total decimal(10,2)  
  
    select @total = sum(unitprice * quantity * (1-discount))  
    from OrderDetails  
    where orderid = @orderid  
  
    return @total  
end


/* Example */
select orderid, freight + dbo.order_detail_total(orderid)  
from orders


/* Create func scalar 'customer_order_total' */
create function customer_order_total(
@customerid char(5),
@date_from date,
@date_to date
)
returns decimal(10,2)  
as  
begin  
    declare @total decimal(10,2)  
  
    select @total = sum(od.unitprice * od.quantity * (1-od.discount))  
    from orders as o 
	JOIN orderdetails as od ON o.orderid = od.orderid
	where o.customerid = @customerid
	and o.orderdate >= @date_from and o.orderdate <= @date_to
  
    return @total  
end


select orderid, orderdate, customerid, freight + dbo.order_detail_total(orderid)  
from orders
where customerid = 'ALFKI'
and orderdate >= '1997-01-01' and orderdate <= '1997-12-31'


select sum(freight + dbo.order_detail_total(orderid) ) 
from orders
where customerid = 'ALFKI'
and orderdate >= '1997-01-01' and orderdate <= '1997-12-31'


select * from f_customer_order_total_2('ALFKI','1998-01-01','1998-12-31')