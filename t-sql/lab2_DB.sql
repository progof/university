use ortynsky

select * from customers

select * from customers where customerid = 'PECOF';
select * from customers where customerid like 'PECO%';


insert customers (customerid, companyname, contactname, contacttitle,
	address, city, region, postalcode, country,
phone ,fax)
values ('PECOf', 'Pecos Coffee Company', 'Michael Dunn','Owner',
	'1900 Oak Street', 'Vancouver', 'BC','V3F 2K1', 'Canada',
	'(604) 555-3392' ,'(604) 555-7293');


delete customers where customerid like 'PECO%';




select * from shippers

insert shippers (companyname)
values ('Fitch & Mather');

DBCC CHECKIDENT ('shippers', RESEED, 3);

insert shippers (companyname, phone)
values ('bala', '123');

select @@identity

delete shippers
where shipperid > 3


begin tran

select @@TRANCOUNT

insert shippers (companyname, phone)
values ('jack', '123');

select * from shippers

rollback
commit


select * from shippers

insert shippers (companyname, phone)
values ('Taxi1', '911');
insert shippers (companyname, phone)
values ('Taxi2', '912');

insert shippers (companyname, phone)
values ('Taxi3', '911'),
		('Taxi4', '912');


insert shippers (companyname, phone)
values ('Taxi1', '911'),
(null, '911');




begin tran

insert shippers (companyname, phone)
values (null, '911');
insert shippers (companyname, phone)
values ('Taxi2', '912');

commit

/* DELETE and Clean Script  **/
delete shippers
where shipperid > 3
DBCC CHECKIDENT ('shippers', RESEED, 3);
/* */

/* Good form checked errors with try catch */
begin try
	begin transaction
	insert shippers (companyname, phone)
	values ('Taxi1', '911');
	insert shippers (companyname, phone)
	values (null, '912');
	commit
end try
begin catch
	if @@trancount > 0
	rollback;
	throw;
end catch

select * from shippers


begin tran

insert shippers (companyname, phone)
select companyname, phone from suppliers;

rollback

select * from newshippers

select supplierid as shipperid, companyname, phone
into newshippers2
from suppliers;



begin tran

update suppliers
set phone = '12 423 512',
fax = '12 423 512'
where supplierid = 2;

select * from suppliers where supplierid = 2

rollback


select * from orders
where datediff(month, shippeddate, getdate()) >= 6;


/* Usuniecje danych po etapno - jedna zalezy od innej - del podrzedne a potem nadzedna */
begin tran

delete orderdetails
where orderid in (
select orderid from orders
where datediff(month, shippeddate, getdate()) >= 6
);

select * from orderdetails

delete orders
where datediff(month, shippeddate, getdate()) >= 6;


select * from orders

rollback