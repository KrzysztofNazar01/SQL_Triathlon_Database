create  Database Sports3
--drop Database Sports3

/*
drop TABLE WorkoutPlan
drop TABLE Coach
drop TABLE Workout
drop TABLE Diet
drop TABLE Athlete
drop TABLE Regeneration
drop TABLE Competition
*/
CREATE TABLE Coach
(
Id_Coach INT PRIMARY KEY CHECK (LEN(Id_Coach)>0 AND LEN(Id_Coach)<=6 ), --start with id=1, increment by 1
FirstName VARCHAR(20) NOT NULL CHECK (LEN(FirstName)>=3), --minimum length specified
SecondName VARCHAR(20) NOT NULL CHECK (LEN(SecondName)>=3), --minimum length specified
Experience INT NOT NULL CHECK (Experience <= 100) --cannot be greater than 100
);

CREATE TABLE Diet
(
Id_Diet INT PRIMARY KEY CHECK (LEN(Id_Diet)>0 AND LEN(Id_Diet)<=6),
Model varchar(20) NOT NULL CHECK (Model IN('Ketogenic', 'Vegetarian', 'Vegan', 'Mediterranean')) DEFAULT 'Mediterranean',  -- enum
Calories INT NOT NULL CHECK (Calories >= 1000) --kcal for one day
);

CREATE TABLE Regeneration
(
Id_Regeneration INT PRIMARY KEY CHECK (LEN(Id_Regeneration)>0 AND LEN(Id_Regeneration)<=6 ),
Sleep INT NOT NULL CHECK (Sleep>=60*4 AND Sleep<=60*24), --in minutes; sleep during 24h 
Massage INT NOT NULL CHECK (Massage >= 0 AND Massage <= 100) --number of massages per week
);

CREATE TABLE Workout
(
Id_Workout INT PRIMARY KEY CHECK (LEN(Id_Workout)>0 AND LEN(Id_Workout)<=6 ),
TimeLength INT NOT NULL CHECK (TimeLength>=30 AND TimeLength <= 1000), --in minutes
BodyPart varchar(10) NOT NULL CHECK (BodyPart IN('Upper', 'Lower', 'Abs', 'All')) ,  -- enum
Difficulty varchar(10) NOT NULL CHECK (Difficulty IN('Easy', 'Medium', 'Hard', 'Veryhard'))  -- enum
);
CREATE TABLE Athlete
(
Id_Athlete INT PRIMARY KEY CHECK (LEN(Id_Athlete)>0 AND LEN(Id_Athlete)<=6 ),
FirstName VARCHAR(20) NOT NULL CHECK (LEN(FirstName)>=3), --minimum length specified
SecondName VARCHAR(20) NOT NULL CHECK (LEN(SecondName)>=3), --minimum length specified
Sex varchar(10) NOT NULL CHECK (Sex IN('Male', 'Female', 'Other')),  -- enum
Age INT NOT NULL CHECK (Age >= 18 AND Age <= 100), --only mature athletes
Experience INT NOT NULL CHECK (Experience >= 0 AND Experience <= 100), --must be a postiive integer
Mass DECIMAL(3,1) NOT NULL CHECK (Mass >= 30.0 AND Mass <= 200), -- in kilograms
StartWorkoutPlan DATE NOT NULL -- day of start of using the plan
);

CREATE TABLE Competition
(
Id_Competition INT PRIMARY KEY CHECK (LEN(Id_Competition)>0 AND LEN(Id_Competition)<=6 ),
ParticipNumber INT NOT NULL CHECK (ParticipNumber >= 50 AND ParticipNumber <= 10000), --minimum particpants number
EventDate DATE NOT NULL, --day of competitions 
Distance varchar(10) NOT NULL CHECK (Distance IN('Ironman', 'Olympic', 'Sprint')),  -- enum
EventLevel varchar(20) NOT NULL CHECK (EventLevel IN('Local', 'National', 'International')) -- enum
);







/*

DROP TABLE Participation
DROP TABLE WorkoutPlan
*/

CREATE TABLE Participation
(
Id_Athlete INT REFERENCES Athlete, --Athlete ID
Id_Competition INT REFERENCES Competition,  --Competition ID
Position_swim INT NOT NULL, -- on which position athlete finished the category
Position_bike INT NOT NULL, -- on which position athlete finished the category
Position_run INT NOT NULL, -- on which position athlete finished the category
PRIMARY KEY(Id_Athlete, Id_Competition)
);
CREATE TABLE WorkoutPlan
(
Id_WorkoutPlan INT PRIMARY KEY, --Id of WorkoutPlan
Id_Coach INT REFERENCES Coach, --Author of WorkoutPlan 
Id_Diet INT REFERENCES Diet,
Id_Regeneration INT REFERENCES Regeneration,
Id_Athlete INT REFERENCES Athlete 
);




--DROP TABLE WorkoutsUsedInPlans

CREATE TABLE WorkoutsUsedInPlans
(
Id_WorkoutPlan INT REFERENCES WorkoutPlan ON DELETE CASCADE ON UPDATE CASCADE,  
Id_Workout INT REFERENCES Workout ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(Id_WorkoutPlan, Id_Workout) 
);


/*

DROP TABLE WorkoutsUsedInPlans

DROP TABLE WorkoutPlan
drop TABLE Participation

drop TABLE WorkoutPlan
drop TABLE Coach
drop TABLE Workout
drop TABLE Diet
drop TABLE Athlete
drop TABLE Regeneration
drop TABLE Competition

*/
