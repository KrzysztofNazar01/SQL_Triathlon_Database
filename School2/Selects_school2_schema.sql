--1. Show identifiers and names of courses held on the 1st year of study.
--Order them alphabetically according to the names of courses.
select CNO, Cname
from Courses
where Studyear = 1
order by Cname

--2. How many students have their names starting from letter A?
select COUNT(*)
from Students
where Sname LIKE 'A%'

--3. For each city, give the numer of students that come from this city.
select COUNT(*), City
from Students
group by City

--4. For each teacher (id, title and name),
--give courses (ids, names) that he/she conducted.
select distinct T.Tno, T.Title, T.Tname, C.Cno, C.Cname
from Teachers T, Courses C, TSC 
where TSC.Cno=C.Cno and TSC.Tno = T.Tno


--5. Show ids of teachers that did not have classes on the 1st year of study.
select distinct Tno
from TSC
where Cno in(
	select Cno
	from Courses
	where Studyear <> 1
)


--6. On which year of study there were most courses?
select COUNT(*) as 'counter', Studyear
into C1_temp
from Courses
group by Studyear

select * from C1_temp

select distinct Studyear
from Courses
where Studyear in (
	select Studyear
	from C1_temp
	where [counter] = (
		select MAX([counter])
		from C1_temp
	)
)

drop table C1_temp


--OR:

select TOP 1 STUDYEAR
from COURSES
group by STUDYEAR
order by count(*) desc


--7. On which year of study there was the greatest average grade?
select top 1 STUDYEAR
from TSC, COURSES
where tsc.CNO = COURSES.CNO
group by STUDYEAR
order by AVG(GRADE) desc





--8. How many teachers did not have any classes?
select COUNT(*)
from Teachers 
where Tno not in (
	select Tno
	from TSC
)

--OR:

select count(*)
from TEACHERS
where TEACHERS.TNO NOT IN
	(select TSC.TNO
	from TEACHERS, TSC
	where TEACHERS.TNO = TSC.TNO)



--9. For each year of study, show the sum of teaching hours.
--Order the result according to the years of study.
select SUM(T.Hours), C.Studyear
from Courses C, TSC T
where C.Cno = T.Cno
group by C.Studyear
order by C.Studyear asc



--10. Which students (id, name) have the greatest average grade?
select top 1 S.Sno, S.Sname --, AVG(T.Grade)
from Students S, TSC T
where T.Sno = S.Sno
group by S.Sname, S.Sno
order by AVG(T.Grade) desc



--11. Show the list of all students (ids, names)
-- ordered according to decreasing average grades.
select S.Sno, S.Sname , AVG(Grade)
from Students S, TSC T
where S.Sno = T.Sno
group by S.Sno, S.Sname
order by AVG(Grade) desc




--12. Which teachers (id, title, name) have the most numer of subordinates?
--?????

/*
select TNO, TITLE, TNAME
FROM TEACHERS
where TNO IN
	(select SUPNO
	from TEACHERS
	group by SUPNO
	having COUNT(*) =
		(select top 1 count(*)
		from TEACHERS
		group by SUPNO
		order by 1 desc))
*/

--13. Which teachers (id, title, name) have no supervisor?
select Tno, Title, Tname
from Teachers
where SupNo is NULL



--14. Which teachers (ids, names) conducted
-- more than 3 courses and how many courses they conducted?
select COUNT(*) as 'counter', Tno
into CondCours
from TSC
group by Tno

select * from CondCours

select T.Tno, Tname, [counter]
from Teachers T join CondCours C on T.Tno = C.Tno
where [counter] > 3


--OR:

select TEACHERS.TNO, TEACHERS.TNAME, count(TEACHERS.TNO)
from TEACHERS, TSC
where TEACHERS.TNO = TSC.TNO
group by TEACHERS.TNO, TEACHERS.TNAME
having count(TEACHERS.TNO) > 3





--15. Show ids and names of those students
--	  who obtained at least one 5.0 from any subject.

select S.Sno, Sname
from Students S
where S.Sno in (
	select Sno
	from TSC
	where Grade = 5.0
)


--16. Show ids and names of those students who obtained
--    at least one grade that is maximal from all the grades
--    obtained by anyone. How many students satisfy this condition?

select Sno, Sname
from Students
where Sno in (
	select Sno
	from TSC
	where Grade = (
		select MAX(Grade)
		from TSC
	)
)

--OR:
select distinct TSC.SNO, SNAME
from TSC, STUDENTS
where TSC.SNO = STUDENTS.SNO
and GRADE = 
	(select max(GRADE)
	FROM TSC)


--17. How many students had mathematics on the 2nd year of study?
select COUNT (sno)
from TSC T, Courses C
where C.Cno = T.Cno
	  and C.Cname='Mathematics'
	  and Studyear = 2


--18. Create a view that contains all the data from TSC
-- extended by names of students, titles and names of teachers and names of courses.

create view ExtendedTSC3
as select TSC.Tno,TSC.Sno, TSC.Cno, TSC.Grade, TSC.Hours,S.Sname, T.Title, C.Cname
from TSC,Courses C, Students S, Teachers T
where TSC.Tno = T.Tno and TSC.Cno = C.Cno and TSC.Sno = S.Sno
--group by TSC.Tno,TSC.Sno, TSC.Cno, TSC.Grade, TSC.Hours,S.Sname, T.Title, C.Cname

select * from ExtendedTSC3

--19. For each city, give the total numer of students and teachers that come from this city.
select city, COUNT(*)
from (
	Select city
	from Teachers
		union all
	select City
	from Students
) as a 
group by city



--20. Which teacher (id, name) gave the students the worst grades
-- (i.e. the average grade from all the grades given by this teacher is the lowest).
SELECT TNO, TNAME
FROM TEACHERS
WHERE TNO = 
	(SELECT top 1 TNO
	FROM TSC
	group by TNO
	order by avg(GRADE))



--21. Create an archive for table TSC.
-- The archive should contain ids and names of students and teachers,
-- ids and names of courses and grades.
-- Next insert to this archive all the data from TSC and clear TSC.

--create table




--22. For each course, show the average grade obtained by the students from this course.
-- Next show these courses (ids, names) for which this average exceeds
-- the average of all the averages.

select AVG(grade) as 'average', C.Cno, Cname
into temp 
from TSC,Courses C
where TSC.Cno = C.Cno
group by C.Cno, C.Cname
order by [average] desc


select * from temp

select Cno, Cname
from temp
where [average] > (
	select AVG([average])
	from temp
)

--23. Show those teachers (ids, titles, names) who on the 1st year of study taught
-- students that come from the same city as the teacher.
select distinct T.Tno, Title, Tname 
from Teachers T, TSC, Students S, Courses C
where Studyear = 1 and TSC.Tno = T.Tno and TSC.Cno = C.Cno and S.City = T.City


--24. Show the course (id, name) that had the least number of students
-- (but was conducted on any year of study).
select top 1 TSC.Cno, Cname
from TSC, Courses C
where TSC.Cno = C.Cno
group by TSC.Cno, Cname
order by COUNT(*)


--25. For each year of entry the studies, show the average grade of students
-- that entered studies in this year.
-- The result should be ordered according to decreasing averages.

select Studyear, AVG(Grade)
from Courses C, TSC
where C.Cno = TSC.Cno
group by Studyear
order by 2 desc


--troche inne -> jest STUDENTS zamiast COURSES
select SYEAR, AVG(GRADE)
from STUDENTS, TSC
where STUDENTS.SNO = TSC.SNO
group by SYEAR
order by 2 desc

