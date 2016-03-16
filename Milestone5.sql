Drop table if exists CPQG;
Drop table if exists CPG;

CREATE TABLE CPQG(
	CourseName varchar(255),
	FacultyName varchar(255), 
	Quarter varchar(255),
	Year varchar(255),
	Grade varchar(255),
	GradeCount int
);

--Report 3A
Insert into CPQG
Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'A', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year;
Insert into CPQG
Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'B', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year;
Insert into CPQG
Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'C', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year;
Insert into CPQG
Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'D', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year;
Insert into CPQG
Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'Other', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year;

Update CPQG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'A' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='A' or a.FinalGrade = 'A-' or a.FinalGrade = 'A+')
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year) i
Where cpqg.Grade = 'A' and i.CourseName = cpqg.CourseName and i.FacultyName = cpqg.FacultyName 
and i.Quarter = cpqg.Quarter and i.Year = cpqg.Year;

Update CPQG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'B' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='B' or a.FinalGrade = 'B-' or a.FinalGrade = 'B+')
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year) i
Where cpqg.Grade = 'B' and i.CourseName = cpqg.CourseName and i.FacultyName = cpqg.FacultyName 
and i.Quarter = cpqg.Quarter and i.Year = cpqg.Year;

Update CPQG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'C' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='C' or a.FinalGrade = 'C-' or a.FinalGrade = 'C+')
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year) i
Where cpqg.Grade = 'C' and i.CourseName = cpqg.CourseName and i.FacultyName = cpqg.FacultyName 
and i.Quarter = cpqg.Quarter and i.Year = cpqg.Year;

Update CPQG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'D' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='D' or a.FinalGrade = 'D-' or a.FinalGrade = 'D+')
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year) i
Where cpqg.Grade = 'D' and i.CourseName = cpqg.CourseName and i.FacultyName = cpqg.FacultyName 
and i.Quarter = cpqg.Quarter and i.Year = cpqg.Year;

Update CPQG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, classes.Quarter, classes.Year, 'Other' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='F')
Group by c.CourseName, l.FacultyName, classes.Quarter, classes.Year) i
Where cpqg.Grade = 'Other' and i.CourseName = cpqg.CourseName and i.FacultyName = cpqg.FacultyName 
and i.Quarter = cpqg.Quarter and i.Year = cpqg.Year;

DROP Trigger IF EXISTS cpqg_insert on AcademicHistory;
CREATE OR REPLACE FUNCTION cpqg_insert_func() RETURNS TRIGGER AS $cpqg_insert$
    BEGIN
	if (NEW.FinalGrade = 'A' or NEW.FinalGrade = 'A-' or NEW.FinalGrade = 'A+')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'A' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'B' or NEW.FinalGrade = 'B-' or NEW.FinalGrade = 'B+')
	then 
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'B' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'C' or NEW.FinalGrade = 'C-' or NEW.FinalGrade = 'C+')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'C' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'D' or NEW.FinalGrade = 'D-' or NEW.FinalGrade = 'D+')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'D' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'F')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'Other' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
		RETURN NEW;
	end if;
	END;
$cpqg_insert$ LANGUAGE plpgsql;

CREATE TRIGGER cpqg_insert After INSERT ON AcademicHistory
FOR EACH ROW EXECUTE PROCEDURE cpqg_insert_func();
-- End of insert trigger

-- Begin of Update AcademicHistory Trigger

DROP Trigger IF EXISTS cpqg_update on AcademicHistory;

CREATE OR REPLACE FUNCTION cpqg_update_func() RETURNS TRIGGER AS $cpqg_update$
    BEGIN
	If (OLD.FinalGrade = NEW.FinalGrade)
	then
		return NEW;
	end if;
	-- Decrement the old value	
	if (NEW.FinalGrade = 'A' or NEW.FinalGrade = 'A-' or NEW.FinalGrade = 'A+')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'A' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (NEW.FinalGrade = 'B' or NEW.FinalGrade = 'B-' or NEW.FinalGrade = 'B+')
	then 
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'B' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (NEW.FinalGrade = 'C' or NEW.FinalGrade = 'C-' or NEW.FinalGrade = 'C+')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'C' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (NEW.FinalGrade = 'D' or NEW.FinalGrade = 'D-' or NEW.FinalGrade = 'D+')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'D' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (NEW.FinalGrade = 'F')
	then
		Update cpqg
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'Other' and cc.SectionID = NEW.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = NEW.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	end if;

	if (OLD.FinalGrade = 'A' or OLD.FinalGrade = 'A-' or OLD.FinalGrade = 'A+')
	then
		Update cpqg
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'A' and cc.SectionID = OLD.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = OLD.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;

	ELSIF (OLD.FinalGrade = 'B' or OLD.FinalGrade = 'B-' or OLD.FinalGrade = 'B+')
	then 
		Update cpqg
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'B' and cc.SectionID = OLD.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = OLD.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (OLD.FinalGrade = 'C' or OLD.FinalGrade = 'C-' or OLD.FinalGrade = 'C+')
	then
		Update cpqg
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'C' and cc.SectionID = OLD.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = OLD.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (OLD.FinalGrade = 'D' or OLD.FinalGrade = 'D-' or OLD.FinalGrade = 'D+')
	then
		Update cpqg
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'D' and cc.SectionID = OLD.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = OLD.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	ELSIF (OLD.FinalGrade = 'F')
	then
		Update cpqg
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l, Classes classes
		Where cpqg.Grade = 'Other' and cc.SectionID = OLD.SectionID and cpqg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpqg.FacultyName = l.FacultyName and classes.SectionID = OLD.SectionID
		and classes.Quarter = cpqg.Quarter and classes.Year = cpqg.Year;
	end if;
	RETURN NEW;
	End;
$cpqg_update$ LANGUAGE plpgsql;


CREATE TRIGGER cpqg_update After Update ON AcademicHistory
FOR EACH ROW EXECUTE PROCEDURE cpqg_update_func();


-- Report 3B
CREATE TABLE CPG(
	CourseName varchar(255),
	FacultyName varchar(255), 
	Grade varchar(255),
	GradeCount int
);
Insert into CPG
Select c.CourseName, l.FacultyName, 'A', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName;
Insert into CPG
Select c.CourseName, l.FacultyName, 'B', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName;
Insert into CPG
Select c.CourseName, l.FacultyName, 'C', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName;
Insert into CPG
Select c.CourseName, l.FacultyName, 'D', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName;
Insert into CPG
Select c.CourseName, l.FacultyName, 'Other', 0
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID
Group by c.CourseName, l.FacultyName;

Update CPG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, 'A' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='A' or a.FinalGrade = 'A-' or a.FinalGrade = 'A+')
Group by c.CourseName, l.FacultyName) i
Where cpg.Grade = 'A' and i.CourseName = cpg.CourseName and i.FacultyName = cpg.FacultyName;

Update CPG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, 'B' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='B' or a.FinalGrade = 'B-' or a.FinalGrade = 'B+')
Group by c.CourseName, l.FacultyName) i
Where cpg.Grade = 'B' and i.CourseName = cpg.CourseName and i.FacultyName = cpg.FacultyName;

Update CPG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, 'C' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='C' or a.FinalGrade = 'C-' or a.FinalGrade = 'C+')
Group by c.CourseName, l.FacultyName) i
Where cpg.Grade = 'A' and i.CourseName = cpg.CourseName and i.FacultyName = cpg.FacultyName;

Update CPG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, 'D' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='D' or a.FinalGrade = 'D-' or a.FinalGrade = 'D+')
Group by c.CourseName, l.FacultyName) i
Where cpg.Grade = 'D' and i.CourseName = cpg.CourseName and i.FacultyName = cpg.FacultyName;

Update CPG
Set GradeCount = i.GradeCount
From
(Select c.CourseName, l.FacultyName, 'Other' as Grade, Count(a.FinalGrade) as GradeCount
From Course c, CourseHasClass cc, Instructor l, Classes classes, AcademicHistory a
Where c.CourseName = cc.CourseName and cc.SectionID = l.SectionID 
and classes.SectionID = cc.SectionID and a.SectionID = l.SectionID and 
(a.FinalGrade ='F')
Group by c.CourseName, l.FacultyName) i
Where cpg.Grade = 'Other' and i.CourseName = cpg.CourseName and i.FacultyName = cpg.FacultyName;

-- Insert into AcademicHistory trigger
DROP Trigger IF EXISTS cpg_insert on AcademicHistory;
CREATE OR REPLACE FUNCTION cpg_insert_func() RETURNS TRIGGER AS $cpg_insert$
    BEGIN
	if (NEW.FinalGrade = 'A' or NEW.FinalGrade = 'A-' or NEW.FinalGrade = 'A+')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'A' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'B' or NEW.FinalGrade = 'B-' or NEW.FinalGrade = 'B+')
	then 
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'B' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'C' or NEW.FinalGrade = 'C-' or NEW.FinalGrade = 'C+')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'C' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'D' or NEW.FinalGrade = 'D-' or NEW.FinalGrade = 'D+')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'D' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
		RETURN NEW;
	ELSIF (NEW.FinalGrade = 'F')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'Other' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
		RETURN NEW;
	end if;
	END;
$cpg_insert$ LANGUAGE plpgsql;

CREATE TRIGGER cpg_insert After INSERT ON AcademicHistory
FOR EACH ROW EXECUTE PROCEDURE cpg_insert_func();
-- End of insert trigger

-- Begin of Update AcademicHistory Trigger

DROP Trigger IF EXISTS cpg_update on AcademicHistory;

CREATE OR REPLACE FUNCTION cpg_update_func() RETURNS TRIGGER AS $cpg_update$
    BEGIN
	If (OLD.FinalGrade = NEW.FinalGrade)
	then
		return NEW;
	end if;
	-- Decrement the old value	
	if (NEW.FinalGrade = 'A' or NEW.FinalGrade = 'A-' or NEW.FinalGrade = 'A+')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'A' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (NEW.FinalGrade = 'B' or NEW.FinalGrade = 'B-' or NEW.FinalGrade = 'B+')
	then 
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'B' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (NEW.FinalGrade = 'C' or NEW.FinalGrade = 'C-' or NEW.FinalGrade = 'C+')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'C' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (NEW.FinalGrade = 'D' or NEW.FinalGrade = 'D-' or NEW.FinalGrade = 'D+')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'D' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (NEW.FinalGrade = 'F')
	then
		Update CPG
		Set GradeCount = GradeCount + 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'Other' and cc.SectionID = NEW.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = NEW.SectionID and cpg.FacultyName = l.FacultyName;
	end if;

	if (OLD.FinalGrade = 'A' or OLD.FinalGrade = 'A-' or OLD.FinalGrade = 'A+')
	then
		Update CPG
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'A' and cc.SectionID = OLD.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpg.FacultyName = l.FacultyName;

	ELSIF (OLD.FinalGrade = 'B' or OLD.FinalGrade = 'B-' or OLD.FinalGrade = 'B+')
	then 
		Update CPG
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'B' and cc.SectionID = OLD.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (OLD.FinalGrade = 'C' or OLD.FinalGrade = 'C-' or OLD.FinalGrade = 'C+')
	then
		Update CPG
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'C' and cc.SectionID = OLD.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (OLD.FinalGrade = 'D' or OLD.FinalGrade = 'D-' or OLD.FinalGrade = 'D+')
	then
		Update CPG
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'D' and cc.SectionID = OLD.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpg.FacultyName = l.FacultyName;
	ELSIF (OLD.FinalGrade = 'F')
	then
		Update CPG
		Set GradeCount = GradeCount - 1
		FROM CourseHasClass cc, Instructor l
		Where cpg.Grade = 'Other' and cc.SectionID = OLD.SectionID and cpg.CourseName = cc.CourseName and
		l.SectionID = OLD.SectionID and cpg.FacultyName = l.FacultyName;
	end if;
	RETURN NEW;
	End;
$cpg_update$ LANGUAGE plpgsql;


CREATE TRIGGER cpg_update After Update ON AcademicHistory
FOR EACH ROW EXECUTE PROCEDURE cpg_update_func();


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
