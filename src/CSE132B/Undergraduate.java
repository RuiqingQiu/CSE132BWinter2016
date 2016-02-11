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
		super.insert(conn);
		
        //Then insert into the student table
        conn.setAutoCommit(false);
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO Undergraduate VALUES (?, ?, ?, ?, ?, ?)");
		pstmt.setString(1, this.StudentID);
		pstmt.setString(2, this.Name);
		pstmt.setString(3, this.SSN);
		pstmt.setString(4, this.ResidenceStatus);
		pstmt.setString(5, this.AcademicLevel);
		pstmt.setString(6, this.College);


      	int rowCount = pstmt.executeUpdate();

        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);
	}
}
