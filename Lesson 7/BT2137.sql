--Create database 
create database BT2137
use BT2137

--Create tables
create table MusicType
(
	TypeID int primary key identity(1,1),
	Name nvarchar(50) not null,
	Description nvarchar(100)
)
go

create table Album
(
	AlbumID varchar(20) primary key,
	Title nvarchar(100) not null,
	TypeID int,
	foreign key (TypeID)
	references MusicType(TypeID),
	Artists nvarchar(100),
	Rate int default(0) check(Rate <= 5)
)
go

create table Song
(
	SongID int primary key identity(1,1),
	AlbumID varchar(20),
	foreign key (AlbumID)
	references Album(AlbumID),
	SongTitle nvarchar(200) not null,
	Artists nvarchar(50),
	Author nvarchar(50),
	Hits int check(Hits >= 0)
)
go

--Create indexer for SongTitle
create index IX_SongTitle
on Song(SongTitle)
go

--Create indexer for Artists
create index IX_Artists
on Album(Artists)
go

--Insert data for 3 tables
insert into MusicType(Name,Description)
values
('Pop', 'genre of popular music that produces the most hits'),
('EDM', 'EDM is also known as dance music'),
('House', 'genre of electronic music characterized by repetitive beat')
go

insert into Album(AlbumID,Title,TypeID,Artists,Rate)
values
('1', 'MomentEP', 1, 'Peggy Gou', 4),
('2', 'Justice', 2, 'Justin Bieber', 2),
('3', 'Motion', 3, 'Calvin Harris', 3),
('4', 'Mommy', 1, 'Duc Anh', 5),
('5', 'Goodbye Swallow', 2, 'Tran Tien', 4)
go

insert into Song(AlbumID,SongTitle,Artists,Author,Hits)
values
('1', 'Peaches', 'Justin Bieber', 'Michelle', 10000),
('2', 'Han Pan', 'Peggy Gou', 'Peggy Gou', 434847),
('3', 'Summer', 'Calvin Harris', 'Calvin Harris', 4447),
('4', 'Random', 'Duc Anh', 'Chris', 12),
('5', 'Chim Bo Cau', 'Dong Nhi', 'Tran Tien', 334),
('5', 'Mat Nai', 'O Cao Thang', 'Tran Tien', 12)
go

--List all album requested 
select * from Album
where Rate = 5
go

--List all songs requested
select Song.SongID,Song.SongTitle,Song.Author,Song.Artists from Song,Album
where Album.AlbumID = Song.AlbumID
and Album.Title = 'Goodbye Swallow'
go

--Create view v_album and v_TopSongs
create view v_album_v_TopSongs
as
select Album.AlbumID,Album.Title,MusicType.Name,Album.Rate
from Album,MusicType
where MusicType.TypeID = Album.TypeID
go

select * from v_album_v_TopSongs

--Create store prodedure sp_SearchByArtists
create proc proc_sp_SearchByArtists
@parameter nvarchar(30)
as
	begin
		select Song.Artists,Song.SongTitle,Song.Author,Song.Hits
		from Song
		where Song.Artists = @parameter
	end
go

exec proc_sp_SearchByArtists 'Justin Bieber'

--Create store procedure sp_ChangeHits
create proc proc_sp_ChangeHits
@parameter_Song_id int,
@parameter_Hits int
as
	begin
		update Song
		set Hits = @parameter_Hits
		where SongID = @parameter_Song_id

		select * from Song
		where SongID = @parameter_Song_id
	end
go

exec proc_sp_ChangeHits 1,99999

select * from Album
select * from MusicType
select * from Song



