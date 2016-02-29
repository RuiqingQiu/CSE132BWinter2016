/* Drop relationships tables */
DROP TABLE IF EXISTS PeriodOfAttendence CASCADE;
DROP TABLE IF EXISTS Probation CASCADE;
DROP TABLE IF EXISTS StudentEnrollment CASCADE;
DROP TABLE IF EXISTS EducationHistory CASCADE;
DROP TABLE IF EXISTS AcademicHistory CASCADE;
DROP TABLE IF EXISTS PhD_Advisor CASCADE;
DROP TABLE IF EXISTS FacultyDepartment CASCADE;
DROP TABLE IF EXISTS StudentPursueDegree CASCADE;
DROP TABLE IF EXISTS HasMajor CASCADE;
DROP TABLE IF EXISTS HasMinor CASCADE;
DROP TABLE IF EXISTS Prereq CASCADE;
DROP TABLE IF EXISTS DegreeDetailedUnitRequirement CASCADE;
DROP TABLE IF EXISTS DegreeDetailedCourseRequirement CASCADE;
DROP TABLE IF EXISTS ThesisCommittee CASCADE;
DROP TABLE IF EXISTS DegreeOffer CASCADE;
DROP TABLE IF EXISTS GraduateDepartment CASCADE;
DROP TABLE IF EXISTS ClassMeeting CASCADE;
DROP TABLE IF EXISTS ClassReview CASCADE;
DROP TABLE IF EXISTS ReviewSession CASCADE;
DROP TABLE IF EXISTS WeeklyMeeting CASCADE;
DROP TABLE IF EXISTS CourseHasClass CASCADE;
DROP TABLE IF EXISTS Instructor CASCADE;
DROP TABLE IF EXISTS OrganizationFacultyMentor CASCADE;
DROP TABLE IF EXISTS OrganizationMember CASCADE;
DROP TABLE IF EXISTS CourseCategory CASCADE;

/* Drop Entity Tables */
DROP TABLE IF EXISTS StudentOrganization;
DROP TABLE IF EXISTS Degree CASCADE;
DROP TABLE IF EXISTS Faculty CASCADE;
DROP TABLE IF EXISTS PhdPreCandidacy CASCADE;
DROP TABLE IF EXISTS PhDCandidates CASCADE;
DROP TABLE IF EXISTS PhD CASCADE;
DROP TABLE IF EXISTS Classes CASCADE;
DROP TABLE IF EXISTS Course CASCADE;
DROP TABLE IF EXISTS Department CASCADE;
DROP TABLE IF EXISTS Major CASCADE;
DROP TABLE IF EXISTS Minor CASCADE;
DROP TABLE IF EXISTS Master CASCADE;
DROP TABLE IF EXISTS BSMS CASCADE;
DROP TABLE IF EXISTS Undergraduate CASCADE;
DROP TABLE IF EXISTS Graduate CASCADE;
DROP TABLE IF EXISTS Student CASCADE;
DROP TABLE IF EXISTS Person CASCADE;
DROP TABLE IF EXISTS Category CASCADE;

DROP TABLE IF EXISTS GRADE_CONVERSION CASCADE;
/* CONSTRAINTS: 
PRIMARY KEY: default not null 
*/

/* Create entity tables first */
CREATE TABLE Person
(
	Name varchar(255) NOT NULL,
	SSN varchar(255),
	PRIMARY KEY (SSN)
);

CREATE TABLE Student
(
	StudentID varchar(10) NOT NULL PRIMARY KEY,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE Faculty(
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	Name varchar(255) Primary Key,
	Title varchar(255)
);

CREATE TABLE Undergraduate(
	StudentID varchar(10) PRIMARY KEY references Student(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255),
	College varchar(255)
);

CREATE TABLE BSMS(
	StudentID varchar(10) PRIMARY KEY references Undergraduate(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255),
	College varchar(255),
	ExpectedGraduateDate date
);

CREATE TABLE Graduate(
	StudentID varchar(10) PRIMARY KEY references Student(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE Master(
	StudentID varchar(10) PRIMARY KEY references Graduate(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE PhD(
	StudentID varchar(10) PRIMARY KEY references Graduate(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE PhdPreCandidacy(
	StudentID varchar(10) PRIMARY KEY references PhD(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE PhDCandidates(
	StudentID varchar(10) PRIMARY KEY references PhD(StudentID) ON DELETE CASCADE,
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE Department(
	DepartmentName varchar(255) NOT NULL PRIMARY KEY
);

CREATE TABLE Classes(
	SectionID varchar(255) NOT NULL PRIMARY KEY,
	Title varchar(255),
	Quarter varchar(255),
	Year varchar(255),
	MaxEnrollment int
);

CREATE TABLE Course(
	CourseName varchar(255) NOT NULL PRIMARY KEY,
	DepartmentName varchar(255) references Department(DepartmentName) ON DELETE CASCADE,
	MaxUnits int,
	MinUnits int,
	RequireLabWorks BOOLEAN,
	GradeOption varchar(255),
	RequireConsentOfInstructor BOOLEAN
);

CREATE TABLE CourseHasClass(
	ID SERIAL PRIMARY KEY, 
	CourseName varchar(255) references Course(CourseName) ON DELETE CASCADE,
	SectionID varchar(255) references Classes(SectionID) ON DELETE CASCADE
);

CREATE TABLE Major(
	MajorName varchar(255) PRIMARY KEY
);

CREATE TABLE Minor(
	MinorName varchar(255) PRIMARY KEY
);

CREATE TABLE Degree(
	DegreeName varchar(255) NOT NULL PRIMARY KEY,
	TotalUnitsRequired int
);

CREATE TABLE StudentOrganization(
	OrganizationName varchar(255) PRIMARY KEY
);

/* Relationship Table begins */
CREATE TABLE GraduateDepartment(
	GD_ID Serial Primary Key,
	StudentID varchar(10) references Graduate(StudentID) ON DELETE CASCADE,
	DepartmentName varchar(255) references Department(DepartmentName) ON DELETE CASCADE
); 

CREATE TABLE PhD_Advisor(
	StudentID varchar(10) references PhD(StudentID) ON DELETE CASCADE,
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	PRIMARY KEY(StudentID, FacultyName)
);

CREATE TABLE FacultyDepartment(
	FD_ID Serial Primary Key,
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	DepartmentName varchar(255) references Department(DepartmentName) ON DELETE CASCADE
);

CREATE TABLE HasMajor(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	MajorName varchar(255) references Major(MajorName) ON DELETE CASCADE,
	PRIMARY KEY(StudentID, MajorName)
 );

Create table HasMinor(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	MinorName varchar(255) references Minor(MinorName) ON DELETE CASCADE,
	PRIMARY KEY(StudentID, MinorName)
);

Create table StudentEnrollment(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	SectionID varchar(255) references Classes(SectionID) ON DELETE CASCADE,
	Units int NOT NULL,
	GradeOption varchar(255),
	PRIMARY KEY(StudentID, SectionID)
);

Create table AcademicHistory(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	SectionID varchar(255) references Classes(SectionID) ON DELETE CASCADE,
	Units int NOT NULL,
	FinalGrade varchar(255),
	PRIMARY KEY(StudentID, SectionID)
);

CREATE TABLE EducationHistory(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	Degree varchar(255),
	University varchar(255),
	PRIMARY KEY (StudentID, Degree, University)
);


CREATE TABLE PeriodOfAttendence(
	ID Serial Primary key,
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	isCurrentStudent boolean,
	StartYear varchar(255),
	StartQuarter varchar(255),
    	EndYear varchar(255),
    	EndQuarter varchar(255)
);
     
CREATE TABLE Probation(
	ProbationID Serial PRIMARY KEY,
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	StartTime varchar(255),
	EndTime varchar(255)
);

CREATE TABLE Prereq(
	CourseName varchar(255) references Course(CourseName) ON DELETE CASCADE,
	PrereqCourseName varchar(255) references Course(CourseName) ON DELETE CASCADE,
	PRIMARY KEY(CourseName,PrereqCourseName)
);

CREATE TABLE WeeklyMeeting(
	MeetingID varchar(255) NOT NULL PRIMARY KEY, 
	Type varchar(255),
	Location varchar(255),
	IsMandatory BOOLEAN,
	DayOfTheWeek varchar(255),
	Time varchar(255)
);

CREATE TABLE ReviewSession(
	ReviewID varchar(255) NOT NULL PRIMARY KEY,
	Location varchar(255),
	IsMandatory BOOLEAN,
	Date varchar(255),
	Time varchar(255)
);

CREATE TABLE ClassMeeting(
	SectionID varchar(255) references Classes(SectionID) ON DELETE CASCADE,
	MeetingID varchar(255) references WeeklyMeeting(MeetingID) ON DELETE CASCADE
);

CREATE TABLE ClassReview(
	CR_ID Serial Primary Key,
	SectionID varchar(255) references Classes(SectionID) ON DELETE CASCADE,
	ReviewID varchar(255) references ReviewSession(ReviewID) ON DELETE CASCADE
);

CREATE TABLE Instructor(
	SectionID varchar(255) references Classes(SectionID) ON DELETE CASCADE,
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	PRIMARY KEY(SectionID, FacultyName)
);

CREATE TABLE Category(
	CategoryName varchar(255) PRIMARY KEY
);

CREATE TABLE CourseCategory(
	CourseName varchar(255) references Course(CourseName) ON DELETE CASCADE,
	Category varchar(255) references Category(CategoryName) ON DELETE CASCADE
);

CREATE TABLE DegreeDetailedUnitRequirement(
	DDUR_ID Serial Primary Key,
	DegreeName varchar(255) references Degree(DegreeName) ON DELETE CASCADE,
	Category varchar(255) references Category(CategoryName) ON DELETE CASCADE,
	UnitsRequired int
);
CREATE TABLE DegreeDetailedCourseRequirement(
	DDCR_ID Serial Primary Key,
	DegreeName varchar(255) references Degree(DegreeName) ON DELETE CASCADE,
	CourseName varchar(255) references Course(CourseName) ON DELETE CASCADE
);

CREATE TABLE DegreeOffer(
	DegreeOfferID Serial Primary Key,
	DepartmentName varchar(255) references Department(DepartmentName) ON DELETE CASCADE,
	DegreeName varchar(255) references Degree(DegreeName) ON DELETE CASCADE
);

CREATE TABLE StudentPursueDegree(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	DegreeName varchar(255) references Degree(DegreeName) ON DELETE CASCADE,
	Primary key (StudentID, DegreeName)
);

CREATE TABLE ThesisCommittee(
	StudentID varchar(10) references Graduate(StudentID) ON DELETE CASCADE,
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	DepartmentName varchar(255) references Department(DepartmentName) ON DELETE CASCADE,
	PRIMARY KEY(StudentID, FacultyName, DepartmentName)
);

CREATE TABLE OrganizationMember(
	OrganizationName varchar(255) references StudentOrganization(OrganizationName) ON DELETE CASCADE,
	StudentID varchar(255) references Student(StudentID) ON DELETE CASCADE,
	PRIMARY KEY(OrganizationName, StudentID)
);

CREATE TABLE OrganizationFacultyMentor(
	OrganizationName varchar(255) references StudentOrganization(OrganizationName) ON DELETE CASCADE,
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	PRIMARY KEY (OrganizationName, FacultyName)
);

create table GRADE_CONVERSION
( 
	LETTER_GRADE CHAR(2) NOT NULL,
	NUMBER_GRADE DECIMAL(2,1)
);
insert into grade_conversion values('A+', 4.3);
insert into grade_conversion values('A', 4);
insert into grade_conversion values('A-', 3.7);
insert into grade_conversion values('B+', 3.4);
insert into grade_conversion values('B', 3.1);
insert into grade_conversion values('B-', 2.8);
insert into grade_conversion values('C+', 2.5);
insert into grade_conversion values('C', 2.2);
insert into grade_conversion values('C-', 1.9);
insert into grade_conversion values('D', 1.6); 