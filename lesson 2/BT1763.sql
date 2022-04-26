CREATE DATABASE BT1763
USE BT1763

--Tao bang
CREATE TABLE BANGSINHVIEN
(
	Rollno int primary key,
  	Fullname varchar(50),
  	Age int,
  	Address varchar(30),
  	Email varchar(40),
  	PhoneNumber varchar(15),
  	Gender char(5)
)
CREATE TABLE BANGMONHOC
(
	MaMonHoc int primary key identity(1,1) ,
  	TenMonHoc varchar(50)
)

CREATE TABLE BANGDIEM
(
	Diem int,
  	RollNo int PRIMARY KEY,
  	MaMonHoc varchar(10)
)
CREATE TABLE BANGLOPHOC
(
	MaLopHoc int identity(1,1),
  	TenLopHoc varchar(10),
  	RollNo int 
)
CREATE TABLE BANGPHONGHOC
(
	TenPhongHoc varchar(10),
	MaPhongHoc int identity(1,1),
	SoBanHoc int,
	SoGheHoc int,
	DiaChiLopHoc varchar(20)
)
--Them du lieu vao tung bang
INSERT INTO BANGSINHVIEN (Rollno,Fullname,Age,Address,Email,PhoneNumber,Gender)
VALUES
(1,'Phung Quang Thanh',19,'Ha Noi','phthanh035@gmail.com','0921321312','Nam'),
(2,'Doan Minh Phuong',78,'Soc Son','ph123nh035@gmail.com','021313212','Nam'),
(3,'Tran Dai Nghia',3,'Phu Tho','phu2132135@gmail.com','09243232','Nam'),
(4,'Le Thanh Nghi',12,'Ha Noi','phungqu213215@gmail.com','0924231312','Nam'),
(5,'Kim Lien',12,'Soc Son','21uaan35@gmail.com','092243242','Nam')
go
INSERT INTO BANGMONHOC(TenMonHoc)
VALUES
('Toan'),
('Van'),
('Lich Su'),
('Dia ly'),
('Cong Nghe')
go
INSERT INTO BANGDIEM(Diem,RollNo,MaMonHoc)
VALUES
(5,1,1),
(6,2,2),
(7,3,3),
(10,4,4),
(9,5,5)
go

INSERT INTO BANGLOPHOC(TenLopHoc,RollNo)
VALUES
('LP1',1),
('LP2',2),
('LP3',3),
('LP4',4),
('LP5',5)
go
INSERT INTO BANGPHONGHOC(TenPhongHoc,SoBanHoc,SoGheHoc,DiaChiLopHoc)
VALUES
('LP1',321,12,'DC1'),
('LP2',32,43,'DC2'),
('LP3',87,45,'DC3'),
('LP4',3,8,'DC4'),
('LP5',76,45,'DC5')
go

--Hien thi du lieu trong cac bang 
SELECT *FROM BANGSINHVIEN
SELECT *FROM BANGPHONGHOC
SELECT *FROM BANGMONHOC
SELECT *FROM BANGLOPHOC
SELECT *FROM BANGDIEM

--Hien thi phong hoc co so ban >5 && so ghe >5
SELECT *FROM BANGPHONGHOC
WHERE SoBanHoc > 5 AND SoGheHoc > 5
go

--Hien thi phong hoc co (soban >5 && <20)&&(SoGhe>5&&<20) 
SELECT *FROM BANGPHONGHOC
WHERE (SoBanHoc BETWEEN 6 AND 19) AND (SoGheHoc BETWEEN 6 AND 19)
go