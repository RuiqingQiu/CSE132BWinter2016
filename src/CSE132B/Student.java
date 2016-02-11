package CSE132B;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Student extends Person {
	public String StudentID;
	public String ResidenceStatus;
	public String AcademicLevel;
	
	public Student(String name, String SSN, String StudentID, String ResidenceStatus, String AcademicLevel){
		super(name, SSN);
		this.StudentID = StudentID;
		this.ResidenceStatus = ResidenceStatus;
		this.AcademicLevel = AcademicLevel;
	}
	public void insert(Connection conn) throws Exception{
		super.insert(conn);
		// Begin transaction
        conn.setAutoCommit(false);
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO Student VALUES (?, ?, ?, ?, ?)");
		pstmt.setString(1, this.StudentID);
		pstmt.setString(2, this.Name);
		pstmt.setString(3, this.SSN);
		pstmt.setString(4, this.ResidenceStatus);
		pstmt.setString(5, this.AcademicLevel);
		// Commit transaction
		int rowCount = pstmt.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
	}
}
