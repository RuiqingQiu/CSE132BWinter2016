<html>
<head>
	<title>Degree Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
   <h2>Degree Entry Form</h2>

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
                    	//Faculty f = new Faculty(request.getParameter("Name"), request.getParameter("SSN"), request.getParameter("Title"));
                    	//f.insert(conn);
                    	// Begin transaction
                        conn.setAutoCommit(false);
                       
                       // Create the prepared statement and use it to
                       // UPDATE the student attributes in the Student table.
                       PreparedStatement pstmt = conn.prepareStatement(
                           "INSERT INTO Degree Values (?, ?)");

                       pstmt.setString(1, request.getParameter("DegreeName"));
                       pstmt.setInt(2, Integer.parseInt(request.getParameter("TotalUnitsRequired")));
                                        

                       int rowCount = pstmt.executeUpdate();

                       // Commit transaction
                       conn.commit();
                       conn.setAutoCommit(true);
                       
                       
					   conn.setAutoCommit(false);
                       
                       // Create the prepared statement and use it to
                       // UPDATE the student attributes in the Student table.
                       pstmt = conn.prepareStatement(
                           "INSERT INTO DegreeOffer(DepartmentName, DegreeName) Values (?, ?)");

                       pstmt.setString(1, request.getParameter("DepartmentName"));
                       pstmt.setString(2, request.getParameter("DegreeName"));
                                        

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
                            "UPDATE Degree SET TotalUnitsRequired = ? WHERE DegreeName = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("TotalUnitsRequired")));
                        pstmt.setString(2, request.getParameter("DegreeName"));
                                         

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                        
                     // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        pstmt = conn.prepareStatement(
                            "UPDATE DegreeOffer SET DepartmentName = ?, DegreeName = ? WHERE DegreeOfferID = ?");

                        pstmt.setString(1, request.getParameter("DepartmentName"));
                        pstmt.setString(2, request.getParameter("DegreeName"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("DegreeOfferID")));
                                         

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
                            "DELETE FROM DegreeOffer WHERE DegreeOfferID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("DegreeOfferID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    	
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        pstmt = conn.prepareStatement(
                            "DELETE FROM Degree WHERE DegreeName = ?");

                        pstmt.setString(
                            1, request.getParameter("DegreeName"));
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
                        ("SELECT * FROM Degree");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>DegreeName</th>
                        <th>TotalUnitsRequired</th>
                     	<th>Department Name</th>
                    </tr>
                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="DegreeName" size="10"></th>
                            <th><input value="" name="TotalUnitsRequired" size="10"></th>
                            <th>
                            	<select name="DepartmentName" class="form-control">
			
								<%									
									Statement department_statement = conn.createStatement();
									ResultSet rs_department = department_statement.executeQuery("SELECT * FROM Department");
									if (!rs_department.isBeforeFirst() ) {    
								%>
									<option value="no department" name="DepartmentName" > There are no departments </option>
								<% 
									}
									else{
										while(rs_department.next()){
									%>	
									
									<option value="<%= rs_department.getString("DepartmentName") %>"> <%= rs_department.getString("DepartmentName") %> </option>
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
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN --%>
                            <td>
                                <input type="hidden" value="<%= rs.getString("DegreeName") %>" 
                                    name="DegreeName" size="10">
                                <%= rs.getString("DegreeName") %>
                            </td>
    
                            <%-- Get the Name --%>
                            <td>
                                <input value="<%= rs.getInt("TotalUnitsRequired") %>" 
                                    name="TotalUnitsRequired" size="10">
                            </td>
                            <td>
                            	
                            	
                            	<!-- <select name="DepartmentName">-->
                            	<%
                            		Statement degree_offer_statement = conn.createStatement();
									ResultSet degree_offer = degree_offer_statement.executeQuery("SELECT * FROM DegreeOffer");
									int ID = -1;
								%>
								<select name="DepartmentName" class="form-control">
								<%
									while(degree_offer.next()){
										//Find the entry with the same degree name
										if(degree_offer.getString("DegreeName").equals(rs.getString("DegreeName"))){
											String dep = degree_offer.getString("DepartmentName");											
											%>
						
											<%									
												department_statement = conn.createStatement();
												rs_department = department_statement.executeQuery("SELECT * FROM Department");
												
												if (!rs_department.isBeforeFirst() ) {    
											%>
												<option value="no department" name="DepartmentName" > There are no departments </option>
											<% 
												}
												else{
													while(rs_department.next()){
														if(rs_department.getString("DepartmentName").equals(dep)){
												%>
															<option value="<%= rs_department.getString("DepartmentName") %>" selected> <%= rs_department.getString("DepartmentName") %> </option>
												<% 
														}
														else{
												%>
															<option value="<%= rs_department.getString("DepartmentName") %>"> <%= rs_department.getString("DepartmentName") %> </option>
												<%			
														}
													}
												}
											
												ID = degree_offer.getInt("DegreeOfferID");
												System.out.println("DegreeOfferID is " + ID);
												break;
											}
										}//End of while
								
                            	%>
                            	</select>
                            </td> 
                            	<input type="hidden" value="<%= ID %>" name="DegreeOfferID">
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= ID %>" name="DegreeOfferID">
                             <input type="hidden" 
                                value="<%= rs.getString("DegreeName") %>" name="DegreeName">
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
                    
            <%
                    }//End of rs while loop
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
</body>

</html>
