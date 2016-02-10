<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <table border="1" class="table table-bordered">
        <tr>
            <td>
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="../form_html/student_menu.html" />
                
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="CSE132B.*" %>
            
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                	Class.forName("org.postgresql.Driver");
                	String url;
                	String user;
                	String password;
                	if(CSE132B.NUM == 1){
		               	//Mingshan Setup
		               	url = "jdbc:postgresql://127.0.0.1:5432/postgres";
		               	user = "postgres";
		               	password = "929kimbum";
					}
					else{
	                	url = "jdbc:postgresql://127.0.0.1:5433/postgres";
	                	user = "postgres";
	                	password = "qrq19931120";
					}
                	Connection conn = DriverManager.getConnection(url, user, password);
            %>

            <%-- -------- INSERT Code -------- --%>
            <%
            		// request is a implicit object
                    String action = request.getParameter("action");
            		Student s = new Student(request.getParameter("Name"), request.getParameter("SSN"),
            							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
            							request.getParameter("AcademicLevel")
            				);
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Person VALUES (?, ?)");
                        pstmt.setString(1, s.Name);
 						pstmt.setString(2, s.SSN);
 						// Commit transaction
 						int rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
 						
                        //Then insert into the student table
                        conn.setAutoCommit(false);
                        pstmt = conn.prepareStatement(
                            "INSERT INTO Student VALUES (?, ?, ?, ?, ?)");
						pstmt.setString(1, s.StudentID);
						pstmt.setString(2, s.Name);
						pstmt.setString(3, s.SSN);
						pstmt.setString(4, s.ResidenceStatus);
						pstmt.setString(5, s.AcademicLevel);

			          	rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Student SET Name = ?, SSN = ?, ResidenceStatus = ?, AcademicLevel = ? WHERE StudentID = ?");

                  
                        pstmt.setString(1, request.getParameter("Name"));
                        pstmt.setString(2, request.getParameter("SSN"));
                        pstmt.setString(3, request.getParameter("ResidenceStatus"));                        
                        pstmt.setString(4, request.getParameter("AcademicLevel"));                        
                        pstmt.setString(5, request.getParameter("StudentID"));                        

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE StudentID = ?");

                        pstmt.setString(
                            1, request.getParameter("StudentID"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>Name</th>
                        <th>SSN</th>
                     	<th>StudentID</th>
                        <th>ResidenceStatus</th>
                        <th>AcademicLevel</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="Name" size="10"></th>
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="StudentID" size="10"></th>
                            <th><input value="" name="ResidenceStatus" size="10"></th>
                            <th><input value="" name="AcademicLevel" size="10"></th>
                            
                            <th><input class="btn btn-default" type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="person.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the Name --%>
                            <td>
                                <input value="<%= rs.getString("Name") %>" 
                                    name="Name" size="10">
                            </td>
    
                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
                            
                            <%-- Get the StudentID --%>
                            <td>
                                <input value="<%= rs.getString("StudentID") %>" 
                                    name="StudentID" size="10">
                            </td>
                            
                            <%-- Get the ResidenceStatus --%>
                            <td>
                                <input value="<%= rs.getString("ResidenceStatus") %>" 
                                    name="ResidenceStatus" size="10">
                            </td>
                            
                            <%-- Get the AcademicLevel --%>
                            <td>
                                <input value="<%= rs.getString("AcademicLevel") %>" 
                                    name="AcademicLevel" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("StudentID") %>" name="StudentID">
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
