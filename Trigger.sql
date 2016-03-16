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
					DELETE from WeeklyMeeting WHERE MeetingID = NEW.MeetingID;
					Raise Exception 'time conflict';
				
				end if;
     end if;
	END LOOP;
	RETURN NEW;
    END;
$time_conflict_check$ LANGUAGE plpgsql;

-- check for irregular meetings(extra credit attempt)

DROP Trigger IF EXISTS irregular_meeting_trigger on ClassMeeting;

CREATE OR REPLACE FUNCTION irregular_meeting_check() RETURNS TRIGGER AS $irregular_time_conflict_check$
DECLARE t RECORD;
    BEGIN
    FOR t in SELECT * from ClassReview WHERE SectionID = NEW.SectionID
    LOOP
    if ((Select Time from ReviewSession r WHERE r.ReviewID = t.ReviewID) = 
	(Select Time from WeeklyMeeting WHERE MeetingID = NEW.MeetingID))
        then
		if ((Select DayOfTheWeek from WeeklyMeeting WHERE MeetingID = NEW.MeetingID) LIKE concat('%',(Select DayOfTheWeek from ReviewSession WHERE ReviewID = t.ReviewID),'%',NULL))
				then
					DELETE from WeeklyMeeting WHERE MeetingID = NEW.MeetingID;
					Raise Exception 'time conflict';
		end if;
     end if;
     END LOOP;
	RETURN NEW;
    END;
$irregular_time_conflict_check$ LANGUAGE plpgsql;

CREATE TRIGGER time_conflict_trigger Before INSERT ON ClassMeeting
FOR EACH ROW EXECUTE PROCEDURE time_conflict_check();
CREATE TRIGGER irregular_meeting_trigger Before INSERT ON ClassMeeting
FOR EACH ROW EXECUTE PROCEDURE irregular_meeting_check();

-- enter final or review sessions
DROP Trigger IF EXISTS insert_irregular_meeting_trigger on ClassReview;

CREATE OR REPLACE FUNCTION insert_irregular_meeting_check() RETURNS TRIGGER AS $insert_irregular_time_conflict_check$
DECLARE t RECORD;
    BEGIN
    FOR t in SELECT * from ClassReview WHERE SectionID = NEW.SectionID
    LOOP
    if ((Select Time from ReviewSession r WHERE r.ReviewID = t.ReviewID AND r.ReviewID <> New.ReviewID) = 
	(Select Time from ReviewSession WHERE ReviewID = NEW.ReviewID))
        then
		if ((Select DayOfTheWeek from ReviewSession WHERE ReviewID = NEW.ReviewID) LIKE concat('%',(Select DayOfTheWeek from ReviewSession WHERE ReviewID = t.ReviewID),'%',NULL))
		then
		      if ((Select Date from ReviewSession v WHERE v.ReviewID = t.ReviewID AND v.ReviewID <> New.ReviewID) = 
			     (Select Date from ReviewSession WHERE ReviewID = NEW.ReviewID))
		      then
			DELETE from ReviewSession WHERE ReviewID = NEW.ReviewID;
			Raise Exception 'time conflict';
		       end if;
		end if;
     end if;
     END LOOP;
	RETURN NEW;
    END;
$insert_irregular_time_conflict_check$ LANGUAGE plpgsql;

-- check insert irregular meeting against normal meeting
DROP Trigger IF EXISTS insert_irregular_meeting_aginst_normal_meeting_trigger on ClassReview;

CREATE OR REPLACE FUNCTION insert_irregular_meeting_check_against_normal_meeting() RETURNS TRIGGER AS $insert_irregular_meeting_check_against_normal_meeting_check$
DECLARE t RECORD;
DECLARE tt RECORD;
    BEGIN
    FOR t in SELECT * from ClassReview WHERE SectionID = NEW.SectionID
    LOOP
	FOR tt in SELECT * from ClassMeeting WHERE SectionID = NEW.SectionID
	LOOP
		if ((Select Time from ReviewSession r WHERE r.ReviewID = t.ReviewID AND r.ReviewID <> New.ReviewID) = 
			(Select w.Time from WeeklyMeeting w WHERE w.MeetingID = tt.MeetingID))
		then
			if ((Select DayOfTheWeek from ReviewSession WHERE ReviewID = NEW.ReviewID AND r.ReviewID <> New.ReviewID) LIKE concat('%',(Select DayOfTheWeek from WeeklyMeeting WHERE MeetingID = tt.MeetingID),'%',NULL))
			then
				DELETE from ReviewSession WHERE ReviewID = NEW.ReviewID;
				Raise Exception 'time conflict';
		       end if;
		end if;
	END LOOP;
     END LOOP;
	RETURN NEW;
    END;
$insert_irregular_meeting_check_against_normal_meeting_check$ LANGUAGE plpgsql;

CREATE TRIGGER insert_irregular_meeting_trigger Before INSERT ON ClassReview
FOR EACH ROW EXECUTE PROCEDURE insert_irregular_meeting_check();
CREATE TRIGGER insert_irregular_meeting_aginst_normal_meeting_trigger Before INSERT ON ClassReview
FOR EACH ROW EXECUTE PROCEDURE insert_irregular_meeting_check_against_normal_meeting();


--INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES(23,'Lec','WLH 2001',false,'M','8:00AM');
--INSERT INTO ClassMeeting VALUES (1,23);

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
--INSERT INTO Instructor VALUES(2,'Taylor Swift');
