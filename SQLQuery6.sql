
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
insert into tbl_building values(5,'Micholas','Yercaud',1,'6798543210','nick@gmail.com')

select * from tbl_building

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

insert into tbl_bill values(8,1,'12','2017','2022-04-05',150,110000,1,'2017-12-01',400)

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
