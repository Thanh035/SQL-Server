create database BT1825
use BT1825

create table BaiDoXe
(
	Ten_bai varchar(100),
	Ma_bai_do_xe varchar(10),
	Dia_chi varchar(70)
);

create table ThongTinGui
(
	Ten_xe varchar(50),
	Bien_do_xe varchar(30),
	Ma_bai_do_xe varchar(10),
	Ngay_gui_xe date,
	Ngay_lay_xe date,
	Chi_phi float,
	Id_chu_so_huu int
);

create table ChuSoHuu
(
	Id_chu_so_huu int,
	Ten varchar(50),
	So_CMND int,
	Dia_chi varchar(70)
);

insert into BaiDoXe(Ten_bai,Ma_bai_do_xe,Dia_chi)
values
('A','001','Mydinh'),
('B','002','Giapbat'),
('C','003','Gialam')
go

insert into ThongTinGui(Ten_xe,Bien_do_xe,Ma_bai_do_xe,Ngay_gui_xe,Ngay_lay_xe,Chi_phi,Id_chu_so_huu)
values 
('Mercesdes','1234','001','10-05-2020','11-11-2020',2000000000,1),
('Maybach','3456','002','05-05-2020','06-06-2020',25000000000,2),
('Toyota','5678','003','10-05-2020','11-11-2020',14000000000,3)
go

insert into ChuSoHuu(Id_chu_so_huu,Ten,So_CMND,Dia_chi)
values
(1,'Huyen',001302015197,'Vancanh'),
(2,'Bong',00130208902,'Ditrach'),
(3,'Thuy',00130203859,'Kimhoang')
go

select * from BaiDoXe
select * from ThongTinGui
select * from ChuSoHuu

select ChuSoHuu.So_CMND,ChuSoHuu.Ten,BaiDoXe.Ten_bai,ThongTinGui.Bien_do_xe
from ChuSoHuu,BaiDoXe,ThongTinGui
where BaiDoXe.Ma_bai_do_xe = ThongTinGui.Ma_bai_do_xe and ThongTinGui.Id_chu_so_huu = ChuSoHuu.Id_chu_so_huu
go

create proc proc_DemSoXe 
	@IdChuSoHuu int
as 
	begin
		select ChuSoHuu.Id_chu_so_huu,ChuSoHuu.Ten,Count(ThongTinGui.Id_chu_so_huu) as SoluotGuiXe
		from ChuSoHuu inner join ThongTinGui  on ChuSoHuu.Id_chu_so_huu = ThongTinGui.Id_chu_so_huu
		where ChuSoHuu.Id_chu_so_huu = @IdChuSoHuu 
		group by ChuSoHuu.Id_chu_so_huu,ChuSoHuu.Ten
	end
go
 
exec proc_DemSoXe 1
exec proc_DemSoXe 2

create proc proc_TinhTongChiPhiXe 
	@IdChuSoHuu int
as 
	begin
		select ChuSoHuu.Id_chu_so_huu,ChuSoHuu.Ten,Sum(ThongTinGui.Chi_phi) as ChiPhiGuiXe
		from ChuSoHuu inner join ThongTinGui  on ChuSoHuu.Id_chu_so_huu = ThongTinGui.Id_chu_so_huu
		where ChuSoHuu.Id_chu_so_huu = @IdChuSoHuu 
		group by ChuSoHuu.Id_chu_so_huu,ChuSoHuu.Ten
	end
go

exec proc_TinhTongChiPhiXe 2

create proc proc_KiemTraGuiXe
	@DemNgay date
as 
	begin
		select ChuSoHuu.So_CMND,ChuSoHuu.Ten,ThongTinGui.Ma_bai_do_xe,ThongTinGui.Bien_do_xe
		from ThongTinGui inner join ChuSoHuu on ChuSoHuu.Id_chu_so_huu = ThongTinGui.Id_chu_so_huu
		where @DemNgay between ThongTinGui.Ngay_gui_xe and ThongTinGui.Ngay_lay_xe
		group by ChuSoHuu.So_CMND,ChuSoHuu.Ten,ThongTinGui.Ma_bai_do_xe,ThongTinGui.Bien_do_xe
	end
go

exec proc_KiemTraGuiXe '11-05-2020'
	
create proc proc_TungGuiXe
@IdChuSoHuu int
as
	begin
		select ChuSoHuu.Dia_chi,ChuSoHuu.Ten,BaiDoXe.Ten_bai, ThongTinGui.Ma_bai_do_xe'Bai do xe', ThongTinGui.Bien_do_xe 'Bien so xe'
		from ThongTinGui,ChuSoHuu,BaiDoXe
		where  ChuSoHuu.Id_chu_so_huu = @IdChuSoHuu and ThongTinGui.Id_chu_so_huu = ChuSoHuu.Id_chu_so_huu and ThongTinGui.Ma_bai_do_xe=BaiDoXe.Ma_bai_do_xe
	end
go

exec proc_TungGuiXe 1
