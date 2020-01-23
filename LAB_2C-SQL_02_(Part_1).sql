-- 1. Find all the regions
select RegionDescription from Region;

--2. Find all the cities
select * from Territories;

select TerritoryDescription as Cities
  from Territories
  order by Cities;

--3. Find all the cities in the Southern Region
select * from Region;
select * from Territories;

select *
	from Territories
	where RegionID = 4;

select TerritoryID, TerritoryDescription
	from Territories
	where RegionID = 4

select TerritoryID,
	   TerritoryDescription as CityName,
	   'Southern' as Region
	from Territories
	where RegionID = 4

-- 4. How do you run this query with the fully qualified column name?
select dbo.Territories.TerritoryID, --Just made it more specific.
	   TerritoryDescription as CityName,
	   'Southern' as Region
	from Territories
	where RegionID = 4

--5. How do you run this query with a table alias?
select T.TerritoryID, --Just made it more specific.
	   TerritoryDescription as CityName,
	   'Southern' as Region
	from dbo.Territories as T
	where RegionID = 4


select RegionID
  from Region
  where RegionDescription = 'Southern';

select *
  from Territories as T
  join Region as R
  on T.RegionID = R.RegionID
  where T.RegionID =
					( select RegionID
					  from Region
					  where RegionDescription = 'Southern');

--6. What is the contact name, telephone number, and city for each customer?
select * from Customers;

select ContactName, Phone, City
  from Customers;


--7. Products currently out of stock?
select * from Products;

select *
 from Products
 where UnitsInStock = 0;

 select *
 from Products
 where UnitsInStock = 0
   and Discontinued = 0;

--8. What are the 10 least stocked products
 select top(10) *
  from Products
  where UnitsInStock != 0
  order by UnitsInStock asc;

--9. What are the five most expensive products in stock?
 select top(5) *
  from Products
  where UnitsInStock > 0
  order by UnitPrice desc;

--How many products does Northwind have? How many customers? How many suppliers?
select count(*) as ProductCount
 from Products;

select count(*) as CustomerCount
 from Customers;

 select count(*) as SupplierCount
 from Suppliers;

--Extra. Average cost of a product
select * from Products;

select count(*), sum(UnitPrice) from Products;

select sum(UnitPrice) / count(*) as AveragePrice
 from Products;