--1. Who are our customers in North America?
select *
	from Customers
	where Country = 'USA';

--2. What orders were placed in April, 1998?
select * 
	from Orders
	where OrderDate >= '1998-04-01'
	  and OrderDate < EOMONTH('1998-04-01'); --Gets thru the END OF MONTH

select EOMONTH('1998-04-01');



--OR

select * 
	from Orders
	where month (OrderDate) = 4
	  and year  (OrderDate) = 1998;

--4. You sell some kind of dried fruit that I liked very much, what is its name?
select *
	from Products
	where ProductName like '%dry%'   -- like is a special name where you can use wild-cards(%%). %% means dry is in the string but may be preceded or followed by anything. 
	or ProductName like '%dried%';

--5. 

--6.

--7. List employee title, first name, last name, and, on a separate line, their position
--separate each employee by a line. 

select * from Employees;

select TitleOfCourtesy + ' ' + FirstName + ' ' + LastName + char(13) + char(10)
	 + Title + char(13) + char(10) -- char reverences ASCII table (char 10 = new line & char 13 = return)
	 from Employees;

--8. List customers and representative's Firts Name
select * from Customers;

select CHARINDEX(' ', ContactName), ContactName
	from Customers;

select left(ContactName, CHARINDEX(' ', ContactName) - 1)
	from Customers;

select SUBSTRING(ContactName, 0, CHARINDEX(' ', ContactName))
	from Customers;

--10. How many days old are you today?
select DATEDIFF(day, '1990-08-20', GETDATE());
