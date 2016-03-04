/* Reports I-1*/

/* display current quarter student */
/*
SELECT s.SSN, s.Name
FROM PeriodOfAttendence p, Student s
WHERE isCurrentStudent = true and s.StudentID = p.StudentID;
*/

/* Display the courses taken by Student X */
/*
SELECT a.SectionID,a.Title,a.Year,a.Quarter,a.MaxEnrollment,b.Units FROM
	(SELECT c.SectionID,c.Title,c.Quarter,c.Year,c.MaxEnrollment
	FROM Classes c
	WHERE c.Quarter = 'Spring' and c.Year = '2009' 
			and c.SectionID in (SELECT a.SectionID
					    FROM AcademicHistory a
					    WHERE a.StudentID in 
					(SELECT StudentID
						FROM Student
						WHERE ssn ='1'))) a
INNER JOIN 
	(SELECT a.SectionID, a.Units
	FROM AcademicHistory a
	WHERE a.StudentID in (SELECT StudentID
			      FROM Student
			      WHERE ssn = '1')) b
ON a.SectionID = b.SectionID;
*/

/* Reports I-2*/
/* Display all classes in the class table */ 

/*
SELECT *
FROM Classes c;
*/

/*
SELECT h.CourseName, c.SectionID, c.Title, c.Quarter,c.Year, c.MaxEnrollment
FROM Classes c, CourseHasClass h
WHERE c.Quarter = "Spring" AND c.Year = "2009" 
AND c.SectionID = h.SectionID;
*/

/* Passed in class title, display all students taken the class */
/*
SELECT s.StudentID, s.Name,s.SSN,s.ResidenceStatus,s.AcademicLevel,e.Units,e.GradeOption
FROM Classes c, StudentEnrollment e,Student s
WHERE c.Title = 'Database' AND e.SectionID = c.SectionID 
AND e.StudentID = s.StudentID;
*/

/* Report I-3*/
/* Display all students ever enrolled */
SELECT s.SSN,s.Name
FROM Student s
WHERE s.StudentID in (SELECT p.StudentID
		      FROM PeriodOfAttendence p);


CREATE OR REPLACE VIEW ClassesTaken AS(
SELECT a.SectionID,a.Title,a.Quarter,a.Year,a.MaxEnrollment,b.Units,b.FinalGrade FROM 
(SELECT c.SectionID,c.Title,c.Quarter,c.Year,c.MaxEnrollment
FROM Classes c
WHERE c.SectionID in (SELECT a.SectionID
		      FROM AcademicHistory a
		      WHERE a.StudentID in (SELECT StudentID
					     FROM Student
					     WHERE ssn = '1'))
ORDER BY c.Year,c.Quarter) a
INNER JOIN
((SELECT a.SectionID, a.Units,a.FinalGrade
	  FROM AcademicHistory a
	  WHERE a.StudentID in (SELECT StudentID 
				FROM Student
				WHERE ssn = '1'))) b
ON a.SectionID = b.SectionID);

SELECT * FROM ClassesTaken;	 

-- Calculate quarter GPA 
-- Overall gpa 

Select '1' AS Student_SSN,sum(c.Units * g.NUMBER_GRADE)/(4*count(c.SectionID)) AS Cumulative_GPA
from ClassesTaken c, Grade_Conversion  g
Where c.FinalGrade <> 'IN' and c.FinalGrade = g.LETTER_GRADE;

-- Quarter GPA 

Select c.Year AS Year, c.Quarter AS Quarter, sum(c.Units * g.NUMBER_GRADE) / (4*count(c.SectionID)) AS GPA
from ClassesTaken c, Grade_Conversion  g
Where c.FinalGrade <> 'IN' and c.FinalGrade = g.LETTER_GRADE 
GROUP BY c.Year, c.Quarter;


/* all enrolled undergraduate student */
/*
SELECT u.SSN,u.Name
FROM Undergraduate u
WHERE u.StudentID in (Select StudentID FROM PeriodOfAttendence WHERE isCurrentStudent=true);
*/
/* Select all BSC degree */
/*
Select *
From Degree d
WHERE d.Type = 'B.S.';
*/
-- pass in degree name 

/*
Select *
From Degree d
WHERE d.Type = 'B.S.' AND d.DegreeName = 'B.S. Computer Science';
-- Calculate how many units the student left to take 
Select a.StudentID, d.DegreeName,(d.TotalUnitsRequired-sum(a.Units)) AS UnitsLeftToTake
From AcademicHistory a, Degree d
Where a.StudentID in (Select StudentID from Student where SSN = '1') 
		AND d.DegreeName = 'B.S. Computer Science'
GROUP BY a.StudentID,d.DegreeName;
-- minimum number of units the student has to take from each category (e.g. lower division units required, technical elective units required, etc.) in degree Y. 
Select (d.UnitsRequired-sum(a.Units)) AS UnitsLeft, d.Category
--Select d.UnitsRequired, a.Units, d.Category
From AcademicHistory a, DegreeDetailedUnitRequirement d
Where a.StudentID = 'A1'
	AND d.DegreeName = 'B.S. Computer Science'
	AND d.Category in (Select g.Category
		               FROM CourseHasClass h,Course c, CourseCategory g
				WHERE a.SectionID = h.SectionID AND h.CourseName = c.CourseName AND c.CourseName = g.CourseName)			
GROUP BY d.Category, d.UnitsRequired;
*/




/* Report 1-E */

-- Display the NAME of all the concentrations in Y that a student X has completed.
SELECT c.ConcentrationName
FROM Concentration c
WHERE 
NOT EXISTS (SELECT d1.CourseName
		FROM ConcentrationCourse d1
		WHERE c.ConcentrationName = d1.ConcentrationName 
		and d1.CourseName not in 
			(Select h.CourseName
			From AcademicHistory a, CourseHasClass h
			Where a.StudentID = 'A22' and a.SectionID = h.SectionID))
AND 
	(Select sum(g.NUMBER_GRADE) / count(a.SectionID) AS GPA 
	FROM AcademicHistory a, Grade_Conversion g, CourseHasClass h, ConcentrationCourse cc
	WHERE a.StudentID = 'A22' and a.FinalGrade <> 'IN' and a.FinalGrade = g.LETTER_GRADE and cc.ConcentrationName = c.ConcentrationName
	and a.SectionID = h.SectionID and h.CourseName = cc.CourseName) > c.MinGPA;

/*Given the student name X and degree name Y, list the set of courses that the student has not yet 
taken from every concentration C in Y (even for the concentrations C that X has completed). 
Next to each course display the next time that this course is given (i.e. the earliest time 
at which a class of this course is given after SPRING 2005).*/


CREATE OR REPLACE VIEW CompleteConcentration AS (
	SELECT c.ConcentrationName
	FROM DegreeConcentration d, Concentration c
	WHERE 
	d.DegreeName = 'M.S. in Computer Science' And d.ConcentrationName = c.ConcentrationName
	And
	NOT EXISTS (SELECT d1.CourseName
			FROM ConcentrationCourse d1
			WHERE c.ConcentrationName = d1.ConcentrationName 
			and d1.CourseName not in 
				(Select h.CourseName
				From AcademicHistory a, CourseHasClass h
				Where a.StudentID = 'A22' and a.SectionID = h.SectionID))
	AND 
		(Select sum(g.NUMBER_GRADE) / count(a.SectionID) AS GPA 
		FROM AcademicHistory a, Grade_Conversion g, CourseHasClass h, ConcentrationCourse cc
		WHERE a.StudentID = 'A22' and a.FinalGrade <> 'IN' and a.FinalGrade = g.LETTER_GRADE and cc.ConcentrationName = c.ConcentrationName
		and a.SectionID = h.SectionID and h.CourseName = cc.CourseName) > c.MinGPA
);
SELECT * 
FROM CompleteConcentration;

-- Get all the incomplete concentration
Select d.DegreeName, d.ConcentrationName, c.CourseName, h.SectionID, classes.Quarter, classes.Year
from DegreeConcentration d, StudentPursueDegree s, ConcentrationCourse c, CourseHasClass h, Classes classes
WHERE s.StudentID = 'A22' and d.DegreeName = s.DegreeName and 
d.ConcentrationName = c.ConcentrationName 
and d.ConcentrationName not in (Select * from CompleteConcentration)
and c.CourseName not in 
	(Select cc.CourseName From AcademicHistory a, CourseHasClass cc 
	Where a.StudentID = 'A22' and cc.SectionID = a.SectionID)
and c.CourseName = h.CourseName
and h.SectionID = classes.SectionID
and 
((classes.Year = '2016' and classes.Quarter = 'Fall') or (classes.Year = '2016' and classes.Quarter = 'Spring') or (classes.Year = '2017'))
;


-- Report 2a
CREATE OR REPLACE VIEW CurrentSchedule AS(
	SELECT s.SectionID,w.DayOfTheWeek,w.Time,cl.Title,h.CourseName
	FROM StudentEnrollment s, ClassMeeting c, WeeklyMeeting w, Classes cl,CourseHasClass h
	WHERE s.StudentID = 'A21' AND s.SectionID = c.SectionID AND w.MeetingID = c.MeetingID
	AND cl.SectionID = s.SectionID AND h.SectionID = s.SectionID);
	
SELECT * 
FROM CurrentSchedule;


-- Find conflict scheduling
Select c.SectionID,c.Title,c.CourseName,c.DayOfTheWeek,c.Time,m.SectionID,h.CourseName,s.Title,w.DayOfTheWeek,w.Time
FROM CurrentSchedule c, ClassMeeting m, WeeklyMeeting w, Classes s,CourseHasClass h
WHERE c.SectionID <> m.SectionID AND s.SectionID = m.SectionID AND s.Title not in (Select title from CurrentSchedule)
AND m.MeetingID = w.MeetingID AND w.DayOfTheWeek = c.DayOfTheWeek AND w.Time = c.Time 
AND h.SectionID = s.SectionID;


-- Report 2b
-- Display all the professors who are teching this quarter
Select SSN,Name
From faculty;


-- Display all the sections in the current quarter
Select c.SectionID,h.CourseName,c.Title,c.Quarter,c.Year,c.MaxEnrollment
From Classes c, CourseHasClass h
WHERE c.Quarter='Winter' AND c.Year='2016' AND h.SectionID = c.SectionID;


-- For selected section, find all the enrolled students
CREATE OR REPLACE VIEW EnrolledStudent AS(
SELECT s.StudentID
FROM StudentEnrollment s
WHERE s.SectionID = '2');
Select * from EnrolledStudent;

-- Find enrolled students schedule

Select s.StudentID,s.SectionID,w.DayOfTheWeek,w.Time
From EnrolledStudent e, StudentEnrollment s,ClassMeeting c,WeeklyMeeting w
WHERE e.StudentID = s.StudentID AND c.SectionID = s.SectionID AND c.MeetingID = w.MeetingID
UNION
SELECT i.FacultyName,c.SectionID,w.DayOfTheWeek, w.Time
FROM Instructor i, ClassMeeting c,WeeklyMeeting w
WHERE i.FacultyName = 'Adele' AND i.SectionID = c.SectionID AND c.MeetingID = w.MeetingID;













