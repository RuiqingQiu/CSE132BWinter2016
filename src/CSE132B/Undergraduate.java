package CSE132B;

import java.sql.*;

public class Undergraduate extends Student {
	public String College;
	public Undergraduate(String name, String SSN, String StudentID, 
						String ResidenceStatus, String AcademicLevel,
						String College){
		super(name, SSN, StudentID, ResidenceStatus, AcademicLevel);
		this.College = College;
	}
	
	public void insert(Connection conn) throws Exception{

		// Begin transaction
        conn.setAutoCommit(false);
        // Create the prepared statement and use it to
        // INSERT the student attributes INTO the Student table.
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO Person VALUES (?, ?)");
        pstmt.setString(1, this.Name);
		pstmt.setString(2, this.SSN);
			// Commit transaction
		int rowCount = pstmt.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
			
        //Then insert into the student table
        conn.setAutoCommit(false);
        pstmt = conn.prepareStatement(
            "INSERT INTO Student VALUES (?, ?, ?, ?, ?)");
		pstmt.setString(1, this.StudentID);
		pstmt.setString(2, this.Name);
		pstmt.setString(3, this.SSN);
		pstmt.setString(4, this.ResidenceStatus);
		pstmt.setString(5, this.AcademicLevel);

      	rowCount = pstmt.executeUpdate();

        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);
	}
}
