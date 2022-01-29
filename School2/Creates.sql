
CREATE DATABASE School2

CREATE TABLE Teachers
(	Tno CHAR(3) PRIMARY KEY,
	Tname CHAR(12),
	Title CHAR(6),
	City CHAR(10), --oryginalnie CHAR(8)
	SupNo CHAR(3) REFERENCES Teachers);

CREATE TABLE Students
(	Sno CHAR(3) PRIMARY KEY,
	Sname CHAR(12),
	Syear INT, -- orgyginalnie jest DATE
	City CHAR(10)); --oryginalnie CHAR(8)

CREATE TABLE Courses
(	Cno CHAR(3) Primary Key,
	Studyear INT, -- orgyginalnie jest DATE
	Cname Char(12));

CREATE TABLE TSC
(	Tno CHAR(3) REFERENCES Teachers,
	Sno CHAR(3) REFERENCES Students,
	Cno CHAR(3) REFERENCES Courses,
	Hours INT,
	Grade decimal(2,1),
	PRIMARY KEY (Tno, Sno, Cno));





drop table Students
drop table Teachers
drop table Courses
drop table TSC
drop database School2
