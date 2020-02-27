--1. What is the order number and the date of each order sold by each employee?
select * from Orders;
select * from Employees;

select *
	from Orders	
	join Employees	--a join goes against second normal form.
		on Orders.EmployeeID = Employees.EmployeeID;

select OrderID,
	   OrderDate,
	   TitleOfCourtesy + ' ' + FirstName + ' ' + LastName as FullName
	from Orders	
	join Employees	--a join goes against second normal form.
		on Orders.EmployeeID = Employees.EmployeeID
	order by OrderDate desc;




--2. List each territory by region.
select * from Territories;
select * from Region;

select * -- "Ctrl. L" will give you the path of each select statement you sele
	from Territories
	cross join Region;  -- 

select *
	from Territories as T
	join Region as R
		on T.RegionID = R.RegionID;

select TerritoryDescription, RegionDescription
	from Territories as T
	join Region as R
		on T.RegionID = R.RegionID;


--3. What is the supplier name for each product alphabetically by supplier?
select *
	from Products as P
	join Suppliers as S
		on P.SupplierID = S.SupplierID
	order by S.CompanyName asc;

select CompanyName, ProductName
	from Products as P
	join Suppliers as S
		on P.SupplierID = S.SupplierID
	order by S.CompanyName asc;


--4. For every order on May 5, 1998, how many of each item was ordered, and what was the price of the item?
select count (*) from Orders;
select count (*) from [Order Details];

select * 
	from Orders as O
	where O.OrderDate = '1998-05-05';

select * 
	from Orders as O
	join [Order Details] as OD
		on O.OrderID = OD.OrderID
	where O.OrderDate = '1998-05-05';

select ProductName, 
		OD.UnitPrice * (1 - OD.Discount) as DiscountedPrice,
		sum(Quantity) as Qty
	from Orders as O
	join [Order Details] as OD
		on O.OrderID = OD.OrderID
	join Products as P
		on OD.ProductID = P.ProductID
	where O.OrderDate = '1998-05-05'
	group by OD.ProductID, P.ProductName, OD.UnitPrice, OD.Discount
	order by OD.ProductID;


--5. For every order on May 5, 1998, how many of each item was ordered giving the name of the item, and what was the price of the item?
select ProductName, 
		OD.UnitPrice * (1 - OD.Discount) as DiscountedPrice,
		sum(Quantity) as Qty
	from Orders as O
	join [Order Details] as OD
		on O.OrderID = OD.OrderID
	join Products as P
		on OD.ProductID = P.ProductID
	where O.OrderDate = '1998-05-05'
	group by OD.ProductID, P.ProductName, OD.UnitPrice, OD.Discount
	order by OD.ProductID;


--6. For every order in May, 1998, what was the customer’s name and the shipper’s name?
select * from Orders;
select * from Customers;
select * from Shippers;

select *
	from Orders as O
	join Customers as C
		on O.CustomerID = C.CustomerID;

select	C.CompanyName as CustomerName,
		S.CompanyName as ShipperName
	from Orders as O
	join Customers as C
		on O.CustomerID = C.CustomerID
	join Shippers as S
		on O.ShipVia = S.ShipperID;

select	C.CompanyName as CustomerName,
		S.CompanyName as ShipperName
  from	Orders as O
  join	Customers as C
		on O.CustomerID = C.CustomerID
  join	Shippers as S
		on O.ShipVia = S.ShipperID
  where O.OrderDate >= '1998-05-01'
    and O.OrderDate < '1998-06-01';



--7. What is the customer’s name and the employee’s name for every order shipped to France?
select C.CompanyName,
		E.FirstName + ' ' + E.LastName as EmployeeName
	from Orders as O
	join Customers as C
		on O.CustomerID = C.CustomerID 
	join Employees as E
		on O.EmployeeID = E.EmployeeID
	where ShipCountry = 'France'
	group by C.CompanyName, E.FirstName, E.LastName;



--8. List the products by name that were shipped to Germany.
select * 
	from Orders	
	where ShipCountry = 'Germany';

select distinct P.ProductName 
	from [Order Details] as OD
	join Orders as O
		on OD.OrderID = O.OrderID
	join Products as P
		on OD.ProductID = P.ProductID
	where O.ShipCountry = 'Germany'
	order by P.ProductName asc;



