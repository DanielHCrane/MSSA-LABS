--1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly’s Homestead, and Tokyo Traders.
select * from Suppliers;					--"Once more into the breach!"  -Elliot 

select ProductName, SupplierID 
	from Products
	where SupplierID = 1
	or SupplierID = 3
	or SupplierID = 4;						--"This offends my delicate sensibilities ..." -Elliot

select ProductName, SupplierID				
	from Products
	where SupplierID in (1, 3, 4);			--"Fancy!" -Elliot


select ProductName, SupplierID				
	from Products
	where SupplierID in (select SupplierID
                            from Suppliers
                            where CompanyName in ('Exotic Liquids',
                            					  'Grandma Kelly''s Homestead',
                                                  'Tokyo Traders'));
                            

--2. Create a report that shows all products by name that are in the Seafood category.
select * from Products order by CategoryID;
select * from Categories;

select ProductName	
	from Products
	where CategoryID = 8;

select ProductName	
	from Products
	where CategoryID = (select CategoryID
							from Categories
							where CategoryName = 'Seafood');

--3. Create a report that shows all companies by name that sell products in CategoryID 8.
select SupplierID
	from Products
	where CategoryID = 8;


select CompanyName
	from Suppliers
	where SupplierID in (select SupplierID
							from Products
							where CategoryID = 8);

--4. Create a report that shows all companies by name that sell products in the Seafood category.
select CompanyName
	from Suppliers
	where SupplierID in (select SupplierID
							from Products
							where CategoryID = (select CategoryID
												from Categories
												where CategoryName = 'Seafood'));


--5. Create a report that lists the ten most expensive products.
select top (10) * 
	from Products
	order by UnitPrice desc;

--6. Create a report that shows the date of the last order by all employees.
select max (OrderDate) as lastOrderDate, EmployeeID
	from Orders
	group by EmployeeID
	order by EmployeeID;

select E.FirstName, E.LastName, O.LastOrderDate
	from Employees as E
	join (select max (OrderDate) as lastOrderDate, EmployeeID
			from Orders
			group by EmployeeID) as O
	on E.EmployeeID = O.EmployeeID;
