--1. Show # of orders by every customer in the USA, sorting highest to lowest.
select C.CompanyName, Sub.Cnt
	from Customers as C
	join (select CustomerID, count (*) as Cnt
			from Orders
			group by CustomerID) as Sub
on C.CustomerID = Sub.CustomerID;

--OR

with Sub as
(
select CustomerID, count (*) as Cnt
	from Orders
	group by CustomerID
)
select C.CompanyName, Sub.Cnt
	from Customers as C
	join Sub
	on C.CustomerID = Sub.CustomerID
	where C.Country = 'USA'
	order by Cnt desc;



--2. Show product name and # of products from German suppliers sold to German customers ranking highest to lowest.
with GermanSuppliers as
	(select SupplierID from Suppliers where Country = 'Germany'),
GermanCustomers as (
	select CustomerID from Customers where Country = 'Germany'),
GermanProducts as (
	select ProductID, ProductName from Products where SupplierID in (select * from GermanSuppliers)),
OrdersFromGermanCustomers as (
	select OrderID from Orders where CustomerID in (select CustomerID from GermanCustomers)),
[Quantities of products sold to German customers] as (
	select ProductID, sum(Quantity) as Qty
		from [Order Details]
		where OrderID in (select OrderID from OrdersFromGermanCustomers)
		group by ProductID)
select P.ProductName, Q.Qty
	from GermanProducts as P
	join [Quantities of products sold to German customers] as Q
		on P.ProductID = Q.ProductID
	order by Q.Qty desc;


--3. Prepare an employee report showing the name of each employee, the # of employees they supervise, and the name of their supervisor. Sort by #.
select * from Employees order by ReportsTo;
	
with
DirectReports as 
(
	select ReportsTo as EmployeeID,
			count(EmployeeID) as Reportees
		from Employees	
		group by ReportsTo
),

EmployeeSupervisors as 
(
    select E2.TitleOfCourtesy + ' ' + E2.FirstName + ' ' + E2.LastName as SupervisorName,
           E1.*
		from Employees as E1
    	join Employees as E2
    	  on E1.ReportsTo = E2.EmployeeID
)

select E.TitleOfCourtesy + ' ' + E.FirstName + ' ' + E.LastName as SupervisorName,
	   ISNULL (DR.Reportees, 0) as NumberOfDirectReports,
	   ES.SupervisorName

	from Employees as E
	left join DirectReports as DR
	  on E.EmployeeID = DR.EmployeeID
	left join EmployeeSupervisors as ES
	  on E.EmployeeID = ES.EmployeeID
	order by NumberOfDirectReports desc;


--4.1 Creating Views.
select EmployeeID, count(distinct CustomerID)
	from Orders
	group by EmployeeID, CustomerID

select EmployeeID, CustomerID 
	from Orders
	group by EmployeeID, CustomerID; 

--4.2 & 4.3
with [Employee Customer Pairs] as 
(
	select EmployeeID, CustomerID	
		from Orders
		group by EmployeeID, CustomerID
)

select C.CustomerID, C.CompanyName, C.ContactName,
		E.EmployeeID, E.FirstName, E.LastName
	from [Employee Customer Pairs] as ECP
	join Employees as E
	  on ECP.EmployeeID = E.EmployeeID
	join Customers as C
	  on ECP.CustomerID = C.CustomerID;

--4.4

drop view if exists [Employee Customer Pairs]			--great exception 

go 

create view [Employee Customer Pairs] as

	with [Employee Customer Pairs] as 
(
	select EmployeeID, CustomerID	
		from Orders
		group by EmployeeID, CustomerID
)

select C.CustomerID, C.CompanyName, C.ContactName,
		E.EmployeeID, E.FirstName, E.LastName
	from [Employee Customer Pairs] as ECP
	join Employees as E
	  on ECP.EmployeeID = E.EmployeeID
	join Customers as C
	  on ECP.CustomerID = C.CustomerID;

--4.5
select * from [Employee Customer Pairs]
	where EmployeeID = 7;

--4.6
select * from [Employee Customer Pairs]
	where CustomerID = 'CHOPS';


--4.7
drop view [Employee Customer Pairs];

