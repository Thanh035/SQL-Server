CREATE DATABASE BT1795
USE BT1795

CREATE TABLE BaiDoXe
(
	Ten_bai NVARCHAR(50),
	Ma_bai_do_xe INT PRIMARY KEY IDENTITY(1,1),
	Dia_chi NVARCHAR(200)
);

CREATE TABLE ThongTinGui
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Ten_xe NVARCHAR(50),
	Bien_so_xe NVARCHAR(20),
	Ma_bai_do_xe INT NOT NULL,
	CONSTRAINT fk_htk_Ma_bai_do_xe
	FOREIGN KEY (Ma_bai_do_xe)
	REFERENCES BaiDoXe (Ma_bai_do_xe),
	Id_chu_so_huu INT NOT NULL,
	CONSTRAINT fk_htk_Id_chu_so_huu
	FOREIGN KEY (Id_chu_so_huu)
	REFERENCES BangChuSoHuu(Id_chu_so_huu)
);
CREATE TABLE BangChuSoHuu
(
	Id_chu_so_huu INT PRIMARY KEY IDENTITY(1,1),
	Ten NVARCHAR(50),
	So_CMND NVARCHAR(20),
	Dia_chi nvarchar(200)
);

--Chen 5 ban ghi
INSERT INTO BaiDoXe(Ten_bai,Dia_chi)
VALUES
('Bai xe 01','Ha Noi'),
('Bai xe 02','Soc Son'),
('Bai xe 03','Ha Tinh'),
('Bai xe 04','Binh Dinh'),
('Bai xe 05','Phu Tho');
INSERT INTO BangChuSoHuu(Ten,So_CMND,Dia_chi)
VALUES
('Thanh','12345721','Ha Noi'),
('Quang','35688991','Ha Noi'),
('Long','53757451','Ha Noi'),
('Viet','43543541','Ha Noi'),
('Duc','65346541','Soc Son');
INSERT INTO ThongTinGui(Ten_xe,Bien_so_xe,Ma_bai_do_xe,Id_chu_so_huu)
VALUES
('Porches','GFG',01,1),
('Lamborghini','GHH',02,2),
('Mazda','HTV',03,3),
('G63','HJK',04,4),
('Rolls royce','ASD',05,5);

--Hien thi so lan gui xe cua tat ca cac chu so huu
