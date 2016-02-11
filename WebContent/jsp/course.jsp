<html>
<head>
	<title>Course Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <table border="1" class="table table-bordered">
        <tr>
            <td>
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="../form_html/course_menu.html" />
                
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
                	   Course c = new Course(
                  				request.getParameter("CourseName"),
                  				request.getParameter("DepartmentName"), 
                  				Integer.parseInt(request.getParameter("MaxUnits")), 
                  				Integer.parseInt(request.getParameter("MaxUnits")),
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
            	CourseName: <input value="" name="CourseName" size="10"><br>
            	
            	<!-- Create a drop down for all department -->
            	DepartmentName: <select name="DepartmentName">
            	
            	<%
            		// if there is no entry in the Department table
					if (!rs_department.isBeforeFirst() ) {    
				%>
					<option value="no department" name="DepartmentName" > There are no departments </option>
				<% 
				}
				else{
		
					while(rs_department.next()){
				%>	
				<option value="<%= rs_department.getString("DepartmentName") %>" name="DepartmentName" > <%= rs_department.getString("DepartmentName") %> </option>
            	<%
					} // close of while loop
				}// close of else statement
				%>
				</select><br> <!-- end of select department  -->
			
            	MaxUnits: <input value="" name="MaxUnits" size="10"><br>
            	MinUnits:<input value="" name="MinUnits" size="10"><br>
            	
            	RequireLabWorks:<select name="RequireLabWorks"> 
            		<option value="" ></option>
  					<option value="Yes" >Yes</option>
  					<option value="No" >No</option>	
				</select><br>
            	
            	GradeOption: 
            	<select name="GradeOption">
            		<option value=""></option>
            		<option value="Letter Grade Only">Letter Grade Only</option>
            		<option value="Pass/No pass Only">Pass/No pass only</option>
            		<option value="Letter Grade & Pass/No pass">Letter Grade & Pass/No pass</option>
            	</select><br>
            	
            	RequireConsentOfInstructor: 
            	<select name="RequireConsentOfInstructor">
            		<option value=""></option>
            		<option value="Yes">Yes</option>
            		<option value="No">No</option>
            	</select>
            	
            	<input class="btn btn-default" type="submit" value="Insert">
            
            </form>

            <!-- Add an HTML table header row to format the results -->
                
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>CourseName</th>
                        <th>DepartmentName</th>
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
								<option value="<%= rs_department.getString("DepartmentName") %>" selected> <%= rs_department.getString("DepartmentName") %> </option>
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
            </td>
        </tr>
    </table>
</body>

</html>
