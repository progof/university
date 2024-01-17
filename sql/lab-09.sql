select a.employeeid, a.lastname as name  
     , a.title                  as title  
     , b.employeeid, b.lastname as name  
     , b.title                  as title  
from employees as a  
     inner join employees as b  
                on a.title = b.title  
where a.employeeid < b.employeeid


select  firstname + ' ' + lastname as name,city, postalcode , 'pracownik' as type 
from employees  
union 
select companyname, city, postalcode, 'klient'
from customers
union 
select companyname, city, postalcode, 'dostawca'
from Suppliers


select distinc country from customers  
intersect  
select country from suppliers

SELECT 'ala'
UNION ALL
SELECT 'ala'

-- Zadanie domowe 3.0-join_set strona 29 z pracownikami