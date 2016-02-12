<!DOCTYPE html>
<html>
<head>
	<title>Review Session Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>



  	<h2>Review Session Entry Form</h2>

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
                            "INSERT INTO ReviewSession VALUES (?, ?, ?, ?, ?)");
						pstmt.setString(1, request.getParameter("ReviewID"));
						pstmt.setString(2, request.getParameter("Location"));
						if(request.getParameter("IsMandatory").equals("Yes")){
							pstmt.setBoolean(3, true);
						}
						else{
							pstmt.setBoolean(3, false);

						}
						pstmt.setString(4, request.getParameter("Date"));
						pstmt.setString(5, request.getParameter("Time"));


                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                        
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        pstmt = conn.prepareStatement(
                            "INSERT INTO ClassReview (SectionID, ReviewID) VALUES (?, ?)");
						pstmt.setString(1, request.getParameter("SectionID"));
						pstmt.setString(2, request.getParameter("ReviewID"));

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
                            "UPDATE ReviewSession SET Location = ?, IsMandatory = ?, Date = ?, Time = ? WHERE ReviewID = ?");
                  
                    	
                        pstmt.setString(1, request.getParameter("Location"));
                        if(request.getParameter("IsMandatory").equals("Yes")){
                        	pstmt.setBoolean(2, true);
                        }
                        else{
                        	pstmt.setBoolean(2, false);
                        }
						pstmt.setString(3, request.getParameter("Date")); 
						pstmt.setString(4, request.getParameter("Time")); 
						pstmt.setString(5, request.getParameter("ReviewID")); 
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                        
                     	// Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        pstmt = conn.prepareStatement(
                            "UPDATE ClassReview SET SectionID = ?, ReviewID = ? WHERE CR_ID = ?");
                  
                    	
                        pstmt.setString(1, request.getParameter("SectionID"));
						pstmt.setString(2, request.getParameter("ReviewID")); 
						pstmt.setInt(3, Integer.parseInt(request.getParameter("CR_ID"))); 
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
                            "DELETE FROM ClassReview WHERE CR_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CR_ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                        
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        pstmt = conn.prepareStatement(
                            "DELETE FROM ReviewSession WHERE ReviewID = ?");

                        pstmt.setString(
                            1, request.getParameter("ReviewID"));
                        rowCount = pstmt.executeUpdate();

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
                        ("SELECT * FROM ReviewSession");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>ReviewID</th>
						<th>Location</th>
						<th>IsMandatory</th>
						<th>Date</th>
						<th>Time</th>
						<th>Class</th>
                    </tr>
                    <tr>
                        <form action="review_session.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ReviewID" size="10"></th>
                            <th><input value="" name="Location" size="10"></th>
                            <th>
								<select name="IsMandatory">
								<option>Yes</option>
								<option>No</option>
								</select>
							</th>
                            <th><input value="" type="date" name="Date" size="10"></th>
                            <th><input value="" type="time" name="Time" size="10"></th>
                            <th>
                            <select name="SectionID">
	            
				               <% 
				              // Create the statement
			                    Statement course_s = conn.createStatement();
			
			                    // Use the created statement to SELECT
			                    // the student attributes FROM the Student table.
			                    ResultSet rs_c = course_s.executeQuery
			                        ("SELECT * FROM Classes");
			                    
			                	if (!rs_c.isBeforeFirst() ) {    
							%>
										<option value="no classes" > There are no classes </option>
							<% 
								}
								else{
									while(rs_c.next()){
							%>	
										<option value="<%= rs_c.getString("SectionID") %>"> <%= rs_c.getString("SectionID") %> </option>
							<%
									}
								}
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
                        <form action="review_session.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the Name --%>
                            <td>
                                <input value="<%= rs.getString("ReviewID") %>" 
                                    name="ReviewID" size="10">
                            </td>
    
                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("Location") %>" 
                                    name="Location" size="10">
                            </td>
							<td>
								<select name="IsMandatory">
								<%
									if(rs.getBoolean("IsMandatory") == true){
								%>
										<option selected>Yes</option>
										<option>No</option>
										
								<% 
									}else{
								%>
									<option>Yes</option>
								
									<option selected>No</option>
								<%
									}
								%>
                                </select>
                            </td>
                            <td>
                                <input type="date" value="<%= rs.getString("Date") %>" 
                                    name="Date" size="10">
                            </td>
                            
                             <td>
                                <input type="time" value="<%= rs.getString("Time") %>" 
                                    name="Time" size="10">
                            </td>
							<td>
  								<!-- <select name="DepartmentName">-->
                            	<%
                            		Statement cr_statement = conn.createStatement();
									ResultSet cr = cr_statement.executeQuery("SELECT * FROM ClassReview");
									int ID = -1;
								%>
								<select name="SectionID" class="form-control">
								<%
									while(cr.next()){
										//Find the entry with the same degree name
										if(cr.getString("ReviewID").equals(rs.getString("ReviewID"))){
											String dep = cr.getString("SectionID");											
											%>
						
											<%									
												Statement c_statement = conn.createStatement();
												ResultSet crs = c_statement.executeQuery("SELECT * FROM Classes");
												
												if (!crs.isBeforeFirst() ) {    
											%>
												<option value="no class" name="SectionID" > There are no classes </option>
											<% 
												}
												else{
													while(crs.next()){
														if(crs.getString("SectionID").equals(dep)){
												%>
															<option value="<%= crs.getString("SectionID") %>" selected> <%= crs.getString("SectionID") %> </option>
												<% 
														}
														else{
												%>
															<option value="<%= crs.getString("SectionID") %>"> <%= crs.getString("SectionID") %> </option>
												<%			
														}
													}
												}
												ID = cr.getInt("CR_ID");
												break;
											}
										}//End of while
								
                            	%>
                            	</select>
                                    
                                    
                            </td>
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                            <input type="hidden" name="CR_ID" value=<%= ID %>>
                        </form>
                        <form action="review_session.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("ReviewID") %>" name="ReviewID">
                            <%-- Button --%>
                            <input type="hidden" name="CR_ID" value=<%= ID %>>
                            
                            <td>
                                <input class="btn btn-default" type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
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
