package CSE132B;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Person {
	public String Name;
	public String SSN;
	
	//No default constructor
	
	public Person(String name, String SSN){
		this.Name = name;
		this.SSN = SSN;
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
	}
	
}
