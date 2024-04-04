use ortynsky
/* Procedury */

create or alter procedure p_add_order
@customerid char(5),
@employeeid int,
@requireddate date
as
begin
	declare @orderdate date = getdate()
	insert orders(customerid,employeeid,orderdate,requireddate)
	values(@customerid,@employeeid,@orderdate,@requireddate);
end;

/* Procedury c.d */

select * from orders
order by orderid desc

declare @requireddate date = dateadd(day, 7, getdate());
exec p_add_order 'ALFKI', 1, @requireddate;

/* Procedur add product */
create procedure p_add_detail
@orderid int, @productid int, @quantity int, @discount decimal(3,2)
as
begin
	declare @unitprice decimal(10,2);
	
	select @unitprice = unitprice from products where productid = @productid;
	
	insert OrderDetails(orderid, productid, unitprice, quantity, discount)
	values(@orderid, @productid, @unitprice, @quantity, @discount);
end;


exec p_add_detail 20000, 1, 10, 0.12;
exec p_add_detail 20005, 31, 10, 0.12;

select * from products

select * from orderdetails
order by orderid desc


ALTER   procedure [dbo].[p_add_detail]
@orderid int, @productid int, @quantity int, @discount decimal(3,2)
as
begin
	begin try
		begin transaction;
		
		if not exists (select * from vw_avail_product
						where productid = @productid and unitsinstock >= @quantity)
			throw 50003, 'No such product', 1;
			
		declare @unitprice decimal(10,2);
		select @unitprice = unitprice from vw_avail_product where productid = @productid;

		insert OrderDetails(orderid, productid, unitprice, quantity, discount)
		values(@orderid, @productid, @unitprice, @quantity, @discount);

		update products
		set unitsinstock = unitsinstock - @quantity
		where productid = @productid;

		commit;
	end try
	begin catch
		rollback;
		throw;
	end catch;
end;



select productid, productname, unitprice, unitsinstock
from vw_avail_product where productid = 10;exec p_add_detail 20004, 7, 15, 0.12;declare @requireddate date = dateadd(day, 7, getdate());
exec p_add_order 'ALFKI', 1, @requireddate;
exec p_add_detail @@identity, 10, 50, 0.12;create or alter procedure p_add_order2
@customerid char(5), @employeeid int, @requireddate date,
@productid int, @quantity int, @discount decimal(3,2)
as
begin
begin try
begin transaction;
exec p_add_order @customerid, @employeeid, @requireddate;
exec p_add_detail @@identity, @productid, @quantity, @discount;
commit;
end try
begin catch
if @@trancount >= 1
rollback;
throw;
end catch;
end;declare @requireddate date = dateadd(day, 7, getdate());
exec p_add_order2 'ALFKI', 1, @requireddate, 10, 3, 0.12;