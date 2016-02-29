INSERT INTO Person VALUES ('Ramen','1');
INSERT INTO Student VALUES ('A1','Ramen','1','CA','Senior');
INSERT INTO PeriodOfAttendence(StudentID,StartTime,EndTime) VALUES ('A1','2012-09-20','2016-06-12');

INSERT INTO Department(DepartmentName) VALUES ('Computer Science');
INSERT INTO Department(DepartmentName) VALUES ('Visual Arts');
INSERT INTO Department(DepartmentName) VALUES ('Music');
INSERT INTO Department(DepartmentName) VALUES ('Bioengineering');
INSERT INTO Department(DepartmentName) VALUES ('Dimension Of Culture');

INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE 132B: Database System Application', 'Computer Science',4,1,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('DOC 2: Justice', 'Dimension Of Culture',4,1,false,'Letter Grade & Pass/No pass',false);

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('D01', 'DOC 2','Winter','2016',200);

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('A01', 'Database','Spring','2015',100);


INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE 132B: Database System Application', 'A01') ;
INSERT INTO CourseHasClass (CourseName,SectionID) VALUES ('DOC 2: Justice','D01');
	






