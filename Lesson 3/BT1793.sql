create DATABASE StudentManagementSystem
use  StudentManagementSystem
--Tao bang
create table Class
(
	ClassId int not null,
  	ClassCode nvarchar(50)
);
create table Student
(
	StudentId int not null,
  	StudentName varchar(50),
  	Birthdate datetime,
  	ClassId int
);
create table Subject
(
	SubjectId int not null,
  	SubjectName nvarchar(100),
  	SessionCount int
);
create table Result
(
	StudentId int not null,
  	SubjectId int not null,
  	Mark int
);
alter table Result
alter column Mark float
;

alter table Class
add CONSTRAINT PK_Class PRIMARY key (classid)
;
alter table Student 
add constraint PK_Student PRIMARY key (studentid)
;
alter table Subject 
add constraint PK_Subject PRIMARY key(subjectid)
;
alter table Result
add CONSTRAINT PK_Result PRIMARY key (studentid,subjectid)
;

alter table Student
add constraint FK_Student_Class foreign key (classid) references Class(classid)
;
alter table Result
add constraint FK_Result_Student foreign key (studentid) references Student(studentid)
;

alter table Result 
add constraint FK_Result_Subject FOREIGN key (subjectid) references Subject(subjectid)
;

alter table Subject
add CONSTRAINT CK_Subject_SessionCount check(sessioncount>0);

insert into Class(classid,classcode)
VALUES
(1,'C1106KV'),
(2,'C1108GV'),
(3,'C1108IV'),
(4,'C1108HV'),
(5,'C1108GV')
;
insert into Student(studentid,studentname,birthdate,classid)
VALUES
(1,'Pham Tuan Anh','1993-08-05',1),
(2,'Pham Van Huy','1992-06-10',2),
(3,'Nguyen Hoang Minh','1992-09-07',2),
(4,'Tran Tuan Tu','1993-10-10',2),
(5,'Do Anh Tai','1992-06-06',3)
;
insert into Subject(subjectid,subjectname,sessioncount)
VALUES
(1,'C Programming',22),
(2,'Web Design',18),
(3,'Database Management',23)
;
insert into Result(StudentId,SubjectId,Mark)
values
(1,1,8),
(1,2,7),
(2,3,5),
(3,2,6),
(4,3,9),
(5,2,8)
;
SELECT* FROM Student

SELECT StudentId 'Ma_Sinh_Vien' ,StudentName 'Ten_Sinh_Vien' ,Birthdate 'Ngay_Sinh'
FROM Student
WHERE Student.Birthdate between '1992-10-10' AND '1993-10-10'

SELECT *FROM Class

SELECT Class.ClassId,Class.ClassCode,COUNT(Student.StudentId) 'Si_So_Lop'
FROM Class INNER JOIN Student ON  Class.ClassId = Student.ClassId
GROUP BY Class.ClassId,Class.ClassCode
;

SELECT *FROM Result

SELECT Student.StudentId'Ma_Sinh_Vien',Student.StudentName'Ten_Sinh_Vien',SUM(Result.Mark)'Tong_diem'
FROM Student INNER JOIN Result on Student.StudentId = Result.StudentId
GROUP BY Student.StudentId,Student.StudentName
HAVING SUM(Result.Mark) > 10
ORDER BY 'Tong_diem' desc
;