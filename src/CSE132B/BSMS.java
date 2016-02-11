package CSE132B;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BSMS extends Undergraduate {
	public String ExpectedGraduateDate;
	public BSMS(String name, String SSN, String StudentID, 
			String ResidenceStatus, String AcademicLevel,
			String College, String ExpectedGraduateDate){
		super(name, SSN, StudentID, ResidenceStatus, AcademicLevel,College);
		this.ExpectedGraduateDate = ExpectedGraduateDate;
	}
	
	public void insert(Connection conn) throws Exception{
		super.insert(conn);
		// Begin transaction
        conn.setAutoCommit(false);
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO BSMS VALUES (?, ?, ?, ?, ?, ?, ?)");
		pstmt.setString(1, this.StudentID);
		pstmt.setString(2, this.Name);
		pstmt.setString(3, this.SSN);
		pstmt.setString(4, this.ResidenceStatus);
		pstmt.setString(5, this.AcademicLevel);
		pstmt.setString(6, this.College);
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(this.ExpectedGraduateDate);
		pstmt.setDate(7, new java.sql.Date(date.getTime()));

		// Commit transaction
		int rowCount = pstmt.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
	}
}
