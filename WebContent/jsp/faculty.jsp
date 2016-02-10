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
                <jsp:include page="../html/faculty_menu.html" />
                
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
            		Faculty s = new Faculty(request.getParameter("Name"), request.getParameter("SSN"),
            							request.getParameter("Title"));
            				
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
                            "INSERT INTO Faculty VALUES (?, ?, ?)");
						pstmt.setString(1, s.SSN);
						pstmt.setString(2, s.Name);
						pstmt.setString(3, s.Title);

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
                            "UPDATE Person SET Name = ? WHERE SSN = ?");

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
                            "DELETE FROM Faculty WHERE SSN = ?");

                        pstmt.setString(
                            1, request.getParameter("SSN"));
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
                        ("SELECT * FROM Faculty");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>SSN</th>
                        <th>Name</th>
                     	<th>Title</th>
                    </tr>
                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="Name" size="10"></th>
                            <th><input value="" name="Title" size="10"></th> 
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
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
    
                            <%-- Get the Name --%>
                            <td>
                                <input value="<%= rs.getString("Name") %>" 
                                    name="Name" size="10">
                            </td>
                            
                            <%-- Get the Title --%>
                            <td>
                                <input value="<%= rs.getString("Title") %>" 
                                    name="Title" size="10">
                            </td>
                             
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getString("SSN") %>" name="SSN">
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
                    
                    <%-- need to update person table if name/ssn changes --%>
                    <%-- <tr>
                            <form action="person.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            Get the SSN
                            <td>
                                <input value="<%= rs.getString("SSN") %>" 
                                    name="SSN" size="10">
                            </td>
    
                            Get the Name
                            <td>
                                <input value="<%= rs.getString("Name") %>" 
                                    name="Name" size="10">
                            </td>
                           	</form>
                    </tr>  --%>
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
