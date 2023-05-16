
------------------------------------------------------------ DML EXERCISES ----------------------------------------------------------------------

create database DB_Electricity_Bill

use DB_Electricity_Bill

--create table with name electricity_connection_type

create table tbl_electricity_connection_type(id int primary key,connection_name varchar(20) not null)

--create table with name slab

select * from tbl_electricity_connection_type

create table tbl_slab(id int primary key,connection_type_id int foreign key(connection_type_id) references tbl_electricity_connection_type(connection_id) not null,from_unit int not null,to_unit int not null,rate double precision)

--create table with name building type

create table tbl_building_type(id int primary key, building_type_name varchar(100) not null,connection_type_id int foreign key references tbl_electricity_connection_type(id) not null)

--create table with name building

create table tbl_building(id int primary key,owner_name varchar(100) not null,building_address varchar(100) not null,building_type_id int foreign key references tbl_building_type(id) not null,contact_number varchar(100) not null,email_address varchar(100))

--rename column name owner_name as building_owner_name

EXEC SP_RENAME 'tbl_building.owner_name', 'building_owner_name', 'COLUMN'  

--alter column data size 

alter table tbl_building
alter column building_address varchar(255) not null

--rename table

exec sp_rename 'tbl_building', 'tbl_building_details'

--add constraint check_connection_name 

alter table tbl_electricity_connection_type 
add constraint check_connection_name 
check(connection_name in('home','commercial'))

--drop table slab

drop table tbl_slab

--drop table building_details

drop table tbl_building_details

insert into tbl_electricity_connection_type(connection_id,connection_name) values(1,'home')
insert into tbl_electricity_connection_type(connection_id,connection_name) values(2,'home')

update tbl_electricity_connection_type set connection_name = 'home' where connection_id = 1

update tbl_electricity_connection_type set connection_name = 'commercial' where connection_id = 2

select * from tbl_electricity_connection_type

insert into tbl_slab values(1,1,20,30,5.05)

insert into tbl_slab values(2,2,30,50,5.005)

select * from tbl_slab

insert into tbl_building_type values(1,'House',1)

insert into tbl_building_type values(2,'Mall',2)

insert into tbl_building_type values(3,'Apartment',1)




select * from tbl_building_type

update tbl_slab set from_unit = 1

update tbl_building_type set building_type_name ='mall' where id=2

delete from tbl_slab

delete from tbl_building_type where connection_type_id = 1

select * from tbl_building_type order by building_type_name asc

insert into tbl_building values(1,'sujith','coimbatore',1,'6381212770','saisujith@gmail.com')
insert into tbl_building values(7,'sujith','coimbatore',2,'6381212770','saisujith@gmail.com')
insert into tbl_building values(2,'vignesh','coimbatore',2,'9876543210','vignesh@gmail.com')
insert into tbl_building values(3,'sathashivam','coimbatore',1,'6798543210','sathashivam@gmail.com')
insert into tbl_building values(4,'Nicholas','Yercaud',1,'6798543210','nick@gmail.com')
insert into tbl_building values(5,'Micholas','',1,'6798543210','nick@gmail.com')
insert into tbl_building values(10,'Nicholas Pooran','',1,'6798543210','nick@gmail.com')



select * from tbl_building order by owner_name asc

create table tbl_meter(id int primary key,meter_number varchar(100) not null,building_id int foreign key references tbl_building(id)) 

insert into tbl_meter values(1,'1234',1)

insert into tbl_meter values(2,'1341',2)

insert into tbl_meter values(3,'1445',3)

select * from tbl_meter

create table tbl_electricity_reading(id int primary key,meter_id int foreign key references tbl_meter(id),_date date,h1 int,h2 int,h3 int,h4 int,h5 int,h6 int,h7 int,h8 int,h9 int,h10 int,h11 int,h12 int,h13 int,h14 int,h15 int,h16 int,h17 int,h18 int,h19 int,h20 int,h21 int,h22 int,h23 int,h24 int,total_units int not null)

insert into tbl_electricity_reading values(1,1,'2003-03-04',10,2,30,5,6,7,1,0,1,1,2,3,9,1,4,6,7,8,9,1,3,4,5,8,55)

insert into tbl_electricity_reading values(2,2,'2001-04-04',10,2,30,5,6,7,1,0,1,1,2,3,2,8,4,6,7,8,9,1,3,4,5,8,675)

insert into tbl_electricity_reading values(3,3,'2007-03-03',10,2,30,5,6,7,1,0,1,1,2,3,1,9,4,6,7,8,9,1,3,4,5,8,505)

delete from tbl_electricity_reading

select * from tbl_electricity_reading order by total_units desc

select meter_number from tbl_meter

select owner_name,contact_number from tbl_building order by owner_name asc

create table tbl_bill (id int primary key,meter_id int foreign key references tbl_meter(id),_month int not null,_year int not null,due_date date not null,total_units int not null,payable_amaount double precision not null,is_payed tinyint not null,payment_date date,fine_amount double precision)

insert into tbl_bill values(1,1,'04','2023','2024-04-05',150,1001.01,1,'2023-01-04',0)

insert into tbl_bill values(2,2,'01','2022','2022-04-05',250,1551.01,1,'2022-01-04',100)

insert into tbl_bill values(3,1,'01','2022','2022-04-05',10050,110000,1,'2017-10-01',200)

insert into tbl_bill values(9,1,'01','2022','2022-04-05',150,110000,1,'2017-12-01',200)

insert into tbl_bill values(6,1,'01','2022','2022-04-05',10050,110000,1,'2017-12-01',400)

insert into tbl_bill values(9,1,'12','2017','2022-04-05',1050,110000,0,'2017-12-01',400)

insert into tbl_bill values(11,1,'11','2017','2022-04-05',1250,110,1,'2017-12-01',90)

insert into tbl_bill values(12,2,'10','2017','2022-04-05',1250,110,1,'2017-12-01',120)

insert into tbl_bill values(13,1,'11','2019','2022-04-05',150,110,1,'2017-09-23',120)

delete from tbl_bill

select total_units,payable_amaount,fine_amount from tbl_bill order by total_units  desc 

select * from tbl_slab order by from_unit asc

select * from tbl_bill where total_units >= 10000

select * from tbl_bill where due_date = '2017-10-01' order by payable_amaount desc

select owner_name,contact_number from tbl_building where email_address = null order by owner_name asc

select * from tbl_building where SUBSTRING(LOWER(owner_name),1,1) = 'm'

select * from tbl_building where building_type_id = 2 order by owner_name asc

select * from tbl_electricity_reading where total_units between 500 and 1000 order by total_units asc

select meter_id,total_units  from tbl_electricity_reading where h13 < h14 order by total_units desc


-------------------------------------------------------- JOINS EXERCISES ----------------------------------------------------------------------------------

select meter_number,owner_name,building_address,contact_number,building_type_name,connection_name from tbl_building as building
inner join tbl_building_type as bt on building.building_type_id = bt.id
inner join tbl_meter as meter on building.id = meter.building_id 
join  tbl_electricity_connection_type on bt.connection_type_id = tbl_electricity_connection_type.connection_id
order by owner_name,meter_number asc

select * from tbl_bill inner join tbl_meter on tbl_bill.meter_id = tbl_meter.id order by payable_amaount 

select meter_number,owner_name,building_address,contact_number from tbl_building inner join tbl_meter on tbl_building.id = tbl_meter.building_id order by owner_name desc, meter_number desc

select connection_name,from_unit,to_unit,rate from tbl_slab 
inner join tbl_electricity_connection_type on tbl_electricity_connection_type.connection_id = tbl_slab.connection_type_id
order by rate desc

select * from tbl_bill

select owner_name,building_address,payable_amaount,meter_number,Max(fine_amount) as fine_amount from tbl_meter 
inner join tbl_bill on tbl_bill.meter_id = tbl_meter.id
inner join tbl_building on tbl_building.id = tbl_meter.building_id 
group by owner_name,building_address,payable_amaount,meter_number
order by owner_name 

select owner_name,building_address,count(tbl_building_type.connection_type_id)as connection_count from tbl_building 
join tbl_building_type on tbl_building_type.id = tbl_building.building_type_id
group by owner_name,building_address
order by owner_name

select owner_name,building_address,meter_number,total_units from tbl_meter
join tbl_building on tbl_building.id = tbl_meter.building_id
join tbl_bill on tbl_bill.meter_id = tbl_meter.id
where _month = 12 and _year = 2017
order by total_units desc

select owner_name,building_type_name,meter_number,payment_date, IIF(is_payed = 1,'payed','not payed') as payment_status from tbl_meter
join tbl_building on tbl_building.id = tbl_meter.building_id
join tbl_bill on tbl_bill.meter_id = tbl_meter.id
join tbl_building_type on tbl_building_type.id = tbl_building.building_type_id
where _month = 12 and _year = 2017
order by owner_name

select building_type_name , count(connection_type_id) as number_of_connections from tbl_building_type 
join tbl_building on tbl_building.building_type_id = tbl_building_type.id
group by building_type_name

select meter_number,owner_name,building_address from tbl_meter 
join tbl_building on tbl_building.id = tbl_meter.building_id
join tbl_bill on tbl_bill.meter_id = tbl_meter.id
group by meter_number,owner_name,building_address
having count(is_payed) > 0
order by owner_name


  -------------------------------------------------------- AGGREGATE FUNCTIONS ---------------------------------------------------- 
   create database purchase

   use  purchase
	  CREATE TABLE customers (
	  id INT PRIMARY KEY,
	  customer_name VARCHAR(50),
	  address VARCHAR(100),
	  phone_number VARCHAR(15));

	CREATE TABLE orders (
	  order_id INT PRIMARY KEY,
	  order_date DATE,
	  customer_id INT,
	  salesman_name VARCHAR(100),
	  purchase_amount DECIMAL(10, 2),
	  FOREIGN KEY (customer_id) REFERENCES customers(id));
	
	
	-- Insert values into the customers table
	INSERT INTO customers (id, customer_name, address, phone_number)
	VALUES (1, 'John Doe', '123 Main St', '555-1234'),
		   (2, 'Jane Smith', '456 Elm St', '555-5678'),
		   (3, 'Robert Johnson', '789 Oak St', '555-9101');

	-- Insert values into the orders table
	INSERT INTO orders (order_id, order_date, customer_id, salesman_name, purchase_amount)
	VALUES (1, '2023-05-01', 1, 'Tom', 100.00),
		   (2, '2023-05-02', 1, 'Tom', 75.50),
		   (3, '2023-05-03', 2, 'Sarah', 200.00);

	
  select sum(purchase_amount) as total_purchase_amount from orders

  select avg(purchase_amount) as total_purchase_amount from orders

  select min(purchase_amount) as total_purchase_amount from orders

  select max(purchase_amount) as total_purchase_amount from orders

  select COUNT(salesman_name) from orders

  select id,max(purchase_amount) from customers 
  join orders on orders.customer_id = customers.id
  group by id
 
  
  --------------------------------------------------  WILDCARDS EXERCISES --------------------------------------------------------

  select * from salesman
  where city like 'Paris' or city like 'Rome'

  select salesman_id,salesman_name,city from salesman
  where city not like 'Paris' and city not like 'Rome'

  select * from customers
  where customer_id >= 3007 and customer_id <= 3009

  select * from salesman
  where commision >= 0.12 and commision <= 0.14

  select * from orders
  where purchase_amount between 500 and 4000 and purchase_amount not in (948.50,1983.43)

  select * from saleseman
  where salesman_name like 'A%K'

  select * from saleseman
  where salesman_name not like 'A%L'

  select * from customer
  where customer_name like 'B%'

  select * from customer
  where customer_name like '%n'


  -------------------------------------------------------  STRING EXERCISES -----------------------------------------------------------


  select owner_name ,len(owner_name) as name_length from tbl_building
  order by owner_name

  select owner_name,contact_number from tbl_building
  where len(owner_name) = (select min(len(owner_name))  from tbl_building) order by owner_name
	
  select owner_name,concat(contact_number,' - ',email_address) as contact_details from tbl_building

  select left(meter_number,3) as meter_code from tbl_meter
  order by meter_code desc

  select left(owner_name,3) as name_code , contact_number from tbl_building
  order by owner_name

  select * from tbl_building_type
  where lower(right(building_type_name,1)) = 'l' order by building_type_name

  select * from tbl_building
  where owner_name like '%di%' order by owner_name



  -------------------------------------------------- BOOLEAN AND RELATIONAL OPERATORS ------------------------------------------------------- 


  select order_name,order_date,purchase_amount from salesman
  where salesman_id = 5001 

  select * from customers
  where grade > 100

  select * from customers
  where city = 'New York' and grade > 100 

  select * from customers
  where not city = 'New York' or grade > 100

  select * from customers
  where city = 'New York' or not grade > 100

  select salesman_id , salesman_name , city from salesman 
  where commission > 0.10 and commission < 0.12

  select * from orders
  where (purch_amt<200 or not (ord_date>='2012-02-10' and customer_id<3009))

  select * from employees
  where department = 47 or department = 63

	------------------------------------------------------- SET AND UNION -----------------------------------------------------------------------

	select * from salesman
	where city='London'union
	select *from customer
	where city='London'


	select distinct salesman_name,cities from salesman
	union
	select distinct salesman_name,cities from customer


	select * from Salesman
	union
	select * from Customer;


	select order_date, salesman_id, MAX(order_amount) as largest_order from orders 
	group by order_date, salesman_id
	union
	select order_date, salesman_id, MIN(order_amount) as smallest_order from orders 
	group by order_date, salesman_id


	select s.salesman_name, s.city, 'Has Customers' as status from Salesman s
	INNER JOIN Customer c on s.city = c.city
	union
	select s.salesman_name, s.city, 'No Customers' as status
	from Salesman s
	where s.city NOT IN (select distinct city from Customer)




	----------------------------------------------------- DATE AND TIME ------------------------------------------------------------------------

  select * from tbl_bill

  select count(id) as bill_payed from tbl_bill
  where is_payed = 1 and _month = 10 and _year = 2017

  select fine_amount as total_fine_amount from tbl_bill
  where _month between 10 and 11

  select * from tbl_bill
  where payment_date = '2017-09-23'

