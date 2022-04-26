--Create DATABASE
create database THB3
use THB3

----Table creation
create table Room 
(	
	Id int not null,
	Name nvarchar(20),
	Max int
)
go
create table Animal
(
	Id int not null,
	name nvarchar(50),
	Age int,
	Buy_at datetime,
	Room_id int
)
go
create table FoodType
(
	Id int not null,
	Name nvarchar(50),
	Price float,
	Amount float
)
go
create table FoodAnimal
(
	Food_id int,
	Animal_id int
)
go

--Add Primary key & foreign key
alter table FoodType
add constraint PK_Food_Id 
primary key (Id)
go
alter table Animal
add constraint PK_Animal_Id
primary key(Id)
go
alter table Room
add constraint PK_Room_Id
primary key(Id)
go

alter table FoodAnimal
add constraint FK_FoodId
foreign key (Food_Id)
references FoodType(Id)
go
alter table FoodAnimal
add constraint FK_AnimalId
foreign key (Animal_Id)
references Animal(Id)
go

--Insert 5 data
insert into Room(Id,Name,Max)
values
(1,'Chuong 1', 20),
(2,'Chuong 2', 10),
(3,'Chuong 3',15),
(4,'Chuong 4',25),
(5,'Chuong 5',30)
go
insert into Animal(Id,name,Age,Buy_at,Room_id)
values
(1,'Voi',11,'2021-4-5',1),
(2,'Su Tu',12,'2021-4-5',3),
(3,'Khi',13,'2021-4-5',5),
(4,'Ngua Van',14,'2021-4-5',4),
(5,'Huou Cao Co',15,'2021-4-5',2)
go
insert into FoodType(Id,Name,Price,Amount)
values
(1,'Co 4 la',10000,11),
(2,'Thit Heo',50000,12),
(3,'Co 5 la',40000,13),
(4,'Co luck luck',20000,14),
(5,'Co Cao Co',30000,15)
go
insert into FoodAnimal(Food_id,Animal_id)
values
(1,5),
(2,2),
(3,4),
(4,1),
(5,3)
go

--View AnimalInfo :	Room_name(Room),Animal_name(Animal),Age,Buy_at(Animal)
create view view_AnimalInfo
as
select Room.Name'Room Name',Animal.name'Animal Name',Animal.Age'Animal Age',Animal.Buy_at'Date Buy'
from Animal,Room
where Room.Id = Animal.Room_id
go
select * from view_AnimalInfo
order by view_AnimalInfo.[Room Name] asc
go

--View Room have animal > max :Room_name(Room),Max(Room)
update Animal
set Room_id = 2
where Room_id = 3 or Room_id = 1
go
select Room.Name,Count(Animal.Room_id)'Quantity Animal',Room.Max
from Room,Animal
where Room.Id = Animal.Room_id
group by Room.Name,Room.Max
having Count(Animal.Room_id) > Room.Max
go

--View Room have animal < max
select Room.Name,Count(Animal.Room_id)'Quantity Animal',Room.Max
from Room,Animal
where Room.Id = Animal.Room_id
group by Room.Name,Room.Max
having Count(Animal.Room_id) < Room.Max
go

--Write Proc @AnimalId -->display FoodInfo of animal
create proc proc_FoodInfo
@AnimalId int
as
begin
	select Animal.Id,Animal.name'Animal Name',FoodType.Name'Food Name',FoodType.Price,FoodType.Amount
	from Animal,FoodType,FoodAnimal
	where FoodType.Id = FoodAnimal.Food_id
	and Animal.Id = FoodAnimal.Animal_id
	and Animal.Id = @AnimalId
end
go
exec proc_FoodInfo 2
go



