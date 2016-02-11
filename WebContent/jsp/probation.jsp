<!DOCTYPE html>
<html>
<head>
	<title>Probation Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <table border="1" class="table table-bordered">
        <tr>
            <td>
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="../form_html/probation_menu.html" />
               
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
                	//Ruiqing Setup
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
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Probation(StudentID, StartTime, EndTime) VALUES (?, ?, ?)");
						pstmt.setString(1, request.getParameter("StudentID"));
						pstmt.setString(2, request.getParameter("StartTime"));
						pstmt.setString(3, request.getParameter("EndTime"));

                        int rowCount = pstmt.executeUpdate();

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
                            "UPDATE Probation SET StudentID = ?, StartTime = ?, EndTime = ?  WHERE ProbationID = ?");

                        pstmt.setString(1, request.getParameter("StudentID"));
						pstmt.setString(2, request.getParameter("StartTime"));
						pstmt.setString(3, request.getParameter("EndTime")); 
						pstmt.setInt(4, Integer.parseInt(request.getParameter("ProbationID"))); 
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
                            "DELETE FROM Probation WHERE Probation = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ProbationID")));
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
                        ("SELECT * FROM Probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>ProbationID</th>
                        <th>StudentID</th>
                     	<th>StartTime</th>
                     	<th>EndTime</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th></th>
                            <th><input value="" name="StudentID" size="10"></th>
                            <th><input value="" type="date" name="StartTime" size="10"></th>
                            <th><input value="" type="date" name="EndTime" size="10"></th>
                            
                            <th><input class="btn btn-default" type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the Name --%>
                            <td>
                                <input type="hidden" value="<%= rs.getInt("ProbationID") %>" 
                                    name="ProbationID" size="10">
                                 <%= rs.getInt("ProbationID") %> 
                            </td>
    
                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("StudentID") %>" 
                                    name="StudentID" size="10">
                            </td>
							<td>
                                <input value="<%= rs.getString("StartTime") %>" 
                                    name="StartTime" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("EndTime") %>" 
                                    name="EndTime" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("ProbationID") %>" name="ProbationID">
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
