<html>
<head>
	<title>Course Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://code.getmdl.io/1.1.1/material.indigo-pink.min.css">
	<script defer src="https://code.getmdl.io/1.1.1/material.min.js"></script>
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
	<h3>Course Entry Form</h3>
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
                	   Course c = new Course(
                  				request.getParameter("CourseName"),
                  				request.getParameter("DepartmentName"), 
                  				Integer.parseInt(request.getParameter("MaxUnits")), 
                  				Integer.parseInt(request.getParameter("MinUnits")),
                  				request.getParameter("RequireLabWorks"),
                   				request.getParameter("GradeOption"),
                   				request.getParameter("RequireConsentOfInstructor"));
                	
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Course VALUES (?, ?, ?, ?, ?, ?, ?)");
						
                        pstmt.setString(1, c.CourseName);
						pstmt.setString(2, c.DepartmentName);
						pstmt.setInt(3, c.MaxUnits);
						pstmt.setInt(4,c.MinUnits);
						
						// by default user enter 0 or 1
						if(c.RequireLabWorks.equals("Yes")){
							pstmt.setBoolean(5,true);
						}else{
							pstmt.setBoolean(5,false);
						}
						
						pstmt.setString(6,c.GradeOption);
						
						if(c.RequireConsentOfInstructor.equals("Yes")){
							pstmt.setBoolean(7,true);
						}else{
							pstmt.setBoolean(7,false);
						}
						
                        int rowCount = pstmt.executeUpdate();
                     	// seperate form to enter prereq
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
                            "UPDATE Course SET DepartmentName = ?, MaxUnits = ?, MinUnits = ?, RequireLabWorks = ?, GradeOption = ?, RequireConsentOfInstructor = ? WHERE CourseName = ?");

                        pstmt.setString(1, request.getParameter("DepartmentName"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MaxUnits")));  
                        pstmt.setInt(3,Integer.parseInt(request.getParameter("MinUnits")));
                        
                        if(request.getParameter("RequireLabWorks").equals("Yes")){
                        	pstmt.setBoolean(4,true);
                        }else{
                        	pstmt.setBoolean(4,false);
                        }
                   
                        pstmt.setString(5,request.getParameter("GradeOption"));
                      
                        if(request.getParameter("RequireConsentOfInstructor").equals("Yes")){
                        	pstmt.setBoolean(6,true);
                        }else{
                        	pstmt.setBoolean(6,false);
                        }
                        
                  
                        pstmt.setString(7,request.getParameter("CourseName"));                        
                        
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
                            "DELETE FROM Course WHERE CourseName = ?");

                        pstmt.setString(
                            1, request.getParameter("CourseName"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    } 
            %>
            
            <%-- Find out all the department available --%>
			<%
				Statement departmentStatement = conn.createStatement();
				ResultSet rs_department = departmentStatement.executeQuery
						("SELECT * FROM Department");
			%>
            
            <!-- Make the input box vertically listed -->
            <form action="course.jsp" method="get">
				<input type="hidden" value="insert" name="action">            	
            	<label>Course Name: </label><input value="" name="CourseName" size="10"><br>
            	
            	<!-- Create a drop down for all department -->
            	<label>Department Name: </label><select name="DepartmentName">
            	
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
				</select><br>
			
            	<label>MaxUnits: </label><input value="" name="MaxUnits" size="10"><br>
            	<label>MinUnits: </label><input value="" name="MinUnits" size="10"><br>
            	
            	<label>RequireLabWorks: </label>
            	<select name="RequireLabWorks"> 
            		<option value="" ></option>
  					<option value="Yes" >Yes</option>
  					<option value="No" >No</option>	
				</select><br>
            	
            	<label>GradeOption: </label>
            	<select name="GradeOption">
            		<option value=""></option>
            		<option value="Letter Grade Only">Letter Grade Only</option>
            		<option value="Pass/No pass Only">Pass/No pass only</option>
            		<option value="Letter Grade & Pass/No pass">Letter Grade & Pass/No pass</option>
            	</select><br>
            	
            	<label>RequireConsentOfInstructor: </label>
            	<select name="RequireConsentOfInstructor">
            		<option value=""></option>
            		<option value="Yes">Yes</option>
            		<option value="No">No</option>
            	</select><br>
<<<<<<< HEAD
=======
            	
>>>>>>> b112f64a33a1af669da98ec91083d9493fc069cb
            	<input class="btn btn-default" type="submit" value="Insert">
            
            </form>
			</div>
            <!-- Add an HTML table header row to format the results -->
                
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>CourseName</th>
                        <th>DepartmentName</th>
                        <th>Prereq</th>
                        <th>MaxUnits</th>
                        <th>MinUnits</th>
                        <th>RequireLabWorks</th>
                        <th>GradeOptions</th>
                        <th>RequireConsentOfInstructors</th>
						<th>Action</th>
                    </tr>
      
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                 // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                 // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Course"); 
        
                    while ( rs.next() ) {
            %>
                  <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the CourseName --%>
                            <td>
              				 	<input type="hidden" value="<%= rs.getString("CourseName") %>" name="CourseName" size="10">
                                <%= rs.getString("CourseName") %>
                            </td> 
    
    						<%
    							// reselect from the department table
								departmentStatement = conn.createStatement();
								rs_department = departmentStatement.executeQuery
										    ("SELECT * FROM Department");
							%>
                           <%-- Get the Department --%>
                            <td>
                            	<select name="DepartmentName">
            	
            					<%
            						// if there is no entry in the Department table
									if (!rs_department.isBeforeFirst() ) {    
								%>
											<option value="no department" name="DepartmentName" > There are no departments </option>
								<% 
									}
								else{
		
										while(rs_department.next()){
											if(rs_department.getString("DepartmentName").equals(rs.getString("DepartmentName"))){
								%>
											<option value="<%= rs_department.getString("DepartmentName") %>"> <%= rs_department.getString("DepartmentName") %> </option>
								<% 
											}
											else{
								%>
								<option value="<%= rs_department.getString("DepartmentName") %>" > <%= rs_department.getString("DepartmentName") %> </option>
								<%
											}
								%>										
            	<%
					} // close of while loop
				}// close of else statement
				%>
				</select>
                     
                            </td> 
                            
                            <td>
                            	<!--  Get the prereq for the course -->
    							<%
    								PreparedStatement ps = null;
                   	  				String sql = "SELECT * FROM Prereq WHERE CourseName = ?";
                   	  
                   	  				ps = conn.prepareStatement(sql);
                   	  				ps.setString(1, rs.getString("CourseName"));
                 		   
                   	  				// retrieve all the valid meetingID for that seciondID
                   	  				ResultSet rs_prereq = ps.executeQuery();
                   	  						
                   	  				if(!rs_prereq.isBeforeFirst()){
								%>
									<option value="No prereq for this course" name="Prereq" > There are no prereq entered for this course </option>
								
                            	<!--  Each course will be a selection -->
            					<%
                   	  				}else{
                   	  					
										while(rs_prereq.next()){	
								%>
										 <input value="<%= rs_prereq.getString("PrereqCourseName") %>" 
                                    name="Prereq" size="10">
								<%
										}// end of else no more elements in result set
                   	  				}// end of else not empty prereq sets
								%>		
                            </td> 
                            
                            <%-- Get the MaxUnits --%>
                            <td>
                                <input value="<%= rs.getInt("MaxUnits") %>" 
                                    name="MaxUnits" size="10">
                            </td>
                           
                            <%-- Get the MinUnits --%>
                           <td>
                                <input value="<%= rs.getInt("MinUnits") %>" 
                                    name="MinUnits" size="10">
                            </td> 
                            
                            <%-- Get the RequireLabWorks --%>
                           <td>
                           		<select name="RequireLabWorks">
                           		<%
                           			if(rs.getBoolean("RequireLabWorks") == true){
                           		%>
                           				<option value="Yes" selected>Yes</option>
                               			<option value="No">No</option>
                           		<% 	}
                           			else{
                           		%>
                           			<option value="Yes">Yes</option>
                               		<option value="No" selected>No</option>
                               	<%
                           			}
                           		%>
                           		</select>
                             
                            </td> 
                            
                            <%-- Get the GradeOption --%>
     
                            <td>
                            	<select name="GradeOption">
                            	<% 
                            		if(rs.getString("GradeOption").equals("Letter Grade Only")){
                            	%>		
                            		<option value="Letter Grade Only" selected>Letter Grade Only</option>
                            		<option value="Pass/No pass Only">Pass/No pass Only</option>
                            		<option value="Letter Grade & Pass/No pass">Letter Grade & Pass/No pass</option>
                           		<% 
                            		}else if(rs.getString("GradeOption").equals("Pass/No pass Only")){
                           		%>	
                           			<option value="Pass/No pass Only" selected>Pass/No pass Only</option>
                            		<option value="Letter Grade Only">Letter Grade Only</option>
                            		<option value="Letter Grade & Pass/No pass">Letter Grade & Pass/No pass</option>
                           		<% 
                           			}else{
                           		%>
                           		    <option value="Letter Grade & Pass/No pass" selected>Letter Grade & Pass/No pass</option>
                           			<option value="Letter Grade Only">Letter Grade Only</option>
                           			<option value="Pass/No pass Only">Pass/No pass Only</option>
                      			<% 
                      				}
                      			%>
	                            	
                            	</select>
                     
                            </td> 
                            
                            <%-- Get the RequireConsentOfInstructor --%>
                           <td>
                               <select name="RequireConsentOfInstructor">
                           		<%
                           			if(rs.getBoolean("RequireConsentOfInstructor") == true){
                           		%>
                           				<option value="Yes" selected>Yes</option>
                               			<option value="No">No</option>
                           		<% 	}
                           			else{
                           		%>
                           			<option value="Yes">Yes</option>
                               		<option value="No" selected>No</option>
                               	<%
                           			}
                           		%>
                           		</select>
                            </td> 
                      
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("CourseName") %>" name="CourseName"> 
                                
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
