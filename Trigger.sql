-- The lectures ('LE'), discussions('DI') and lab('LAB') meetings of a section should not happen at the same time.
DROP Trigger IF EXISTS time_conflict_trigger on ClassMeeting;

CREATE OR REPLACE FUNCTION time_conflict_check() RETURNS TRIGGER AS $time_conflict_check$
DECLARE t RECORD;
    BEGIN
    FOR t in SELECT * from ClassMeeting WHERE SectionID = NEW.SectionID
    LOOP
    if ((Select Time from WeeklyMeeting WHERE MeetingID = t.MeetingID AND MeetingID <> NEW.MeetingID) = 
	(Select Time from WeeklyMeeting WHERE MeetingID = NEW.MeetingID ))
        then
		if ((Select DayOfTheWeek from WeeklyMeeting WHERE MeetingID = t.MeetingID AND MeetingID <> NEW.MeetingID) LIKE concat('%',(Select DayOfTheWeek from WeeklyMeeting WHERE MeetingID = New.MeetingID),'%',NULL))
				then
					Raise Exception 'time conflict';
				
				end if;
     end if;
	END LOOP;
	RETURN NEW;
    END;
$time_conflict_check$ LANGUAGE plpgsql;

CREATE TRIGGER time_conflict_trigger Before INSERT ON ClassMeeting
FOR EACH ROW EXECUTE PROCEDURE time_conflict_check();

/*
INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(30,'Lec','WLH 2001',false,'F','10:00AM');
INSERT INTO ClassMeeting VALUES (2,30);
*/

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
DROP Trigger IF EXISTS professor_time_conflict_trigger on Instructor;

CREATE OR REPLACE FUNCTION professor_time_conflict_check() RETURNS TRIGGER AS $professor_time_conflict_check$
DECLARE t RECORD;
DECLARE tt RECORD;
    BEGIN
    FOR t in SELECT c.MeetingID from Instructor i,ClassMeeting c WHERE i.FacultyName = NEW.FacultyName AND i.SectionID = c.SectionID
    LOOP
	FOR tt in SELECT c.MeetingID from ClassMeeting c WHERE c.SectionID = NEW.SectionID 
	LOOP
		if ((Select Time from WeeklyMeeting WHERE MeetingID = t.MeetingID) = 
		 (Select Time from WeeklyMeeting WHERE MeetingID = tt.MeetingID ))
		then
			if ((Select DayOfTheWeek from WeeklyMeeting WHERE MeetingID = t.MeetingID) LIKE concat('%',(Select DayOfTheWeek from WeeklyMeeting WHERE MeetingID = tt.MeetingID),'%',NULL))
				then
					Raise Exception 'time conflict';
			end if;
		end if;
	END LOOP;
    END LOOP;
	RETURN NEW;
    END;
$professor_time_conflict_check$ LANGUAGE plpgsql;

CREATE TRIGGER professor_time_conflict_trigger Before INSERT ON Instructor
FOR EACH ROW EXECUTE PROCEDURE professor_time_conflict_check();
INSERT INTO Instructor VALUES(2,'Taylor Swift');
