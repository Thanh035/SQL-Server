--Database Creation
create database QuanLyNhanKhau
use QuanLyNhanKhau

--Table Creation
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
create clustered index CI_NhaTrenPho_NhaID
on NhaTrenPho(NhaID)
go

create unique index UI_QuanHuyen_TenQH
on QuanHuyen(TenQH)
go

alter table NhaTrenPho
add SoNhanKhau int
go
--Constraint
--Primary key
alter table QuanHuyen
add constraint PK_QuanHuyen
primary key(MaQH)
go

alter table DuongPho
add constraint PK_DuongPho
primary key(DuongID)
go

alter table NhaTrenPho
add constraint PK_NhaTrenPho
primary key(NhaID)
go
--Foreign key
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

alter table DuongPho
add constraint CK_DuongPho_NgayDuyetTen
Check (NgayDuyetTen between '1945-09-02' and '2022-04-11')
go

--Inserting data
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

--Query operations
update DuongPho
set TenDuong = 'Giai Phong'
where TenDuong = 'Giai Toa'
go

--Views
create view vw_all_Nha_Tren_Pho 
as
	select QuanHuyen.TenQH,DuongPho.TenDuong,DuongPho.NgayDuyetTen,
	NhaTrenPho.ChuHo,NhaTrenPho.DienTich,NhaTrenPho.SoNhanKhau
	from QuanHuyen,DuongPho,NhaTrenPho
	where NhaTrenPho.DuongID=DuongPho.DuongID 
	and QuanHuyen.MaQH = DuongPho.MaQH
go

select * from vw_all_Nha_Tren_Pho
go

--Views
create view vw_AVG_Nha_Tren_Pho
as
select DuongPho.TenDuong,AVG(NhaTrenPho.DienTich)'Dien Tich Trung Binh',AVG(NhaTrenPho.SoNhanKhau)
'So Nhan Khau Trung Binh'
from DuongPho inner join NhaTrenPho
on NhaTrenPho.DuongID = DuongPho.DuongID
group by  DuongPho.TenDuong
go	

select * from vw_AVG_Nha_Tren_Pho
order by vw_AVG_Nha_Tren_Pho.[Dien Tich Trung Binh] asc,vw_AVG_Nha_Tren_Pho.[So Nhan Khau Trung Binh] asc
go
 
--Procedure
create proc sp_NgayDuyetTen_DuongPho
@NgayDuyet datetime
as
	begin
		select DuongPho.NgayDuyetTen,DuongPho.TenDuong,QuanHuyen.TenQH
		from DuongPho,QuanHuyen
		where NgayDuyetTen = @NgayDuyet
	end
go

exec sp_NgayDuyetTen_DuongPho '1998-12-30'
go
