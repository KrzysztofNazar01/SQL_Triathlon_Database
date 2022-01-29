
--1. Widok dla sportowcow, zeby nie widzieli wra�liwych danych o innych sportowcach
CREATE view InidvidualAthletes
AS SELECT  FirstName,SecondName,Sex, Age, Experience, MASs, StartWorkoutPlan
FROM Athlete

--drop view InidvidualAthletes
GO -- bez 'GO' jest warning przy 'CREATE view'

--2. Lista sportowc�w u kt�rych kaloryczno�� diety przekracza�a 4000 kcal
SELECT W.Id_Diet, W.Id_Athlete
FROM WorkoutPlan W
WHERE W.Id_Diet in(
	SELECT Id_Diet
	FROM Diet
	WHERE Calories > 4000
)
ORDER BY W.Id_Athlete



--3. srednia kalorycznosc diety u kobiet pomiedzy 18 a 40 rokiem �ycia
SELECT AVG(D.Calories) AS 'avg kcal in diet'
FROM WorkoutPlan W, Diet D
WHERE W.Id_Athlete in (
	SELECT Id_Athlete
	FROM Athlete
	WHERE Sex='female' and Age between 18 and 40
)




--4. podaj informacje treningach wraz z czestotliwoscia pojaiwaa sie w planach treningowych
SELECT WP.Id_Workout, count(WP.Id_WorkoutPlan) 'used in ... plans', W.BodyPart, W.Difficulty
FROM WorkoutsUsedInPlans WP join Workout W on WP.Id_Workout = W.Id_Workout
GROUP BY WP.Id_Workout, W.BodyPart, W.Difficulty
ORDER BY 2 desc, W.BodyPart



--5. pokaz id sportowcow, ktorzy maj� wyniki lepsze niz srednie 
--licz� si� tylko sportowcy o doswiadczeniu wiekszym niz 1 rok
--the lower the result, the better
SELECT P.Id_Athlete, P.Position_run, ParticipNumber,  100*Position_run/ParticipNumber AS 'result'
INTO Results1
FROM Participation P join Competition C on P.Id_Competition = C.Id_Competition
WHERE P.Id_Athlete in (
	SELECT Id_Athlete
	FROM Athlete
	WHERE Experience > 1
)
ORDER BY 1, 4

SELECT *
FROM Results1

--drop table Results1

SELECT R.Id_Athlete, R.result
FROM Results1 R
WHERE R.result > (
	SELECT AVG(result)
	FROM Results1
)
ORDER BY R.result





--6. podaj autora oraz id sportowca, ktory uzywa plan ktory jest
-- aktualnie najdluzej uzywanym planem trenignowym
SELECT Id_WorkoutPlan AS 'Plan nr', Id_Athlete 'used by Athlete nr' , Id_Coach AS 'CREATEd by Coach nr'
FROM WorkoutPlan
WHERE Id_Athlete in (
	SELECT Id_Athlete
	FROM Athlete
	WHERE StartWorkoutPlan = (
		SELECT MIN(StartWorkoutPlan) --can be changed to 'MAX'
		FROM Athlete
		))



--7. Ilo�� plan�w treningowych stworzonych przez danych trenerow,
-- kt�re s� aktualnie u�ywane; podaj do�wiadczenie tych trener�w
SELECT W.Id_Coach, count(W.Id_WorkoutPlan) AS 'number of WP', C.Experience
FROM WorkoutPlan W join Coach C on W.Id_Coach = C.Id_Coach
GROUP BY W.Id_Coach, C.Experience
ORDER BY 2 desc, C.Experience desc





--8. �rednia dlugosc treningow na dane partie ciala
SELECT BodyPart, AVG(TimeLength) AS 'avg time'
FROM Workout
WHERE BodyPart in (
	SELECT BodyPart
	FROM Workout
)
GROUP BY BodyPart
ORDER BY 2 desc


--9. Znajdz plany trenignowe, dla osoby kontuzjowanej, czyli
-- plany ktore zawieraj� ilosc mASazy wy�sz� ni� ich srednia liczba i podaj liczbe mASazy w tych planach
SELECT W.Id_WorkoutPlan, R.MASsage
FROM WorkoutPlan W join Regeneration R on W.Id_Regeneration = R.Id_Regeneration
WHERE W.Id_Regeneration in (
	SELECT Id_Regeneration
	FROM Regeneration
	WHERE MASsage > (
		SELECT AVG(MASsage)
		FROM Regeneration
	)
)
ORDER BY R.MASsage desc


--10. Najbardziej popularny dystans zawodow, w ktorych brali udzial sportowcy
SELECT Distance,COUNT (*) 'number of competitions'
INTO DistInComp
FROM Competition C join Participation P on C.Id_Competition = P.Id_Competition
WHERE Distance in (
	SELECT Distance
	FROM Competition
)
GROUP BY Distance

SELECT *
FROM DistInComp
ORDER BY 2 desc
--drop table DistInComp

SELECT D.Distance, D.[number of competitions]
FROM DistInComp D
WHERE D.[number of competitions] in (
	SELECT MAX([number of competitions])
	FROM DistInComp
)

