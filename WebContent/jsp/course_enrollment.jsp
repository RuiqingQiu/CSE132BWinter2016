<html>
<head>
	<title>Course Enrollment Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <table border="1" class="table table-bordered">
        <tr>
            <td>
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="../form_html/course_enrollment_menu.html" />
                
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
               
                       // Create the prepared statement and use it to
                       // INSERT the student selected section INTO the StudentEnrollment table.
                       PreparedStatement pstmt = conn.prepareStatement(
                           "INSERT INTO StudentEnrollment VALUES (?, ?)");
                	
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // StudentID is the PK
                        pstmt.setString(1, request.getParameter("StudentID"));
						pstmt.setString(2,request.getParameter("SectionID"));
	
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
                            "UPDATE StudentEnrollment SET SectionID = WHERE StudentID = ?"); 
                        
                        pstmt.setString(1, request.getParameter("SectionID"));
                        pstmt.setString(2,request.getParameter("StudentID"));  
                        
                         
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
                        
                        
                        // Delete from CourseHasClass table first because FK constraint
                        PreparedStatement pstmt = conn.prepareStatement(
                                 "DELETE FROM StudentEnrollment WHERE StudentID = ?");
                        
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
            
                // the student attributes FROM the Student table.
                ResultSet rs = statement.executeQuery
                        ("SELECT * FROM StudentEnrollment"); 
                
               /*  // Select from CourseHasClass Table
                statement = conn.createStatement();
                ResultSet rs_cc = statement.executeQuery("SELECT * FROM CourseHasClass"); */
                
                // Select from Course Table
                statement = conn.createStatement();
                ResultSet rs_c = statement.executeQuery("SELECT * FROM Course"); 
                   
            %>
            
            <!-- Make the input box vertically listed -->
            <form action="course_enrollment.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				
            	StudentID: <input value="" name="StudentID" size="10"><br>
            	
            	<!-- Need to choose quarter first  -->
            	
            	<!-- Create a drop down for selecting course -->
            	CourseName: <select name="CourseName">
            	<%
            		// if there is no entry in the Course table
					if (!rs_c.isBeforeFirst() ) {    
				%>
					<option value="no course" name="CourseName" > There are no courses </option>
				<% 
				}
				else{
				%>
					<option value=""></option>
				<% 
					while(rs_c.next()){
				%>	
						<option value="<%= rs_c.getString("CourseName") %>" name ="CourseName" > <%= rs_c.getString("CourseName") %> </option>
            	<%
					} // close of while loop
				}// close of else statement
				%>
				</select><br> <!-- end of select course  -->
			
            	Title: <input value="" name="Title" size="10"><br>
            	Quarter: <input value="" name="Quarter" size="10"><br>
            	Year:<input value="" name="Year" size="10"><br>
            	MaxEnrollment:<input value="" name="MaxEnrollment" size="10"><br>
            	<input class="btn btn-default" type="submit" value="Insert">
            </form>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                    	<th></th>
                        <th>SectionID</th>
                        <th>CourseName</th>
                        <th>Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MaxEnrollment</th>
						<th>Action</th>
   
            <%-- -------- Iteration Code for displaying the result -------- --%>
            <%
                    // Iterate over the ResultSet
                    statement = conn.createStatement();
                    rs = statement.executeQuery
       					("SELECT * FROM Classes"); 
        
                    while ( rs.next() ) {
                    	int id_selected=0;
            %>
                  <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">
                            
                            <%--Display the CourseHasClass ID column in the table --%>
                            <!-- <td style="visibility:collapse;"> -->
                            <td>
                            	 <%
                        			// Select from CourseHasClass Table
                         			statement = conn.createStatement();
                         			rs_cc = statement.executeQuery("SELECT * FROM CourseHasClass");   
                          
                            		// if there is no entry in the Department table
									if (!rs_cc.isBeforeFirst() ) {   
                            	%>
                            		<option value="no id" name="ID" > There are no IDs in the CourseHasClass table</option>
                            	<% 
								}
								else{
		
										while(rs_cc.next()){
											if(rs_cc.getString("SectionID").equals(rs.getString("SectionID"))){
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
                             
                             <%-- Get the SectionID, which is the PK --%>
                            <td>
              				 	<input type="hidden" value="<%= rs.getString("SectionID") %>" name="SectionID" size="10">
                                <%= rs.getString("SectionID") %>
                            </td> 
                 <td>  
                  	<select name="CourseName">
            		<%
						statement = conn.createStatement();
						rs_cc = statement.executeQuery
					   	 ("SELECT * FROM CourseHasClass");
					
            			// if there is no entry in the Course table
						if (!rs_cc.isBeforeFirst() ) {    
					%>
						<option value="no course class relationship" name="CourseName" > There are no course has class relationship</option>
					<% 
						}
						else{
							String courseNameSelected = "";
							while(rs_cc.next()){
								if(rs_cc.getString("SectionID").equals(rs.getString("SectionID"))){		
									courseNameSelected = rs_cc.getString("CourseName");
									break;
								}// end of IF finding same SectionID
							}// end of while 
								
							statement = conn.createStatement();
							rs_c = statement.executeQuery
						   	 ("SELECT * FROM Course");
							
							// if there is no entry in the Course table
							if (!rs_c.isBeforeFirst() ) {  
					%>
								<option value="no course" name="CourseName"> There are no course</option>
					<% 
							} // end of if checking empty result set
							while(rs_c.next()){
								if(rs_c.getString("CourseName").equals(courseNameSelected)){				
					%>	
							<option value="<%= rs_c.getString("CourseName") %>" selected> <%= rs_c.getString("CourseName") %> </option>
            		<%
							}else{
					%>
							<option value="<%= rs_c.getString("CourseName") %>"> <%= rs_c.getString("CourseName") %> </option>
            		<%	
							}// close of else statement 
						} // close of while loop
					}// close of else statement
					%>
					</select>             
        		 </td>
                            <%-- Get the title --%>
                            <td>
                              <input value="<%= rs.getString("Title") %>" 
                                    name="Title" size="10">
                            </td> 
                            
                            <%-- Get the Quarter --%>
                            <td>
                                <input value="<%= rs.getString("Quarter") %>" 
                                    name="Quarter" size="10">
                            </td>
                           
                            <%-- Get the Year --%>
                           <td>
                                <input value="<%= rs.getString("Year") %>" 
                                    name="Year" size="10">
                            </td> 
                            
                            <%-- Get the MaxEnrollment --%>
                           <td>
                                <input value="<%= rs.getInt("MaxEnrollment") %>" 
                                    name="MaxEnrollment" size="10">
                            </td> 
                
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("SectionID") %>" name="SectionID"> 
                            <input type="hidden" 
                                value="<%= id_selected %>" name="ID">
                                
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
