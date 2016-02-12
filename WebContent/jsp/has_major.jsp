<html>
<head>
	<title>Major Form</title>
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
	<h2>Major Form</h2>

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
                            "INSERT INTO HasMajor VALUES (?, ?)");
                        pstmt.setString(1, request.getParameter("StudentID")); 
                        pstmt.setString(2, request.getParameter("MajorName")); 		

 						
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
                            "DELETE FROM HasMajor WHERE StudentID = ? and MajorName = ?");

                        pstmt.setString(1, request.getParameter("StudentID")); 
                        pstmt.setString(2, request.getParameter("MajorName")); 		

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>StudentID</th>
                        <th>Major</th>
                    </tr>
                    <tr>
                        <form action="has_major.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="StudentID" size="10"></th>
                            <th>
                            <%
							Statement departmentStatement = conn.createStatement();
							ResultSet rs_department = departmentStatement.executeQuery
									("SELECT * FROM Major");
							%>
			                <select name="MajorName">
			            	
			            	<%
			            		// if there is no entry in the Department table
								if (!rs_department.isBeforeFirst() ) {    
							%>
								<option value="no major" name="MajorName" > There are no majors </option>
							<% 
							}
							else{
							%>
								
								<option value="" ></option>
							<% 	
								while(rs_department.next()){
							%>	
							<option value="<%= rs_department.getString("MajorName") %>" name="MajorName" > <%= rs_department.getString("MajorName") %> </option>
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
                        ("SELECT * FROM HasMajor");
                    while (rs.next() ) {
            %>

                    <tr>
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action=""has_major.jsp" method="get">
                            <input type="hidden" value="delete" name="action">

                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("StudentID") %>" 
                                    name="StudentID" size="10">
                            </td>
    
                            <td>
                            	<select name="MajorName">
            	
            					<%
            						Statement department_Statement = conn.createStatement();
                        			rs_department = department_Statement.executeQuery("SELECT * FROM Major");
                        			
  
                            		while (rs_department.next() ) {
											if(rs_department.getString("MajorName").equals(rs.getString("MajorName"))){
									%>
									<option value="<%= rs_department.getString("MajorName") %>" name="MajorName" selected> <%= rs_department.getString("MajorName") %> </option>
									<% 			
											}
											else{
									%>
									<option value="<%= rs_department.getString("MajorName") %>" name="MajorName" > <%= rs_department.getString("MajorName") %> </option>
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
