<html>
<head>
	<title>PhD Advisor Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="../index.html">CSE 132B</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="course.jsp">Course</a></li>
        <li><a href="classes.jsp">Class</a></li>
        <li><a href="student.jsp">Student</a></li>
        <li><a href="faculty.jsp">Faculty</a></li>
        <li><a href="course_enrollment.jsp">Enrollment</a></li>
        <li><a href="academic_history.jsp">Classes taken</a></li>
        <li><a href="thesis_committee.jsp">Thesis Committee</a></li>
        <li><a href="probation.jsp">Probation</a></li>
        <li><a href="review_session.jsp">Review</a></li>
        <li><a href="degree_requirement.jsp">Degree</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>PhD Advisor Form</h2>

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

                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO PhD_Advisor VALUES (?, ?)");
                        pstmt.setString(1, request.getParameter("StudentID")); 
                        pstmt.setString(2, request.getParameter("FacultyName")); 		
 						
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
                            "DELETE FROM PhD_Advisor WHERE StudentID = ? and FacultyName = ?");

                        pstmt.setString(1, request.getParameter("StudentID")); 
                        pstmt.setString(2, request.getParameter("FacultyName")); 		

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>Faculty Name</th>
                        <th>StudentID</th>
                    </tr>
                    <tr>
                        <form action="phd_advisor.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th>
                            <%
							Statement departmentStatement = conn.createStatement();
							ResultSet rs_department = departmentStatement.executeQuery
									("SELECT * FROM Faculty");
							%>
			                <select name="FacultyName">
			            	
			            	<%
			            		// if there is no entry in the Department table
								if (!rs_department.isBeforeFirst() ) {    
							%>
								<option value="no faculty" name="FacultyName" > There are no faculty </option>
							<% 
							}
							else{
							%>
								
								<option value="" ></option>
							<% 	
								while(rs_department.next()){
							%>	
							<option value="<%= rs_department.getString("Name") %>" name="Name" > <%= rs_department.getString("Name") %> </option>
			            	<%
								} // close of while loop
							}// close of else statement
							%>
							</select>
                            
                            </th>
                            <th>
                            <%
							departmentStatement = conn.createStatement();
							rs_department = departmentStatement.executeQuery
									("SELECT * FROM PhD");
							%>
			                <select name="StudentID">
			            	
			            	<%
			            		// if there is no entry in the Department table
								if (!rs_department.isBeforeFirst() ) {    
							%>
								<option value="no studentid" name="StudentID" > There are no phd students </option>
							<% 
							}
							else{
							%>
								
								<option value="" ></option>
							<% 	
								while(rs_department.next()){
							%>	
							<option value="<%= rs_department.getString("StudentID") %>" name="StudentID" > <%= rs_department.getString("StudentID") %> </option>
			            	<%
								} // close of while loop
							}// close of else statement
							%>
							</select>
                            </th> 
                            <th><input class="btn btn-default" type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                     // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM PhD_Advisor");
                    while (rs.next() ) {
            %>

                    <tr>
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action="phd_advisor.jsp" method="get">
                            <input type="hidden" value="delete" name="action">

                            <%-- Get the SSN --%>
                            <td>
                                <select name="FacultyName">
            	
            					<%
            						Statement department_Statement = conn.createStatement();
                        			rs_department = department_Statement.executeQuery("SELECT * FROM Faculty");
                        			
  
                            		while (rs_department.next() ) {
											if(rs_department.getString("Name").equals(rs.getString("FacultyName"))){
									%>
									<option value="<%= rs_department.getString("Name") %>" name="Name" selected> <%= rs_department.getString("Name") %> </option>
									<% 			
											}
											else{
									%>
									<option value="<%= rs_department.getString("Name") %>" name="Name" > <%= rs_department.getString("Name") %> </option>
									<%
											}
									} // close of while loop
                        
								%>
                            </td>
    
                            <td>
                            	<select name="StudentID">
            	
            					<%
            						department_Statement = conn.createStatement();
                        			rs_department = department_Statement.executeQuery("SELECT * FROM PhD");
                        			
  
                            		while (rs_department.next() ) {
											if(rs_department.getString("StudentID").equals(rs.getString("StudentID"))){
									%>
									<option value="<%= rs_department.getString("StudentID") %>" name="StudentID" selected> <%= rs_department.getString("StudentID") %> </option>
									<% 			
											}
											else{
									%>
									<option value="<%= rs_department.getString("StudentID") %>" name="StudentID" > <%= rs_department.getString("StudentID") %> </option>
									<%
											}
									} // close of while loop
                        
								%>
								</select>
                            </td>
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
</body>

</html>
