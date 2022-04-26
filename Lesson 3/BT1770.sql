CREATE DATABASE BT1770
USE BT1770

CREATE TABLE Product
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Title VARCHAR(50),
	Thumbnail  VARCHAR(100),
	Content VARCHAR(1000)
);

CREATE TABLE DanhMucSanPham
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(100)
);



ALTER TABLE Product
ADD Price FLOAT;

ALTER TABLE Product
ADD Num FLOAT;

ALTER TABLE Product
ADD Created_at DATE;

ALTER TABLE Product
ADD Updated_at DATETIME;

ALTER TABLE Product
ADD Id_cat INT;

ALTER TABLE Product
ADD CONSTRAINT fk_Id_danhmuc FOREIGN KEY (Id_cat)
REFERENCES DanhMucSanPham(Id);

INSERT  INTO Product(Title,Thumbnail,Content,Price,Num,Created_at,Updated_at)
VALUES
('But chi','Taphoa.com.vn','KieuLONGTEXT',17000,100,'2022-10-10','2022-10-11'),
('Thuoc ke','taphoa.com.vn','KieuLONGTEXT',37000,130,'2022-10-10','2022-10-11'),
('But bi','Taphoa.com.vn','KieuLONGTEXT',76000,50,'2022-10-10','2022-10-11'),
('Banh mi','Taphoa.com.vn','KieuLONGTEXT',21000,120,'2022-10-10','2022-10-15'),
('Sua tuoi','Taphoa.com.vn','KieuLONGTEXT',87000,4,'2022-10-10','2022-10-16')
;

UPDATE  Product
SET Price = 5000
WHERE Price = 0 OR Price = NULL OR Price = ''
;

UPDATE Product
SET Price=Price-10%
WHERE Created_at < '2020-06-06'

DELETE  FROM Product 
WHERE Created_at < '2016-12-31'

SELECT *FROM Product
SELECT* FROM DanhMucSanPham

