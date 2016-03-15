INSERT INTO Person VALUES ('Benjamin B','1');
INSERT INTO Person VALUES ('Kristen W','2');
INSERT INTO Person VALUES ('Daniel F','3');
INSERT INTO Person VALUES ('Claire J','4');
INSERT INTO Person VALUES ('Julie C','5');
INSERT INTO Person VALUES ('Kevin L','6');
INSERT INTO Person VALUES ('Michael B','7');
INSERT INTO Person VALUES ('Joseph J','8');
INSERT INTO Person VALUES ('Devin P','9');
INSERT INTO Person VALUES ('Logan F','10');
INSERT INTO Person VALUES ('Vikram N','11');
INSERT INTO Person VALUES ('Rachel Z','12');
INSERT INTO Person VALUES ('Zach M','13');
INSERT INTO Person VALUES ('Justin H','14');
INSERT INTO Person VALUES ('Rahul R','15');
INSERT INTO Person VALUES ('Dave C','16');
INSERT INTO Person VALUES ('Nelson H','17');
INSERT INTO Person VALUES ('Andrew P','18');
INSERT INTO Person VALUES ('Nathan S','19');
INSERT INTO Person VALUES ('John H','20');
INSERT INTO Person VALUES ('Anwell W','21');
INSERT INTO Person VALUES ('Tim K','22');

-- insert facult ssn into person table
INSERT INTO Person VALUES ('Justin Bieber','23');
INSERT INTO Person VALUES ('Flo Rida','24');
INSERT INTO Person VALUES ('Selena Gomez','25');
INSERT INTO Person VALUES ('Adele','26');
INSERT INTO Person VALUES ('Taylor Swift','27');
INSERT INTO Person VALUES ('Kelly Clarkson','28');
INSERT INTO Person VALUES ('Adam Levine','29');
INSERT INTO Person VALUES ('Bjork','30');
			
INSERT INTO Student VALUES ('A1','Benjamin B','1','CA','Senior');
INSERT INTO Student VALUES ('A2','Kristen W','2','CA','Freshman');
INSERT INTO Student VALUES ('A3','Daniel F','3','CA','Senior');
INSERT INTO Student VALUES ('A4','Claire J','4','CA','Junior');
INSERT INTO Student VALUES ('A5','Julie C','5','CA','Senior');
INSERT INTO Student VALUES ('A6','Kevin L','6','CA','Senior');
INSERT INTO Student VALUES ('A7','Michael B','7','CA','Senior');
INSERT INTO Student VALUES ('A8','Joseph J','8','CA','Senior');
INSERT INTO Student VALUES ('A9','Devin P','9','CA','Senior');
INSERT INTO Student VALUES ('A10','Logan F','10','CA','Senior');
INSERT INTO Student VALUES ('A11','Vikram N','11','CA','Senior');
INSERT INTO Student VALUES ('A12','Rachel Z','12','CA','Senior');
INSERT INTO Student VALUES ('A13','Zach M','13','CA','Senior');
INSERT INTO Student VALUES ('A14','Justin H','14','CA','Senior');
INSERT INTO Student VALUES ('A15','Rahul R','15','CA','Senior');
INSERT INTO Student VALUES ('A16','Dave C','16','CA','Master');
INSERT INTO Student VALUES ('A17','Nelson H','17','CA','Master');
INSERT INTO Student VALUES ('A18','Andrew P','18','CA','Master');
INSERT INTO Student VALUES ('A19','Nathan S','19','CA','Master');
INSERT INTO Student VALUES ('A20','John H','20','CA','Master');
INSERT INTO Student VALUES ('A21','Anwell W','21','CA','Master');
INSERT INTO Student VALUES ('A22','Tim K','22','CA','Master');

INSERT INTO Undergraduate VALUES ('A1','Benjamin B','1','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A2','Kristen W','2','CA','Freshman','Warren');
INSERT INTO Undergraduate VALUES ('A3','Daniel F','3','CA','Senior','Warren');
INSERT INTO Undergraduate VALUES ('A4','Claire J','4','CA','Junior','Sixth');
INSERT INTO Undergraduate VALUES ('A5','Julie C','5','CA','Senior','Warren');
INSERT INTO Undergraduate VALUES ('A6','Kevin L','6','CA','Senior','Muir');
INSERT INTO Undergraduate VALUES ('A7','Julie C','7','CA','Senior','ERC');
INSERT INTO Undergraduate VALUES ('A8','Claire J','8','CA','Senior','Warren');
INSERT INTO Undergraduate VALUES ('A9','Julie C','9','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A10','Claire J','10','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A11','Vikram N','11','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A12','Rachel Z','12','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A13','Zach M','13','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A14','Justin H','14','CA','Senior','Marshall');
INSERT INTO Undergraduate VALUES ('A15','Rahul R','15','CA','Senior','Marshall');

INSERT INTO Graduate VALUES ('A16','Dave C','16','CA','Master');
INSERT INTO Graduate VALUES ('A17','Nelson H','17','CA','Master');
INSERT INTO Graduate VALUES ('A18','Andrew P','18','CA','Master');
INSERT INTO Graduate VALUES ('A19','Nathan S','19','CA','Master');
INSERT INTO Graduate VALUES ('A20','John H','20','CA','Master');
INSERT INTO Graduate VALUES ('A21','Anwell W','21','CA','Master');
INSERT INTO Graduate VALUES ('A22','Tim K','22','CA','Master');

INSERT INTO Master VALUES ('A16', 'Dave C', '16', 'CA', 'Master');
INSERT INTO Master VALUES ('A17', 'Nelson H', '17', 'CA', 'Master');
INSERT INTO Master VALUES ('A18', 'Andrew P', '18', 'CA', 'Master');
INSERT INTO Master VALUES ('A19', 'Nathan S', '19', 'CA', 'Master');
INSERT INTO Master VALUES ('A20', 'John H', '20', 'CA', 'Master');
INSERT INTO Master VALUES ('A21', 'Anwell W', '21', 'CA', 'Master');
INSERT INTO Master VALUES ('A22', 'Tim K', '22', 'CA', 'Master');

INSERT INTO Faculty(SSN,Name,Title) VALUES ('23','Justin Bieber','Associate Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('24','Flo Rida','Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('25','Selena Gomez','Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('26','Adele','Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('27','Taylor Swift','Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('28','Kelly Clarkson','Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('29','Adam Levine','Professor');
INSERT INTO Faculty(SSN,Name,Title) VALUES ('30','Bjork','Professor');
	
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A1',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A2',true,'2016','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A3',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A4',true,'2013','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A5',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A6',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A7',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A8',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A9',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A10',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A11',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A12',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A13',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A14',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A15',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A16',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A17',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A18',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A19',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A20',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A21',true,'2012','Fall',NULL,NULL);
INSERT INTO PeriodOfAttendence(StudentID,isCurrentStudent,StartYear,StartQuarter,EndYear,EndQuarter) VALUES ('A22',true,'2012','Fall',NULL,NULL);

INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('B.S. in Computer Science','B.S.',40);
INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('B.A. in Philosophy','B.A.',35);
INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('B.S. in Mechanical Engineering','B.S.',50);
INSERT INTO Degree(DegreeName,Type,TotalUnitsRequired) VALUES ('M.S. in Computer Science','M.S.', 45);

INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A1','B.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A2','B.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A3','B.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A4','B.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A5','B.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A6','B.S. in Mechanical Engineering');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A7','B.S. in Mechanical Engineering');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A8','B.S. in Mechanical Engineering');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A9','B.S. in Mechanical Engineering');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A10','B.S. in Mechanical Engineering');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A11','B.A. in Philosophy');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A12','B.A. in Philosophy');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A13','B.A. in Philosophy');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A14','B.A. in Philosophy');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A15','B.A. in Philosophy');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A16','M.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A17','M.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A18','M.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A19','M.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A20','M.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A21','M.S. in Computer Science');
INSERT INTO StudentPursueDegree(StudentID,DegreeName) VALUES ('A22','M.S. in Computer Science');

INSERT INTO Department(DepartmentName) VALUES ('Computer Science');
INSERT INTO Department(DepartmentName) VALUES ('Philosophy');
INSERT INTO Department(DepartmentName) VALUES ('Mechanical and Aerospace Engineering');
INSERT INTO Department(DepartmentName) VALUES ('Visual Arts');
INSERT INTO Department(DepartmentName) VALUES ('Music');
INSERT INTO Department(DepartmentName) VALUES ('Bioengineering');
INSERT INTO Department(DepartmentName) VALUES ('Dimension Of Culture');

INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE8A', 'Computer Science',4,4,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE105', 'Computer Science',4,4,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE123', 'Computer Science',4,4,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE250A', 'Computer Science',4,4,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE250B', 'Computer Science',4,4,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE255', 'Computer Science',4,4,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE232A', 'Computer Science',4,4,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('CSE221', 'Computer Science',4,4,false,'Letter Grade Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('MAE3','Mechanical and Aerospace Engineering',4,4,false,'Pass/No pass Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('MAE107','Mechanical and Aerospace Engineering',4,4,false,'Pass/No pass Only',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('MAE108','Mechanical and Aerospace Engineering',4,4,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('PHIL10','Philosophy',4,4,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('PHIL12','Philosophy',4,4,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('PHIL165','Philosophy',4,2,false,'Letter Grade & Pass/No pass',false);
INSERT INTO Course(CourseName,DepartmentName,MaxUnits,MinUnits,RequireLabWorks,GradeOption,RequireConsentOfInstructor) 
	VALUES ('PHIL167','Philosophy',4,2,false,'Letter Grade & Pass/No pass',false);

-- CSE 8A classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('11', 'Introduction to Computer Science: Java','Fall','2014',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE8A', '11');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('12', 'Introduction to Computer Science: Java','Spring','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE8A', '12');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('13', 'Introduction to Computer Science: Java','Fall','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE8A', '13');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('10', 'Introduction to Computer Science: Java','Winter','2016',5);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE8A', '10');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('15', 'Introduction to Computer Science: Java','Spring','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE8A', '15');
-- CSE105 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('16', 'Intro to Theory','Winter','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE105', '16');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('6', 'Intro to Theory','Winter','2016',3);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE105', '6');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('18', 'Intro to Theory','Fall','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE105', '18');
-- CSE 250A classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('19', 'Probabilistic Reasoning','Fall','2014',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE250A', '19');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('20', 'Probabilistic Reasoning','Fall','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE250A', '20');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('21', 'Probabilistic Reasoning','Spring','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE250A', '21');
-- CSE 250B classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('22', 'Machine Learning','Winter','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE250B', '22');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('23', 'Machine Learning','Fall','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE250B', '23');
-- CSE 255 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('24', 'Data Mining and Predictive Analytics','Fall','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE255', '24');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('3', 'Data Mining and Predictive Analytics','Winter','2016',5);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE255', '3');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('26', 'Data Mining and Predictive Analytics','Winter','2017',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE255', '26');
-- CSE 232A classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('27', 'Databases','Fall','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE232A', '27');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('28', 'Databases','Spring','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE232A', '28');
-- CSE 221 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('29', 'Operating Systems','Spring','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE221', '29');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('2', 'Operating Systems','Winter','2016',5);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE221', '2');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('5', 'Operating Systems','Winter','2016',3);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE221', '5');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('9', 'Operating Systems','Winter','2016',2);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE221', '9');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('31', 'Operating Systems','Fall','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('CSE221', '31');
-- MAE 107 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('32', 'Computational Methods','Spring','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE107', '32');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('33', 'Computational Methods','Spring','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE107', '33');
-- MAE 108 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('34', 'Probability and Statistics','Fall','2014',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE108', '34');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('35', 'Probability and Statistics','Winter','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE108', '35');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('1', 'Probability and Statistics','Winter','2016',2);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE108', '1');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('8', 'Probability and Statistics','Winter','2016',1);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE108', '8');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('37', 'Probability and Statistics','Fall','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('MAE108', '37');
-- PHIL10 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('38', 'Intro to Logic','Fall','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL10', '38');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('39', 'Intro to Logic','Winter','2017',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL10', '39');
-- PHIL12 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('4', 'Scientific Reasoning','Winter','2016',2);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL12', '4');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('41', 'Scientific Reasoning','Spring','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL12', '41');
-- PHIL165 classes
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('42', 'Freedom, Equality, and the Law','Spring','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL165', '42');
INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('43', 'Freedom, Equality, and the Law','Fall','2015',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL165', '43');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('7', 'Freedom, Equality, and the Law','Winter','2016',3);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL165', '7');

INSERT INTO Classes(SectionID,Title,Quarter,Year,MaxEnrollment) 
	VALUES ('45', 'Freedom, Equality, and the Law','Fall','2016',200);
INSERT INTO CourseHasClass(CourseName,SectionID) VALUES ('PHIL165', '45');

INSERT INTO CATEGORY VALUES ('LD');
INSERT INTO CATEGORY VALUES ('UD');
INSERT INTO CATEGORY VALUES ('TE');
INSERT INTO CATEGORY VALUES ('GU'); -- Grad Units in Major

INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.S. in Computer Science','LD',10);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.S. in Computer Science','UD',15);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.S. in Computer Science','TE',15);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.A. in Philosophy','LD',15);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.A. in Philosophy','UD',20);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.A. in Philosophy','TE',0);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.S. in Mechanical Engineering','LD',20);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.S. in Mechanical Engineering','UD',20);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('B.S. in Mechanical Engineering','TE',10);
INSERT INTO DegreeDetailedUnitRequirement(DegreeName,Category,UnitsRequired) VALUES ('M.S. in Computer Science','GU',45);

INSERT INTO CourseCategory(CourseName,Category) VALUES('CSE250A','TE');
INSERT INTO CourseCategory(CourseName,Category) VALUES('CSE221','TE');
INSERT INTO CourseCategory(CourseName,Category) VALUES('CSE105','TE');
INSERT INTO CourseCategory(CourseName,Category) VALUES('MAE107','TE');
INSERT INTO CourseCategory(CourseName,Category) VALUES('MAE3','TE');
INSERT INTO CourseCategory VALUES ('CSE8A', 'LD');
INSERT INTO CourseCategory VALUES ('CSE105', 'UD');
INSERT INTO CourseCategory VALUES ('CSE123', 'UD');
INSERT INTO CourseCategory VALUES ('CSE250A', 'GU');
INSERT INTO CourseCategory VALUES ('CSE250B', 'GU');
INSERT INTO CourseCategory VALUES ('CSE255', 'GU');
INSERT INTO CourseCategory VALUES ('CSE232A', 'GU');
INSERT INTO CourseCategory VALUES ('CSE221', 'GU');
INSERT INTO CourseCategory VALUES ('MAE3', 'LD');
INSERT INTO CourseCategory VALUES ('MAE107', 'UD');
INSERT INTO CourseCategory VALUES ('MAE108', 'UD');
INSERT INTO CourseCategory VALUES ('PHIL10', 'LD');
INSERT INTO CourseCategory VALUES ('PHIL12', 'LD');
INSERT INTO CourseCategory VALUES ('PHIL165', 'UD');
INSERT INTO CourseCategory VALUES ('PHIL167', 'UD');

INSERT INTO Concentration VALUES ('Databases', 3.0, 4);
INSERT INTO Concentration VALUES ('AI', 3.1, 8);
INSERT INTO Concentration VALUES ('Systems', 3.3, 4);

INSERT INTO ConcentrationCourse VALUES ('Databases', 'CSE232A');
INSERT INTO ConcentrationCourse VALUES ('AI', 'CSE255');
INSERT INTO ConcentrationCourse VALUES ('AI', 'CSE250A');
INSERT INTO ConcentrationCourse VALUES ('Systems', 'CSE221');

INSERT INTO DegreeConcentration VALUES ('M.S. in Computer Science', 'Databases');
INSERT INTO DegreeConcentration VALUES ('M.S. in Computer Science', 'AI');
INSERT INTO DegreeConcentration VALUES ('M.S. in Computer Science', 'Systems');

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(1,'Lec','WLH 2001',false,'MWF','10:00AM');
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(13,'Dis','WLH 2001',false,'TueThu','10:00AM');
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(14,'Lab','CSE 250',false,'F','6:00PM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(1,'WLH 2001',false,'Mon','Mar 14th','8:00AM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(1,1);
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(1,13);
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(1,14);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (1,1,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(2,'Lec','WLH 2005',false,'MWF','10:00AM');
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(15,'Dis','WLH 2005',false,'TueThu','11:00AM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(2,'WLH 2001',false,'Mon','Mar 7th','8:00AM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(3,'WLH 2001',false,'Mon','Mar 14th','8:00AM');

INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(2,2);
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(2,15);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (2,2,false);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (2,3,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(3,'Lec','WLH 2001',false,'MWF','12:00PM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(4,'WLH 2001',false,'Wed','Mar 16th','8:00AM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(3,3);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (3,4,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(4,'Lec','WLH 2005',false,'MWF','12:00PM');
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(16,'Dis','WLH 2005',false,'WF','1:00PM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(5,'WLH 2001',false,'Mon','Mar 7th','9:00AM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(6,'WLH 2001',false,'Mon','Mar 14th','8:00AM');

INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(4,4);
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(4,16);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (4,5,false);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (4,6,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(5,'Lec','WLH 2000',false,'MWF','12:00PM');
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(17,'Dis','WLH 2000',false,'TueThu','12:00PM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(7,'WLH 2001',false,'Tue','Mar 8th','8:00AM');
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(8,'WLH 2001',false,'Tue','Mar 15th','8:00AM');

INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(5,5);
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(5,17);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (5,7,false);
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (5,8,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(6,'Lec','WLH 2000',false,'TueThu','2:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(6,6);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(7,'Dis','WLH 2001',false,'Fri','6:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(6,7);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(9,'WLH 2001',false,'Tue','Mar 15th','1:00PM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (6,9,false);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(10,'WLH 2001',false,'Thu','Mar 17th','8:00AMs');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (6,10,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(8,'Lec','WLH 2001',false,'TueThu','3:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(7,8);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(18,'Dis','WLH 2001',false,'Thu','1:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(7,18);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(11,'WLH 2001',false,'Fri','Jan 29th','8:00AMs');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (7,11,false);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(12,'WLH 2001',false,'Thu','Mar 17th','5:00PM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (7,12,false);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(13,'WLH 2001',false,'Fri','Mar 18th','8:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (7,13,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(9,'Lec','WLH 2005',false,'TueThu','3:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(8,9);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(19,'Dis','WLH 2005',false,'Mon','3:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(8,19);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(20,'Lab','CSE 220',false,'Fri','5:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(8,20);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(14,'WLH 2001',false,'Tue','Mar 15th','8:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (8,14,true);

INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(10,'Lec','WLH 2000',false,'TueThu','5:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(9,10);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(21,'Dis','WLH 2000',false,'MonFri','9:00AM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(9,21);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(15,'WLH 2001',false,'Wed','Mar 9th','8:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (9,15,false);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(16,'WLH 2001',false,'Wed','Mar 16th','8:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (9,16,true);


INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(11,'Lec','WLH 2000',false,'TueThu','5:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(10,11);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(12,'Dis','WLH 2005',false,'Wed','7:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(10,12);
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(22,'Lab','WLH 2005',false,'TueThu','3:00PM');
INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES(10,22);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(17,'WLH 2001',false,'Mon','Feb 15th','11:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (10,17,false);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(18,'WLH 2001',false,'Mon','Mar 14th','11:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (10,18,false);
INSERT INTO ReviewSession(ReviewID,Location,IsMandatory,DayOfTheWeek,Date,Time) VALUES(19,'WLH 2001',false,'Tue','Mar 15th','8:00AM');
INSERT INTO ClassReview(SectionID,ReviewID,IsFinal) VALUES (10,19,true);

INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A16','2',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A17','9',4,'Pass/No pass Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A18','5',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A19','2',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A20','9',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A21','5',4,'Pass/No pass Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A22','3',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A16','3',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A17','3',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A1','10',4,'Pass/No pass Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A5','10',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A3','10',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A7','1',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A8','1',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A9','8',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A4','6',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A12','4',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A13','7',4,'Pass/No pass Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A14','4',4,'Letter Grade Only');
INSERT INTO StudentEnrollment(StudentID,SectionID,Units,GradeOption) VALUES('A15','7',4,'Letter Grade Only');

INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A1','11',4,'A-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A3','11',4,'B+');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A2','12',4,'C-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A4','13',4,'A-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A5','13',4,'B');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A1','16',4,'A-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A5','16',4,'B+');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A4','16',4,'C');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A16','19',4,'C');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A22','20',4,'B+');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A18','20',4,'D');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A19','20',4,'F');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A17','22',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A19','22',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A20','24',4,'B-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A18','24',4,'B');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A21','24',4,'F');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A17','27',4,'A-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A22','29',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A20','29',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A10','32',4,'B+');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A8','34',2,'B-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A7','34',4,'A-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A6','35',2,'B');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A10','35',2,'B+');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A11','38',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A12','38',4,'A');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A13','38',4,'C-');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A14','38',4,'C+');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A15','42',2,'F');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A12','42',2,'D');
INSERT INTO AcademicHistory(StudentID,SectionID,Units,FinalGrade) VALUES('A11','43',2,'A-');

INSERT INTO Instructor(SectionID,FacultyName) VALUES('11','Justin Bieber');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('42','Flo Rida');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('13','Selena Gomez');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('34','Adele');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('6','Taylor Swift');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('12','Kelly Clarkson');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('19','Bjork');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('38','Bjork');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('22','Justin Bieber');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('24','Flo Rida');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('35','Selena Gomez');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('10','Adele');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('16','Taylor Swift');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('27','Kelly Clarkson');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('43','Adam Levine');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('32','Bjork');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('3','Justin Bieber');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('1','Selena Gomez');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('8','Selena Gomez');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('4','Adam Levine');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('20','Bjork');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('7','Taylor Swift');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('29','Kelly Clarkson');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('2','Kelly Clarkson');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('5','Kelly Clarkson');
INSERT INTO Instructor(SectionID,FacultyName) VALUES('9','Kelly Clarkson');










