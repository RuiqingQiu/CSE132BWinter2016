<html>
<head>
	<title>Department Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <table border="1" class="table table-bordered">
        <tr>
        	
        
            <td class="field-label col-xs-4 active">
                            <h4>Department Data Entry Form</h4>
                
            </td>
            <td class="col-md-8">

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
            				
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {
                		Department d = new Department(request.getParameter("DepartmentName"));

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Department VALUES (?)");
                        pstmt.setString(1, d.DepartmentName); 		
 						
 						// Commit transaction
 						int rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);

                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {
						/* There's no update method for department since department name is already the primary key
                        // Begin transaction
                         conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Department SET DepartmentName = ? WHERE Department = ?");

                        pstmt.setString(2, request.getParameter("SSN"));
                        pstmt.setString(1, request.getParameter("Name"));
                                         

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                        
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        pstmt = conn.prepareStatement(
                            "UPDATE Faculty SET SSN = ?, Name = ?, Title = ?");

                        pstmt.setString(1, request.getParameter("SSN"));
                        pstmt.setString(2, request.getParameter("Name"));
                        pstmt.setString(3, request.getParameter("Title"));                        
                                         

                       	rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                        */
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
                            "DELETE FROM Department WHERE DepartmentName = ?");

                        pstmt.setString(
                            1, request.getParameter("DepartmentName"));
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
                        ("SELECT * FROM Department");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>DepartmentName</th>
                    </tr>
                    <tr>
                        <form action="department.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input class="form-control input-lg" value="" name="DepartmentName" size="10"></th>
                            <th><input class="btn btn-default" type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    while ( rs.next() ) {
            %>

                    <tr>
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action="department.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN --%>
                            <td>
                                <input class="form-control input-lg" value="<%= rs.getString("DepartmentName") %>" 
                                    name="DepartmentName" size="10">
                            </td>
    
                             
                            <%-- Button --%>
                            <!--  No update button
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                            -->
                        </form>
                        
                        <form action="department.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getString("DepartmentName") %>" name="DepartmentName">
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
