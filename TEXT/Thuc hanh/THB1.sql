--Database Creation
create database TEXTQuanLyNhanKhau
use TEXTQuanLyNhanKhau

--table Creation
create table QuanHuyen
(
	MaQH int identity(1,1) not null,
	TenQH nvarchar(100)
)
go
create table DuongPho
( 
	DuongID int not null,
	MaQH int not null,
	TenDuong nvarchar(MAX) not null,
	NgayDuyetTen datetime null
)
go
create table NhaTrenPho
(
	NhaID int not null,
	DuongID int not null,
	ChuHo nvarchar(50) null,
	DienTich money null
)
go

--Index and Table Alternation
Create CLUSTERED INDEX CI_NhaTrenPho_NhaID
on NhaTrenPho(NhaID)
go
Create NONCLUSTERED INDEX UI_QuanHuyen_TenQH
on QuanHuyen(TenQH)
go
Alter table NhaTrenPho
add SoNhanKhau int
go

--Constraint
----PRIMARY KEY
alter table QuanHuyen
add constraint PK_QuanHuyen
primary key (MaQH)
go
alter table DuongPho
add constraint PK_DuongPho
primary key (DuongID)
go
alter table NhaTrenPho
add constraint PK_NhaTrenPho
primary key (NhaID)
go
----FOREIGN KEY
alter table NhaTrenPho
add constraint FK_NhaTrenPho_DuongPho
foreign key (DuongID)
references DuongPho(DuongID)
go
alter table DuongPho
add constraint FK_DuongPho_QuanHuyen
foreign key (MaQH)
references QuanHuyen(MaQH)
go
----CHECK
alter table DuongPho
add constraint CK_DuongPho_NgayDuyetTen
check (NgayDuyetTen between '1945-09-02' and getdate())
go

--Inserting Data
insert into QuanHuyen(TenQH)
values
('Ba Dinh'),
('Hoang Mai')
go
insert into DuongPho(DuongID,MaQH,TenDuong,NgayDuyetTen)
values
(1,1,'Doi Can','1946-10-19'),
(2,1,'Van Phuc','1998-12-30'),
(3,2,'Giai Toa','1975-09-21')
go
insert into NhaTrenPho(NhaID,DuongID,ChuHo,DienTich,SoNhanKhau)
values
(1,1,'Ha Khanh Toan',100,4),
(2,1,'Le Hong Hai',20,12),
(3,2,'Tran Khanh',40,1)
go

--Query Operations
update DuongPho
set TenDuong = 'Giai Phong'
where TenDuong = 'Giai Toa'
go

--Views
create view view_all_NhaTrenPho2

--Views
create view _AVG_NhaTrenPho2

--Procedure



