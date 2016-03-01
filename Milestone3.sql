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


/*CREATE VIEW ClassesTaken AS(
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
ON a.SectionID = b.SectionID);*/

SELECT * FROM ClassesTaken;	    

/* Calculate quarter GPA */
/* Overall gpa */
/*
Select '1' AS Student_SSN,sum(c.Units * g.NUMBER_GRADE)/(4*count(c.SectionID)) AS Cumulative_GPA
from ClassesTaken c, Grade_Conversion  g
Where c.FinalGrade <> 'IN' and c.FinalGrade = g.LETTER_GRADE;*/

/* Quarter GPA */

Select c.Year AS Year, c.Quarter AS Quarter, sum(c.Units * g.NUMBER_GRADE) / (4*count(c.SectionID)) AS GPA
from ClassesTaken c, Grade_Conversion  g
Where c.FinalGrade <> 'IN' and c.FinalGrade = g.LETTER_GRADE 
GROUP BY c.Year, c.Quarter;

















