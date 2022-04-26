create database BT2243
use BT2243

create table Management
(
	Id int primary key identity(1,1),
	Fullname nvarchar(50) not null,
	Address nvarchar(200) not null,
	Level float,
	Experience date 
);

create table FootballTeam
(
	Id int primary key identity(1,1),
	Name nvarchar(50),
	Home_field nvarchar(100),
	Trainer nvarchar(50)
);

create table History
(
	Id int primary key identity(1,1),
	Id_umpire int references Management(Id),
	Tournaments nvarchar(100) not null,
	Start_day date,
	Rate float,
	Id_club_1 int references FootballTeam(Id),
	Id_club_2 int references FootballTeam(Id),
	Note varchar(500)
);

create table PlayerInfo
(
	Id int primary key identity(1,1),
	Fullname nvarchar(50),
	Birthday date,
	Salary money,
	Start_day date
);

create table FootballGroup
(
	Id_club int references FootballTeam(Id),
	Id_player int references PlayerInfo(Id),
	join_date date
);

--Add Data on table
insert into Management(Fullname,Address,Level,Experience)
values
('Trong Tai A','Ha Noi',6,'2021-3-20'),
('Trong Tai B','Ha Nam',7,'2021-2-15'),
('Trong Tai C','Nam Dinh',9,'2021-1-10'),
('Trong Tai D','Ha Tay',8,'2021-2-25'),
('Trong Tai E','Ha Dong',5,'2021-3-10')
go

insert into History(Id_umpire,Tournaments,Start_day,Rate,Id_club_1,Id_club_2)
values
(1, 'League A', '2019-10-21', 7.5, 1, 2),
(1, 'League B', '2019-12-07', 6.5, 4, 5),
(3, 'League C', '2019-11-16', 5.0, 5, 3),
(3, 'League D', '2019-09-12', 7.5, 2, 1),
(2, 'League E', '2019-08-11', 8.0, 4, 3)
go

insert into FootballTeam(Name,Home_field,Trainer)
values
('Doi A','San nha A','Huan luyen vien A'),
('Doi B','San nha A','Huan luyen vien B'),
('Doi C','San nha A','Huan luyen vien C'),
('Doi D','San nha B','Huan luyen vien D'),
('Doi E','San nha B','Huan luyen vien E')
go

insert into PlayerInfo(Fullname,Birthday,Salary,Start_day)
values
('Nguyen Van A','2000-05-15',1000,'2021-1-1'),
('Nguyen Nam B','2000-04-05',1100,'2021-1-1'),
('Nguyen Dao C','2000-03-10',1200,'2021-1-1'),
('Nguyen Tran D','2000-12-03',1300,'2021-1-1'),
('Nguyen Hung E','2000-04-10',1400,'2021-1-1')
go

insert into FootballGroup(Id_club,Id_player,join_date)
values
(5,1,'2020-5-5'),
(4,5,'2020-5-4'),
(3,4,'2020-5-3'),
(2,3,'2020-5-2'),
(1,2,'2020-5-1')
go

select * from Management
select * from History
select * from FootballTeam
select * from PlayerInfo
select * from FootballGroup

--View info referee's areest history :Fullname(Management),Level(Management),Experience(management),tournaments(history),
--id_club(history)
create view view_info_arrest_history
as
select Management.Fullname,Management.Level,Management.Experience,History.Tournaments,History.Id_club_1,History.Id_club_2
from Management inner join History 
on Management.Id = History.Id_umpire
go

select * from view_info_arrest_history
--View Info player 
create view view_info_player
as
select * from PlayerInfo left join FootballGroup 
on PlayerInfo.Id = FootballGroup.Id_player
go

select * from view_info_player

----View info history of umpire :
create proc proc_info_history_of_umpire
	@Id_player int
	as
	begin
		select Management.Fullname,Management.Level,Management.Experience,History.Tournaments,History.Id_club_1,History.Id_club_2
		from Management inner join History 
		on Management.Id = History.Id_umpire
		where History.Id_club_1 = @Id_player or History.Id_club_2 = @Id_player
	end
go

exec proc_info_history_of_umpire 1