SELECT TNo , Title , TName
FROM Teachers
WHERE SupNo IS  NULL;


SELECT TNo , Title , TName
FROM Teachers
WHERE SupNo IS NOT NULL;


Select Sno as Std_ID, Hours/15.0 as Avrg_hrs, 'hrs per week' as Comment
from TS
Where Tno = 'T3';

select *
from Teachers
where city in (select  City 
			from Students);



select COUNT(distinct City) as 'Number of cities'
from Students;


select COUNT(*) as 'Number of Teachers from London' /*select count(City) <--da to samo */
from Teachers
where City='London';


select Sum(Hours)
from TS
where Sno = 'S5';



select MIN(Hours) as 'Min', MAX(Hours) as 'Max', AVG(Hours) as 'Avg'
from TS
Where Tno='T3';

select Tno, Tname as Surname, 
	case Title
		when 'Phd' then 'Doctor'
		when 'MSc' then 'Master of Science'
		when 'Prof.' then 'Professor'
		else 'unknown'
	end
		City, SupNo as Boss
from Teachers;



select Tno, Sno,
	case
		when Hours between 0 and 32 then 'short'
		when Hours between 33 and 64 then 'moderate'
		else 'long'
	end as Teaches
from TS;


select *
from Teachers
order by Tname asc -- asc/desc


select Sno, Hours, Tno
from TS
where Sno In ('S1','S2', 'S3')
order by Sno, Hours desc;


select Tno, COUNT(Sno) as stud_no
from TS
group by Tno;


select Sno, SUM(hours) as 'Sum of hrs'
from TS
Group by Sno
Having SUM(Hours)>160
order by 2 desc


Select Sname, TS.Sno, Hours
from TS, Students
where TS.Sno = Students.Sno and Tno = 'T4'
order by Sname;

Select Sname, TS.Sno, Hours
from TS join Students
on TS.Sno = Students.Sno --warunek z³¹czenia
where Tno = 'T4'
order by Sname;


Select T.City, Tname, Tno, Sname, Sno
from Teachers T, Students S --aliasy tablic (skracaj¹ zapis)
where T.City = S.City
order by T.City;



select Tname, TS.Tno, Sum(Hours) as 'Sum of hrs'
from Teachers T, TS
where TS.Tno = T.Tno
group by Tname, TS.Tno
order by Tname;


select Boss.Tname, Boss.Tno, 'is the boss of' as 'relation', Under.Tname, Under.Tno
from Teachers Under join Teachers Boss
on Under.SupNo = Boss.Tno
order by Boss.Tname, Under.Tname;


select *
from TS
where Tno in(
	select Tno
	From Teachers
	where City = 'London');
--to samo tylko ze JOINem
select TS.Tno, TS.Sno, TS.Hours
from TS join Teachers T
on TS.Tno = T.Tno
where T.City = 'London'
group by TS.Tno, TS.Sno, TS.Hours;



select Tname, Tno
from Teachers
where Tno in(
	select Tno
	from TS
	where Hours > 64);
--to samo tylko ze JOINem
select T.Tname, T.Tno
from TS join Teachers T
on TS.Tno = T.Tno
where TS.Hours > 64
group by T.Tname, T.Tno


select Tname, Tno
from Teachers
where Tno in(
	select Tno
	from TS
	where Hours > (
		select AVG(Hours)
		from TS));



select Tname, Tno, Title
from Teachers
where Tno in(
	select Tno
	from TS 
	group by Tno
	having SUM(hours) > 200)
order by Tname;



--uzycie operatora OR
select *
from TS
where Tno in (
	select Tno
	from Teachers
	where City = 'London')
OR Sno in (
	select Sno
	from Students
	where City = 'London')
Order by Tno, Sno


select *
from Teachers
where EXISTS(
	select *
	from TS
	where TS.Tno = Teachers.Tno AND TS.Sno = 'S1'
);


select Sno, Sname
from Students
where NOT EXISTS(
	select *
	from TS
	where TS.Sno = Students.Sno and TS.Tno = 'T3'
);



select distinct TS1.Tno
from TS TS1
where Exists (
	select *
	from TS TS2
	where TS2.Tno = TS1.Tno and TS2.Sno <> TS1.Tno
);


select Boss.Tname, Boss.Tno
from Teachers Boss
where Exists(
	select *
	from Teachers Under
	where Boss.Tno = Under.SupNo);


select Tno, SUM(hours) as HSum
INTO Tsum
from TS
group by Tno;

select Tname, Tno, Title
from Teachers
where Tno in(
	select Tno
	from Tsum
	where Hsum > (
		select AVG(Hsum)
		from Tsum)

)
order by Tname;


select Tno, COUNT(*) as stud_no
from TS
group by Tno



/*
drop table Tsum

select Tno, SUM(hours) as HSum
INTO Tsum
from TS
group by Tno;
select *
from Tsum

select Tno, Tname, Title, COUNT (*) AS Stud_No
from Teachers
where Tno in (
	select Tno
	from TS
	where TS.Tno = Teachers.Tno
)
group by Tno

union 
select Tno, Tname, Title, COUNT (*) AS Stud_No
from Teachers
where Tno in (
	select Tno
	from TS
	where TS.Tno = Teachers.Tno
)
group by Tno
order by Stud_no, Tname
*/


--1. How many students have their names starting from letter H?
select count(*)
from STUDENTS
where SNAME LIKE 'H%'

--2. For each city, give the numer of students that come from this city.
select COUNT(*) as 'number of poeple', S.City
from students S
group by S.city

--3. Show ids of teachers that did not have any classes.
select TS.Tno
from TS
where TS.Hours = 0

--4. How many teachers had their teachings? //????
select distinct TS.Tno
from TS 
where TS.Hours <> 0

--5. How many teachers did not have any classes?
select COUNT(*)
from TS
where TS.Hours = 0

--6. For teachers, show the sum of teaching hours.
--	 Order the result according to the names of teachers.
select Tname, TS.Tno, Sum(Hours) as 'Sum of hrs'
from Teachers T, TS
where TS.Tno = T.Tno
group by Tname, TS.Tno
order by Tname;


--7. Show the list of all students (ids, names)
--   ordered according to decreasing number of hours.
select S.Sno, Sname, Hours as 'number of hrs', TS.Tno as 'with teacher'
from students S, TS
where TS.Sno = S.Sno
group by S.Sno, Sname, Hours, TS.Tno
order by Hours desc


--8. Which teachers (id, title, name) have the most numer of subordinates?
select T.Tno, T.Title, T.Tname, COUNT(T.SupNo)
from Teachers.T
where T.SupNo = MAX(T.SupNo)
group by T.Tno--?


--9. Which teachers (id, title, name) have no supervisor?


--10. Which teachers (ids, names) conducted more than 3 teachings?



