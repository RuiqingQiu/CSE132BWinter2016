<html>
<head>
	<title>Academic History Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
            $(document).ready(function() { 
                $('#Year').change(function() {  
                    var quarter=$(this).val();
                 	$.get('../ClassEnrollmentHandler',{Quarter: quarter},function(responseText) { 
                        $('#form').html(responseText);        
                    });
                });
                $('#show_student').click(function(){
                	$("#student_table").toggle();
                });
            });
    </script>
	

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
	<h3>Academic History Form</h3>
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
            <!-- Make the input box vertically listed -->
            	<form action="academic_history.jsp" method="get" id="YearSelection">
					<input type="hidden" value="Search" name="action">
				
            			StudentID: <input value="" name="StudentID" size="10"><br>
      			<%            	
                		Statement p_statement = conn.createStatement();
                		ResultSet rs_classes = p_statement.executeQuery("SELECT DISTINCT Year FROM Classes"); 
               	%> 
            			Year: <select id="Year" name="Year">
            			<%
            				// if there is no entry in the Course table
							if (!rs_classes.isBeforeFirst() ) {    
						%>
							<option value="no year" name="Year" > There are no academic year </option>
						<% 
						}
						else{
						%>
							<option value=""></option>
						<% 
							while(rs_classes.next()){
						%>	
								<option value="<%= rs_classes.getString("Year") %>" name ="Year" > <%= rs_classes.getString("Year") %> </option>
            			<%
							} // close of while loop
						}// close of checking result set statement
					%>
						</select> <!-- end of select Year  -->
					<%            	
                		p_statement = conn.createStatement();
                		rs_classes = p_statement.executeQuery("SELECT DISTINCT Quarter FROM Classes"); 
               		%> 
						Quarter: <select id="Quarter" name="Quarter">
            			<%
            				// if there is no entry in the Course table
							if (!rs_classes.isBeforeFirst() ) {    
						%>
							<option value="no quarter" name="Quarter" > There are no academic quarter </option>
						<% 
						}
						else{
						%>
							<option value=""></option>
						<% 
							while(rs_classes.next()){
						%>	
								<option value="<%= rs_classes.getString("Quarter") %>" name ="Quarter" > <%= rs_classes.getString("Quarter") %> </option>
            			<%
							} // close of while loop
						}// close of checking result set statement
					%>
						</select> <!-- end of select Year  -->
					 <input class="btn btn-default" type="submit" value="Search Classes" id="Search">
										
				</form>
           		<h2>Class List</h2>

            	<table border="1" class="table table-bordered">
                    <tr>
                    	<th></th>
                        <th>SectionID</th>
                        <th>CourseName</th>
                        <th>Max Unit</th>
                        <th>Min Unit</th>
                        <th>Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MaxEnrollment</th>
                        <th>Units</th>
                        <th>Final Grade</th>
						<th>Action</th>
 			<%-- -------- Handle Input Selection Code -------- --%>
            <%
               		String action = request.getParameter("action");
            		String studentID = "";
                    // Handle input Year selection
                   if (action != null && action.equals("Search")) {
                	  studentID = request.getParameter("StudentID");
                	  PreparedStatement ps = null;
                	  String sql = "SELECT * FROM Classes WHERE Year= ? and Quarter = ?";
                	  
                	  ps = conn.prepareStatement(sql);
                	  ps.setString(1, request.getParameter("Year")); 
                      ps.setString(2, request.getParameter("Quarter")); 
                	  ResultSet rs_year = ps.executeQuery();
                   
                       if(!rs_year.isBeforeFirst()){
                    	   System.out.println("selection failed");
                       }else{
                    	   //System.out.println("selection success");
                       }      
             		   while ( rs_year.next() ) {
                    	 int id_selected=0;
            %>
                   <tr>
                        <form action="academic_history.jsp" method="get">
                            <input type="hidden" value="enroll" name="action">
                            
                        	<input type="hidden" value="<%= request.getParameter("StudentID") %>" name="StudentID">
                           <td>
                            	 <%
                        			// Select from CourseHasClass Table
                         			Statement t_statement = conn.createStatement();
                         			ResultSet rs_cc = t_statement.executeQuery("SELECT * FROM CourseHasClass");   
                          
                            		// if there is no entry in the Department table
									if (!rs_cc.isBeforeFirst() ) {   
                            	%>
                            		<option value="no id" name="ID" > There are no IDs in the CourseHasClass table</option>
                            	<% 
								}
								else{
		
										while(rs_cc.next()){
											if(rs_cc.getString("SectionID").equals(rs_year.getString("SectionID"))){
												id_selected = rs_cc.getInt("ID");
								%>
                            		<input type="hidden" value="<%= rs_cc.getInt("ID") %>" name="ID" size="10">
                                	<%= rs_cc.getInt("ID") %>
                                <% 
									}
								%>						
		            		<%
								} // close of while loop
							}// close of else statement
							%>
                            </td>
                            <td>
              				 	<input type="hidden" value="<%= rs_year.getString("SectionID") %>" name="SectionID" size="10">
                                <%= rs_year.getString("SectionID") %>
                            </td> 
                 
                  	
            		<%
						Statement q_statement = conn.createStatement();
						rs_cc = q_statement.executeQuery
					   	 ("SELECT * FROM CourseHasClass");
					
            			// if there is no entry in the Course table
						if (!rs_cc.isBeforeFirst() ) {    
					%>
						There are no course has class relationship
					<% 
						}
						else{
							String courseNameSelected = "";
							while(rs_cc.next()){
								if(rs_cc.getString("SectionID").equals(rs_year.getString("SectionID"))){		
									courseNameSelected = rs_cc.getString("CourseName");
									break;
								}// end of IF finding same SectionID
							}// end of while 
								
							Statement t_statement1 = conn.createStatement();
							ResultSet rs_c = t_statement1.executeQuery
						   	 ("SELECT * FROM Course");
							
							// if there is no entry in the Course table
							if (!rs_c.isBeforeFirst() ) {  
					%>
								There are no course
					<% 
							} // end of if checking empty result set
							while(rs_c.next()){
								if(rs_c.getString("CourseName").equals(courseNameSelected)){				
					%>	
							<td><%= rs_c.getString("CourseName") %> </td>
							<td><%= rs_c.getInt("MaxUnits") %> </td>
							<td><%= rs_c.getInt("MinUnits") %> </td>
							
            		<%
								}
							} // close of while loop
					}// close of else statement
					%>
                            <%-- Get the title --%>
                            <td>
                              <input type="hidden" value="<%= rs_year.getString("Title") %>" 
                                    name="Title" size="10">
                              <%= rs_year.getString("Title") %>
                            </td> 
                            
                            <%-- Get the Quarter --%>
                            <td>
                                <input type="hidden" value="<%= rs_year.getString("Quarter") %>" 
                                    name="Quarter" size="10">
                                <%= rs_year.getString("Quarter") %>
                            </td>
                           
                            <%-- Get the Year --%>
                           <td>
                                <input type="hidden" value="<%= rs_year.getString("Year") %>" 
                                    name="Year" size="10">
                                <%= rs_year.getString("Year") %>
                            </td> 
                            
                            <%-- Get the MaxEnrollment --%>
                           <td>
                                <input type="hidden" value="<%= rs_year.getInt("MaxEnrollment") %>" 
                                    name="MaxEnrollment" size="10">
                                <%= rs_year.getInt("MaxEnrollment") %>
                            </td> 
                            <td>
                            	<input value="" name="Units">
                            </td>
                            <td>
                            	<input value="" name="FinalGrade">
                            </td>
                
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Add to History">
                            </td>
                        </form>
                    </tr> 
            <%
                    }
           	%>  	</table>
           	
           
				
            <!-- Add an HTML table header row to format the results -->
            <h2>Academic History</h2>
                <table border="1" class="table table-bordered">
                    <tr>
                    	<th>SectionID</th>
                    	<th>Course Name</th>
                    	<th>Units</th>
                    	<th>Final Grade</th>
						<th>Action</th>
					</tr>
   
            <%-- -------- Iteration Code for displaying the result -------- --%>
           <%
                    // Iterate over the ResultSet
               	  	studentID = request.getParameter("StudentID");
               	  	ps = null;
               	  	sql = "SELECT * FROM AcademicHistory WHERE StudentID = ?";
               	  
               	  	ps = conn.prepareStatement(sql);
               	  	ps.setString(1, request.getParameter("StudentID")); 
               	    ResultSet rs = ps.executeQuery();
                    while ( rs.next() ) {
            %>
                  <tr>
                    <form action="academic_history.jsp" method="get">
                    <input type="hidden" value="update" name="action">
                    
                  	<td>
                  		<input type="hidden" value="<%= rs.getString("SectionID") %>" name="SectionID">
                  		<input type="hidden" value="<%= rs.getString("StudentID") %>" name="StudentID">
                  		
                  		<%= rs.getString("SectionID") %>
                  	</td>
                  	<td>
                  		<%
                  		studentID = request.getParameter("StudentID");
                   	  	PreparedStatement ps1 = null;
                   	  	String sql1 = "SELECT * FROM CourseHasClass WHERE SectionID = ?";
                   	  
                   	  	ps1 = conn.prepareStatement(sql1);
                   	  	ps1.setString(1, rs.getString("SectionID"));
                   	    ResultSet rs1 = ps1.executeQuery();
                   	    while(rs1.next()){
                  		%>
                  			<%= rs1.getString("CourseName") %>
                  		<%
                   	    }
                  		%>
                  	</td>
                  	<td>
                  		<input value="<%= rs.getString("Units") %>" name="Units">
                  	</td>
                  	<td>
                  	   <input value="<%= rs.getString("FinalGrade") %>" name="FinalGrade">
                  		
                  	</td>
                  	<td>
                  		<input class="btn btn-default" type="submit" value="Update">
                  	</td>
                  	</form>
                  	<form action="academic_history.jsp" method="get">
                            <input type="hidden" value="drop" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getString("SectionID") %>" name="SectionID">
                            <input type="hidden" 
                                value="<%= rs.getString("StudentID") %>" name="StudentID">
                                
                            <%-- Button --%>
                            <td>
                  				<input class="btn btn-default" type="submit" value="Remove">
                            </td>
                        </form>
                  </tr>
           	
			<% 
                    }
            	}// end of if action is select year
            %>
   
            <%-- -------- INSERT Code -------- --%>
            <%
                	if(action != null && action.equals("enroll")){
                			PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO AcademicHistory VALUES (?, ?, ?, ?)");
                     	
                             // Begin transaction
                             conn.setAutoCommit(false);
                             
                             // StudentID is the PK
                             pstmt.setString(1, request.getParameter("StudentID"));
     						 pstmt.setString(2, request.getParameter("SectionID"));
     						 pstmt.setInt(3, Integer.parseInt(request.getParameter("Units")));
     						 pstmt.setString(4, request.getParameter("FinalGrade"));

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
                        // UPDATE the student attributes in the Classes table.
                        // Can't update SectionID because it is PK

                       PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE AcademicHistory SET Units = ?, FinalGrade = ? WHERE StudentID = ? and SectionID = ?"); 
                        
                        pstmt.setString(4, request.getParameter("SectionID"));
                        pstmt.setString(3,request.getParameter("StudentID"));  
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("Units")));  
                        pstmt.setString(2, request.getParameter("FinalGrade"));  

                        
                         
                        int rowCount = pstmt.executeUpdate();
           
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true); 
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                     if (action != null && action.equals("drop")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        
                        // Delete from CourseHasClass table first because FK constraint
                        PreparedStatement pstmt = conn.prepareStatement(
                                 "DELETE FROM AcademicHistory WHERE StudentID = ? and SectionID = ?");
                        
                        pstmt.setString(
                                 1, request.getParameter("StudentID"));
                        pstmt.setString(
                                2, request.getParameter("SectionID"));
                             
                       int rowCount = pstmt.executeUpdate();
              
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    } 
            %>


                   

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                   // rs.close();
    
                    // Close the Statement
                    //statement.close();
    
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
