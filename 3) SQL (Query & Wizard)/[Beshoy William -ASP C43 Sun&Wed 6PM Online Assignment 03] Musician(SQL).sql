create database MusicianTask

use MusicianTask

create table Musician
(
	Id int primary key identity(1, 1),
	Name varchar(40) not null,
	Ph_Number int,
	City varchar(20),
	street varchar(20)
)

create table Instrument
(
	Name varchar(40) primary key,
	[Key] int
)

create table Album
(
	Id int primary key identity(1, 1),
	Tittle varchar(20),
	Date date,
	Mus_Id int references Musician(Id)
)

create table Song
(
	Title varchar(50) primary key,
	Author varchar(50)
)


create table Album_Song
(
	Album_Id int references Album(Id),
	song_Title varchar(50) references Song(Title),
	primary key(Album_Id, Song_Title)
)


create table Mus_Song
(
	Mus_Id int references Musician(Id),
	Song_Title varchar(50) references Song(Title),
	primary key(Mus_Id, Song_Title)
)

create table Mus_Instrument
(
	Mus_Id int references Musician(Id),
	Inst_Name varchar(40) references Instrument(Name),
	primary key(Mus_Id, Inst_Name)
)