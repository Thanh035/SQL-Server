--Tao CSDL
create database BT1788
use BT1788

--Tao bang
create table Hotel
(
	Id int primary key identity(1,1),
	Ten_khach_san varchar(100),
	Dia_chi_khach_san varchar(200),
	Dien_tich int,
	Chu_so_huu_khach_san varchar(50)
);

create table Room
(
	Room_no int primary key,
	Id_hotel int,
	foreign key (Id_hotel)
	references Hotel(Id),
	Dien_tich float,
	Loai_phong varchar(50),
	Floor int
);

create table Book
(
	Id int primary key identity(1,1),
	Room_no int,
	foreign key(Room_no)
	references Room(Room_no),
	Ngay_dat_phong date,
	Ngay_tra_phong date,
	So_nguoi int,
	Gia_tien money
);
--Chen du lieu vao bang
insert into Hotel(Ten_khach_san,Dia_chi_khach_san,Dien_tich,Chu_so_huu_khach_san)
values
('KS1','Dia Chi A',1110,'Nguyen Van A'),
('KS2','Dia Chi B',122,'Nguyen Van B'),
('KS3','Dia Chi C',303,'Nguyen Van C'),
('KS4','Dia Chi D',404,'Nguyen Van D'),
('KS5','Dia Chi E',550,'Nguyen Van E')
go

insert into Room(Room_no,Id_hotel,Dien_tich,Loai_phong,Floor)
values
(120 ,1 ,23 ,'Don' ,12),
(130 ,2 ,50,'Doi' ,13),
(140 ,3 ,78,'Villa' ,20),
(141 ,4 ,78 ,'Villa' ,20),
(145 ,5 ,78 ,'Villa' ,25)
go

insert into Book(Room_no,Ngay_dat_phong,Ngay_tra_phong,So_nguoi,Gia_tien)
values
(120,'2020-12-04','2020-12-09',1,100000),
(130,'2020-09-04','2020-09-09',2,250000),
(145,'2020-12-05','2020-12-26',5,500000),
(140,'2020-11-09','2020-11-25',3,400000),
(141,'2020-06-04','2020-06-10',2,400000)
go

--Hien thi thong tin gom cac truong:Ten KS,Dia chi,Ma phong,Loai phong,Tang
--Hien thi tat ca
select * from Hotel
select * from Room
select * from Book
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,Room.Room_no,Room.Loai_phong,Room.Floor
from Hotel,Room
where Hotel.Id = Room.Id_hotel
--Hien cac phong dien tich > 30
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,Room.Room_no,Room.Loai_phong,Room.Floor
from Hotel,Room
where Hotel.Id = Room.Id_hotel and  Room.Dien_tich > 30
group by Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,Room.Room_no,Room.Loai_phong,Room.Floor
go

--Thong ke :Ten KS,Dia chi,So phong
create view view_thongke_tatca
as
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,COUNT(Book.Room_no)'So Phong'
from Hotel,Room,Book
where Hotel.Id = Room.Id_hotel and Room.Room_no = Book.Room_no
group by Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san
go 
select * from view_thongke_tatca

create view view_sophong_more_than5
as
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,COUNT(Book.Room_no)'So Phong'
from Hotel,Room,Book
where Hotel.Id = Room.Id_hotel
group by Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san
having COUNT(Book.Room_no) > 5
go
select * from view_sophong_more_than5

--Thong ke ten theo du lieu : TenKS,Dia chi,Dien tich
--Dien tich phong lon nhat
select top(1) Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,Room.Dien_tich
from Hotel,Room
where  Hotel.Id = Room.Id_hotel
order by(Room.Dien_tich) desc
go

--Dien tich phong nho nhat
select top(1) Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,Room.Dien_tich
from Hotel,Room
where  Hotel.Id = Room.Id_hotel
order by(Room.Dien_tich) asc
go

--Tong dien tich cua tat ca cac phong
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,sum(Room.Dien_tich) as Tongdientich
from Hotel,Room
where  Hotel.Id = Room.Id_hotel
group by Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san
go

--Dien tich trung binh cua tung phong
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,avg(Room.Dien_tich) as Dien_Tich_trung_binh
from Hotel,Room
where  Hotel.Id = Room.Id_hotel
group by Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san
go

--Khach san khong co phong nao
select Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san,count(Room.Room_no) as So_phong
from Hotel
inner join Room on Hotel.Id = Room.Id_hotel
group by Hotel.Ten_khach_san,Hotel.Dia_chi_khach_san
having count(Room.Room_no) = 0
go



