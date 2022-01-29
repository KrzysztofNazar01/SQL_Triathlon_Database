
INSERT INTO Coach (Id_Coach, FirstName, SecondName, Experience)
VALUES	(1, 'Steave','Rogers',23),
		(2, 'Mark','Thompson',10),
		(3, 'Dave','Rogers',2),
		(4, 'Tom','Brown',4),
		(5, 'Mark','Rogers',6),
		(6, 'James','Jones',12),
		(7, 'Robert','Robinson',32),
		(8, 'Michael','Evans',6),
		(9, 'William','Clarke',34),
		(10, 'Joseph','Green',19),
		(11, 'Charles','Hall',18),
		(12, 'Daniel','Jackson',14)
Select * from Coach
--drop table Coach

INSERT INTO Diet (Model, Calories, Id_Diet)
VALUES	('Ketogenic',3300, 1),
		('Ketogenic',4500, 2),
		('Ketogenic',3000, 3),
		('Vegetarian',4000, 4),
		('Vegetarian',2300, 5),
		('Vegetarian',3100, 6),
		('Mediterranean',4500, 7),
		('Mediterranean',3700, 8),
		('Mediterranean',2900, 9),
		('Vegan',5000, 10),
		('Vegan',4200, 11),
		('Vegan',3000, 12)
Select * from Diet
--drop table Diet

INSERT INTO Regeneration (Sleep, Massage, Id_Regeneration)
VALUES	(60*6, 0, 1),
		(60*5, 1, 2),
		(60*7, 2, 3),
		(60*8, 3, 4),
		(60*4, 4, 5),
		(60*5, 3, 6),
		(60*6, 2, 7),
		(60*8, 2, 8),
		(60*7, 1, 9),
		(60*6, 0, 10),
		(60*8, 1, 11),
		(60*6, 6, 12)
Select * from Regeneration
--drop table Regeneration

INSERT INTO Workout (Id_Workout, BodyPart, Difficulty, TimeLength)
VALUES	(1,'Upper','Easy',120),
		(2,'Upper','Veryhard',110),
		(3,'Upper','Veryhard',90),
		(4,'Lower','Easy',45),
		(5,'Lower','Veryhard',60),
		(6,'Lower','Medium',130),
		(7,'All','Hard',110),
		(8,'All','Easy',50),
		(9,'All','Hard',70),
		(10,'Abs','Medium',100),
		(11,'Abs','Easy',45),
		(12,'Abs','Veryhard',75)
Select * from Workout
--drop table Workout

INSERT INTO Athlete (Id_Athlete, FirstName , SecondName, Sex, Age, Experience, Mass, StartWorkoutPlan)
VALUES	--male x6
		(1, 'Ethan','Collins','Male', 26, 2, 78.1, '2019-11-11'),
		(2, 'Stephen','Smith','Male', 23, 3, 54.2, '2017-09-15'),
		(3, 'Bruce','Murphy','Male', 45, 7, 65.1, '2015-01-16'),
		(4, 'Timothy','Taylor','Male', 32, 11, 83.6, '2018-06-21'),
		(5, 'Dennis','Johnson','Male', 51, 13, 93.5, '2016-05-30'),
		(6, 'George','Ahmed','Male', 28, 7, 65.8, '2019-03-28'),

		--female x6
		(7, 'Michelle','Taylor','Female', 34, 4, 94.1,'2016-10-12'),
		(8, 'Deborah','Johnson','Female', 43, 3, 92.1, '2015-10-12'),
		(9, 'Kimberly','Marshall','Female', 23, 2, 72.4, '2019-10-12'),
		(10, 'Emily','Morgan','Female', 46, 7, 71.3, '2018-10-12'),
		(11, 'Melissa','Webb','Female', 26, 8, 69.3, '2017-10-12'),
		(12, 'Cristine','Borson','Female', 31, 9, 76.7, '2019-10-12')
Select * from Athlete
--drop table Athlete

INSERT INTO Competition (Id_Competition, EventLevel , ParticipNumber, EventDate, Distance)
VALUES	(1, 'Local', 200, '2020-03-15', 'Sprint'),
		(2, 'Local', 300, '2020-06-24', 'Sprint'),
		(3, 'Local', 240, '2021-09-12', 'Olympic'),
		(4, 'Local', 180, '2021-10-30', 'Sprint'),
		(5, 'National', 540, '2020-05-21', 'Sprint'),
		(6, 'National', 480, '2020-09-22', 'Olympic'),
		(7, 'National', 600, '2021-07-09', 'Ironman'),
		(8, 'National', 390, '2021-03-25', 'Sprint'),
		(9, 'International', 980, '2020-01-21', 'Sprint'),
		(10, 'International', 740, '2020-12-14', 'Olympic'),
		(11, 'International', 780, '2021-11-06', 'Ironman'),
		(12, 'International', 840, '2021-12-25', 'Ironman')
Select * from Competition
--drop table Competition







--mozna by zamiast podawac id zrobic selecty z imieniem i nazwiskiem (do ID_Athlete)
INSERT INTO Participation (Id_Athlete , Id_Competition, Position_swim, Position_bike, Position_run)
VALUES
	--male
	(1, 1,	103, 154, 32),
	(1, 2,	204, 164, 89),
	(2, 5,	451, 574, 45),
	(2, 3,	230, 23, 87),
	(3, 4,	99, 23, 56),
	(4, 7,	322, 426, 597),
	(5, 10,	23, 356, 35),
	(6, 8,	47, 172, 82),

	--female
	(7, 12,	452, 645, 455),
	(7, 9,	741, 125, 674),
	(8, 11,	554, 186, 654),
	(8, 5,	321, 452, 125),
	(9, 10,	45, 566, 685),
	(10, 3,	65, 237, 132),
	(11, 9,	444, 254, 354),
	(12, 8,	128, 254, 362)

select * from Participation
--drop table Participation

INSERT INTO WorkoutPlan (Id_WorkoutPlan, Id_Coach, Id_Diet, Id_Regeneration, Id_Athlete)
VALUES	
	(1, 1, 2, 6, 3),
	(2, 1, 1, 12, 2),
	(3, 2, 6, 5, 1),
	(4, 2, 5, 3, 4),
	(5, 3, 7, 2, 5),
	(6, 4, 2, 1, 6),
	(7, 5, 7, 8, 7),
	(8, 6, 4, 7, 10),
	(9, 7, 4, 4, 11),
	(10, 7, 5, 9, 12),
	(11, 9, 3, 10, 9),
	(12, 9, 3, 11, 8)
Select * from WorkoutPlan
--drop table WorkoutPlan








INSERT INTO WorkoutsUsedInPlans (Id_Workout, Id_WorkoutPlan)
VALUES	(1,1),
		(1,2),
		(2,1),
		(2,3),
		(2,8),
		(2,10),
		(3,4),
		(3,5),
		(2,4),
		(2,5),
		(3,3),
		(4,6),
		(5,6),
		(5,7),
		(6,8),
		(6,9),
		(5,10),
		(2,11),
		(1,12)

Select * from WorkoutsUsedInPlans
--drop table Workout



