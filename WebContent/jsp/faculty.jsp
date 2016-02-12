<html>
<head>
	<title>Faculty Entry Form</title>
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
	<h2>Faculty Entry Form</h2>

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
                    	Faculty f = new Faculty(request.getParameter("Name"), request.getParameter("SSN"),
    							request.getParameter("Title"));
                    	f.insert(conn);
                    	// Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO FacultyDepartment (FacultyName, DepartmentName) VALUES (?, ?)");
                        pstmt.setString(1, f.Name); 
                        pstmt.setString(2, request.getParameter("DepartmentName")); 		

 						
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

                        // Begin transaction
                         conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Faculty SET Title = ? WHERE Name = ?");

                        pstmt.setString(1, request.getParameter("Title"));
                        pstmt.setString(2, request.getParameter("Name"));
                                         

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                        
                     // Begin transaction
                        conn.setAutoCommit(false);
                       
                       // Create the prepared statement and use it to
                       // UPDATE the student attributes in the Student table.
                       pstmt = conn.prepareStatement(
                           "UPDATE FacultyDepartment SET DepartmentName = ?, FacultyName = ? WHERE FD_ID = ?");

                       pstmt.setString(1, request.getParameter("DepartmentName"));
                       pstmt.setString(2, request.getParameter("Name"));
                       pstmt.setInt(3, Integer.parseInt(request.getParameter("FD_ID")));

                                        

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
                            "DELETE FROM Faculty WHERE Name = ?");

                        pstmt.setString(
                            1, request.getParameter("Name"));
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
                     	<th>Department</th>
                    </tr>
                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="Name" size="10"></th>
                            <th><input value="" name="Title" size="10"></th>
                            <th>
                            <%
							Statement departmentStatement = conn.createStatement();
							ResultSet rs_department = departmentStatement.executeQuery
									("SELECT * FROM Department");
							%>
			                <select name="DepartmentName">
			            	
			            	<%
			            		// if there is no entry in the Department table
								if (!rs_department.isBeforeFirst() ) {    
							%>
								<option value="no department" name="DepartmentName" > There are no departments </option>
							<% 
							}
							else{
							%>
								
								<option value="" ></option>
							<% 	
								while(rs_department.next()){
							%>	
							<option value="<%= rs_department.getString("DepartmentName") %>" name="DepartmentName" > <%= rs_department.getString("DepartmentName") %> </option>
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
                            
                            <td>
                            <select name="DepartmentName">
            	
            					<%
            						Statement department_Statement = conn.createStatement();
                        			rs_department = department_Statement.executeQuery("SELECT * FROM Department");
                        			
                        			PreparedStatement ps = null;
                               	  	String sql = "SELECT * FROM FacultyDepartment WHERE FacultyName = ?";
                               	  
                               	  	ps = conn.prepareStatement(sql);
                               	  	ps.setString(1, rs.getString("Name")); 
                               	  	ResultSet rs_year = ps.executeQuery();
									int ID = -1;

                                    if(!rs_year.isBeforeFirst()){
                                   	   System.out.println("selection failed");
                                    }else{
                                   	   //System.out.println("selection success");
                                    }      
                            		while (rs_year.next() ) {
										// if there is no entry in the Department table
										if (!rs_department.isBeforeFirst() ) {    
									%>
												<option value="no department" name="DepartmentName" > There are no departments </option>
									<% 
										}
										else{
											
											while(rs_department.next()){
	
												if(rs_department.getString("DepartmentName").equals(rs_year.getString("DepartmentName"))){
									%>
									<option value="<%= rs_department.getString("DepartmentName") %>" name="DepartmentName" selected> <%= rs_department.getString("DepartmentName") %> </option>
									<% 			
													ID = rs_year.getInt("FD_ID");
												}
												else{
													%>
													<option value="<%= rs_department.getString("DepartmentName") %>" name="DepartmentName" > <%= rs_department.getString("DepartmentName") %> </option>
													<%
												}
											} // close of while loop
										}// close of else statement
                            		}
								%>
								</select>
                            </td>
                             	<input type="hidden" value="<%= ID %>" name="FD_ID">
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getString("Name") %>" name="Name">
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
