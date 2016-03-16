Drop table if exists CPQG;
Drop table if exists CPG;

CREATE TABLE CPQG(
	CourseName varchar(255),
	FacultyName varchar(255), 
	Quarter varchar(255),
	Year varchar(255),
	Grade varchar(255)
);

CREATE TABLE CPG(
	CourseName varchar(255),
	FacultyName varchar(255), 
	Grade varchar(255)
);

-- Report 3A
CREATE OR REPLACE VIEW GradeDistribution AS
Select a.FinalGrade
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = 'CSE8A' and 
cc.CourseName = c.CourseName and 
l.SectionID = cc.SectionID and
l.FacultyName = 'Justin Bieber' and
classes.SectionID = cc.SectionID and
classes.Quarter = 'Fall' and
classes.Year = '2014' and
a.SectionID = l.SectionID;

Select count(FinalGrade) AS counts, 'A' AS Letter 
From GradeDistribution
Where FinalGrade = 'A' or FinalGrade = 'A-' or FinalGrade = 'A+'
Union
Select count(FinalGrade) AS counts, 'B' AS Letter 
From GradeDistribution
Where FinalGrade = 'B' or FinalGrade = 'B-' or FinalGrade = 'B+'
Union
Select count(FinalGrade) AS counts, 'C' AS Letter 
From GradeDistribution
Where FinalGrade = 'C' or FinalGrade = 'C-' or FinalGrade = 'C+'
Union
Select count(FinalGrade) AS counts, 'D' AS Letter 
From GradeDistribution
Where FinalGrade = 'D' or FinalGrade = 'D-' or FinalGrade = 'D+'
Union
Select count(FinalGrade) AS counts, 'Other' AS Letter 
From GradeDistribution
Where FinalGrade = 'F'
Order by Letter;

--Report 3B
Create or Replace View GradeCounts AS
Select a.FinalGrade
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = 'CSE8A' and
cc.CourseName = c.CourseName and
l.SectionID = cc.SectionID and
l.FacultyName = 'Justin Bieber' and
classes.SectionID = cc.SectionID and
a.SectionID = l.SectionID;

Select count(FinalGrade) AS counts, 'A' AS Letter 
From GradeCounts
Where FinalGrade = 'A' or FinalGrade = 'A-' or FinalGrade = 'A+'
Union
Select count(FinalGrade) AS counts, 'B' AS Letter 
From GradeCounts
Where FinalGrade = 'B' or FinalGrade = 'B-' or FinalGrade = 'B+'
Union
Select count(FinalGrade) AS counts, 'C' AS Letter 
From GradeCounts
Where FinalGrade = 'C' or FinalGrade = 'C-' or FinalGrade = 'C+'
Union
Select count(FinalGrade) AS counts, 'D' AS Letter 
From GradeCounts
Where FinalGrade = 'D' or FinalGrade = 'D-' or FinalGrade = 'D+'
Union
Select count(FinalGrade) AS counts, 'Other' AS Letter 
From GradeCounts
Where FinalGrade = 'F'
Order by Letter;

/*
Materialized views can greatly accelerate query processing. Let us consider the queries in decision support. 
The materialized views will consist in tables created with the CREATE TABLE command and updated using triggers.

Build the following materialized views, which facilitate building the decision support queries (3.a.ii), (3.a.iii).
Build a view, named CPQG, that has one tuple for every course id X, professor Y, quarter Z, and grade W, where W is one of “A”, “B”, “C”, “D”, and “other”. The tuple contains the count of grade W’s that professor Y gave at quarter Z to the students taking course X. This view is supposed to facilitate the decision support query (3.a.ii). All the explanations applicable to (3.a.ii) apply to the view as well.
Build a view, named CPG, that has one tuple for every course id X, professor Y and grade Z. The tuple contains the count of the specific grade Z that professor Y has given, when teaching course X. This view facilitates the decision support query (3.a.iii).
Rebuild the decision support queries (3.a.ii), (3.a.iii) using the (materialized) views.
The next challenge is to write triggers that maintain the views as data are inserted in the database. First build a data entry form that allows you to enter the grade G that the student S got in the section C. Then build the following trigger:
Build a trigger (or multiple triggers) that upon insertion of the grade G that the student S got in the section C, it updates appropriately the views CPQG, CPG. Note that the update of the views must be incremental. That is, you should not recompute the whole view. You must insert or update only the relevant tuple(s).
*/
