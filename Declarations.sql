/* Drop relationships tables */
DROP TABLE IF EXISTS PeriodOfAttendence CASCADE;
DROP TABLE IF EXISTS Probation CASCADE;
DROP TABLE IF EXISTS StudentEnrollment CASCADE;
DROP TABLE IF EXISTS EducationHistory CASCADE;
DROP TABLE IF EXISTS AcademicHistory CASCADE;
DROP TABLE IF EXISTS PhD_Advisor CASCADE;
DROP TABLE IF EXISTS Faculty_Department CASCADE;
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
	SSN varchar(255) references Person(SSN),
	Name varchar(255) Primary Key,
	Title varchar(255)
);

CREATE TABLE Undergraduate(
	StudentID varchar(10) PRIMARY KEY references Student(StudentID),
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255),
	College varchar(255)
);

CREATE TABLE BSMS(
	StudentID varchar(10) PRIMARY KEY references Undergraduate(StudentID),
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255),
	College varchar(255),
	ExpectedGraduateDate date
);

CREATE TABLE Graduate(
	StudentID varchar(10) PRIMARY KEY references Student(StudentID),
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE Master(
	StudentID varchar(10) PRIMARY KEY references Graduate(StudentID),
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE PhD(
	StudentID varchar(10) PRIMARY KEY references Graduate(StudentID),
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE PhdPreCandidacy(
	StudentID varchar(10) PRIMARY KEY references PhD(StudentID),
	Name varchar(255),
	SSN varchar(255) references Person(SSN) ON DELETE CASCADE,
	ResidenceStatus varchar(255),
	AcademicLevel varchar(255)
);

CREATE TABLE PhDCandidates(
	StudentID varchar(10) PRIMARY KEY references PhD(StudentID),
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
	DepartmentName varchar(255) references Department(DepartmentName),
	MaxUnits int,
	MinUnits int,
	RequireLabWorks BOOLEAN,
	GradeOption varchar(255),
	RequireConsentOfInstructor BOOLEAN
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
	StudentID varchar(10) references Graduate(StudentID),
	DepartmentName varchar(255) references Department(DepartmentName),
	PRIMARY KEY(StudentID,DepartmentName)
); 

CREATE TABLE PhD_Advisor(
	StudentID varchar(10) references PhD(StudentID),
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	PRIMARY KEY(StudentID, FacultyName)
);

CREATE TABLE Faculty_Department(
	FacultyName varchar(255) references Faculty(Name) ON DELETE CASCADE,
	DepartmentName varchar(255) references Department(DepartmentName) ON DELETE CASCADE,
	PRIMARY KEY(FacultyName,DepartmentName)
);

CREATE TABLE HasMajor(
	StudentID varchar(10) references Undergraduate(StudentID),
	MajorName varchar(255) references Major(MajorName),
	PRIMARY KEY(StudentID, MajorName)
 );

Create table HasMinor(
	StudentID varchar(10) references Undergraduate(StudentID),
	MinorName varchar(255) references Minor(MinorName),
	PRIMARY KEY(StudentID, MinorName)
);

Create table StudentEnrollment(
	StudentID varchar(10) references Student(StudentID),
	SectionID varchar(255) references Classes(SectionID),
	Units int NOT NULL,
	PRIMARY KEY(StudentID, SectionID)
);

Create table AcademicHistory(
	StudentID varchar(10) references Student(StudentID),
	SectionID varchar(255) references Classes(SectionID),
	Units int NOT NULL,
	PRIMARY KEY(StudentID, SectionID)
);

CREATE TABLE EducationHistory(
	StudentID varchar(10) references Student(StudentID),
	Degree varchar(255),
	University varchar(255),
	PRIMARY KEY (StudentID, Degree, University)
);


CREATE TABLE PeriodOfAttendence(
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	StartTime varchar(255),
    	EndTime varchar(255),
	PRIMARY KEY (StudentID,StartTime,EndTime)
);
     
CREATE TABLE Probation(
	ProbationID Serial PRIMARY KEY,
	StudentID varchar(10) references Student(StudentID) ON DELETE CASCADE,
	StartTime varchar(255),
	EndTime varchar(255)
);

CREATE TABLE Prereq(
	CourseName varchar(255) references Course(CourseName),
	PrereqCourseName varchar(255) references Course(CourseName),
	PRIMARY KEY (CourseName,PrereqCourseName)
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
	SectionID varchar(255) references Classes(SectionID),
	MeetingID varchar(255) references WeeklyMeeting(MeetingID)
);

CREATE TABLE ClassReview(
	CR_ID Serial Primary Key,
	SectionID varchar(255) references Classes(SectionID),
	ReviewID varchar(255) references ReviewSession(ReviewID)
);

CREATE TABLE Instructor(
	SectionID varchar(255) references Classes(SectionID),
	FacultyName varchar(255) references Faculty(Name),
	PRIMARY KEY(SectionID, FacultyName)
);

CREATE TABLE CourseHasClass(
	ID SERIAL PRIMARY KEY, 
	CourseName varchar(255) references Course(CourseName),
	SectionID varchar(255) references Classes(SectionID)
);


CREATE TABLE DegreeDetailedUnitRequirement(
	DDUR_ID Serial Primary Key,
	DegreeName varchar(255) references Degree(DegreeName),
	RequirementDescription varchar(255),
	UnitsRequired int
);
CREATE TABLE DegreeDetailedCourseRequirement(
	DDCR_ID Serial Primary Key,
	DegreeName varchar(255) references Degree(DegreeName),
	CourseName varchar(255) references Course(CourseName)
);

CREATE TABLE DegreeOffer(
	DegreeOfferID Serial Primary Key,
	DepartmentName varchar(255) references Department(DepartmentName),
	DegreeName varchar(255) references Degree(DegreeName)
);

CREATE TABLE StudentPursueDegree(
	StudentID varchar(10) references Student(StudentID),
	DegreeName varchar(255) references Degree(DegreeName)
);

CREATE TABLE ThesisCommittee(
	StudentID varchar(10) references Graduate(StudentID),
	FacultyName varchar(255) references Faculty(Name),
	DepartmentName varchar(255) references Department(DepartmentName),
	PRIMARY KEY(StudentID, FacultyName, DepartmentName)
);

CREATE TABLE OrganizationMember(
	OrganizationName varchar(255) references StudentOrganization(OrganizationName),
	StudentID varchar(255) references Student(StudentID),
	PRIMARY KEY(OrganizationName, StudentID)
);

CREATE TABLE OrganizationFacultyMentor(
	OrganizationName varchar(255) references StudentOrganization(OrganizationName),
	FacultyName varchar(255) references Faculty(Name),
	PRIMARY KEY (OrganizationName, FacultyName)
);