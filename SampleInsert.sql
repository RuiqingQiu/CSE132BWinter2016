INSERT INTO Person VALUES ('Ramen','1');
INSERT INTO Person VALUES ('Muffin','2');
INSERT INTO Person VALUES ('Raymond','3');

INSERT INTO Student VALUES ('A1','Ramen','1','CA','Senior');
INSERT INTO Student VALUES ('A2','Muffin','2','CA','Freshman');
INSERT INTO Student VALUES ('A3','Raymond','3','CA','Master');

INSERT INTO Undergraduate VALUES ('A1','Ramen','1','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A2','Muffin','2','CA','Freshman','Warren');
INSERT INTO Graduate VALUES ('A3','Raymond','3','CA','Master');

INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A1',true,'2005','Fall','2009','Spring');
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A2',true,'2009','Fall',NULL,NULL);

INSERT INTO Department(DepartmentName) VALUES ('Computer Science');
INSERT INTO Department(DepartmentName) VALUES ('Visual Arts');
INSERT INTO Department(DepartmentName) VALUES ('Music');
INSERT INTO Department(DepartmentName) VALUES ('Bioengineering');
INSERT INTO Department(DepartmentName) VALUES ('Dimension Of Culture');

INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE 132B: Database System Application', 'Computer Science',4,4,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('DOC 2: Justice', 'Dimension Of Culture',4,1,false,'Letter Grade & Pass/No pass',false);

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('D01', 'DOC 2','Spring','2009',200);
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('A01', 'Database','Spring','2009',100);
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('A02', 'Database','Fall','2009',100);
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('A03', 'Database','Winter','2011',100);

INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A1','D01',4,'Letter');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A2','A01',4,'Pass/No pass');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A2','D01',4,'Letter');

INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE 132B: Database System Application', 'A01') ;
INSERT INTO CourseHasClass (CourseName,SectionID) VALUES ('DOC 2: Justice','D01');
INSERT INTO CourseHasClass (CourseName,SectionID) VALUES ('CSE 132B: Database System Application','A02');
INSERT INTO CourseHasClass (CourseName,SectionID) VALUES ('CSE 132B: Database System Application','A03');

INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A1','D01',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A1','A01',4,'B');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A1','A02',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A1','A03',4,'C');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A2','D01',4,'A');

INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('Computer Science','B.S.',180);
INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('Bioengineering','B.S.',200);
INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('Visual Arts','B.A.',110);


	






