create database BT1776
use BT1776

create table BangHangHoa
(
	Id int primary key identity(1,1),
	Ten_mat_hang varchar(100),
	Nha_san_xuat varchar(50),
	Xuat_xu varchar(30),
	Gia_nhap money,
	Gia_ban money,
	Ngay_san_xuat date
)
go

insert into BangHangHoa(Ten_mat_hang,Nha_san_xuat,Xuat_xu,Gia_ban,Gia_nhap,Ngay_san_xuat)
values
('A','SxA','Ha Noi',10000,5000,'2022-03-30'),
('B','SxB','Ha Tinh',7000,1000,'2021-02-13'),
('B','SxB','Ha Nam',89000,50000,'2020-01-12'),
('C','SxC','Ha Giang',76000,34400,'2019-12-24'),
('D','SxD','Sai Gon',13300,12300,'2018-05-08')
go

create table BangBanHang
(
	Id_don_hang int primary key identity(1,1),
	Id_hang_hoa int,
	foreign key (Id_hang_hoa)references BangHangHoa(Id),
	Chu_thich text,
	Ngay_ban date,
	So_luong int
)
go

insert into  BangBanHang(Id_hang_hoa,Chu_thich,Ngay_ban,So_luong)
values
(1,'ahifha', '2021-04-01', 99),
(3,'sddfggs', '2021-04-01', 18),
(5,'afsdfggs', '2021-04-01', 98),
(4,'sgfgfd', '2021-04-01', 12),
(10,'ahigfha', '2021-04-01', 89),
(9,'sdgs', '2021-04-01', 12),
(7,'af34bdgsgs', '2021-04-01', 967),
(8,'sgf34d', '2021-04-01', 99),
(6,'ahi34fha', '2021-04-01', 99),
(2,'ahifha', '2021-04-01', 99)
go

select * from BangBanHang
select *from BangHangHoa

update BangHangHoa
set Xuat_xu = 'Viet Nam'
where Ten_mat_hang = 'B'

create  view view_list_name_product
as 
select * from BangBanHang,BangHangHoa
where BangBanHang.Id_hang_hoa = BangHangHoa.Id and BangHangHoa.Xuat_xu = 'Viet Nam'
go

select * from view_list_name_product

create view view_sum_sell_product
as
select BangHangHoa.Ten_mat_hang,sum(BangBanHang.So_luong+BangHangHoa.Gia_ban)'Tong gia ban'
from BangBanHang join BangHangHoa on BangBanHang.Id_hang_hoa=BangHangHoa.Id
group by BangHangHoa.Ten_mat_hang
go

select * from view_sum_sell_product
go