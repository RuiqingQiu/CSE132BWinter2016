-- The lectures ('LE'), discussions('DI') and lab('LAB') meetings of a section should not happen at the same time.


-- If the enrollment limit of a section has been reached then additional enrollments should be rejected. 
-- It is not required to update the waitlist .
DROP Trigger IF EXISTS enrollment_trigger on StudentEnrollment;

CREATE OR REPLACE FUNCTION enrollment_limit_check() RETURNS TRIGGER AS $enrollment_check$
    BEGIN
        if (Select count(*) From StudentEnrollment  Where SectionID = NEW.SectionID) >= (Select MaxEnrollment From Classes Where SectionID = NEW.SectionID)
        then
		Raise Exception 'Enrollment Error Reached Maximum Enrollment Limit';
        end if;
	RETURN NEW;
    END;
$enrollment_check$ LANGUAGE plpgsql;

CREATE TRIGGER enrollment_trigger Before INSERT ON StudentEnrollment
FOR EACH ROW EXECUTE PROCEDURE enrollment_limit_check();


-- A professor should not have multiple sections at the same time. For example, a professor that is scheduled to teach classes X and Y 
-- should not have conflicting sections, mainly overlapping meetings. It is enough to check for the regular meetings (e.g., "LE"). 
-- Extra credit is given for checking conflicts on the irregular meetings too.

DROP Trigger IF EXISTS instructor_trigger on Instructor;

CREATE OR REPLACE FUNCTION instructor_trigger_check() RETURNS TRIGGER AS $instructor_trigger$
    BEGIN
        if (Select count(*) From StudentEnrollment  Where SectionID = NEW.SectionID) >= (Select MaxEnrollment From Classes Where SectionID = NEW.SectionID)
        then
		Raise Exception 'Instructor has time conflict with this section';
        end if;
	RETURN NEW;
    END;
$instructor_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER instructor_trigger Before INSERT ON Instructor
FOR EACH ROW EXECUTE PROCEDURE enrollment_limit_check();
