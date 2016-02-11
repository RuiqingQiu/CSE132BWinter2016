package CSE132B;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Faculty extends Person{
	public String Title;
	public Faculty(String Name, String SSN, String Title){
		super(Name, SSN);
		this.Title = Title;
	}
	
	public void insert(Connection conn) throws Exception{
		super.insert(conn);
        //Then insert into the student table
        conn.setAutoCommit(false);
        PreparedStatement pstmt = conn.prepareStatement(
            "INSERT INTO Faculty VALUES (?, ?, ?)");
		pstmt.setString(1, this.SSN);
		pstmt.setString(2, this.Name);
		pstmt.setString(3, this.Title);

      	int rowCount = pstmt.executeUpdate();

        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);
	}
}
