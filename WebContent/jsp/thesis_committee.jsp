<!DOCTYPE html>
<html>
<head>
	<title>Thesis Committee Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
		<h2>Thesis Committee Entry Form</h2>
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
                            "INSERT INTO ThesisCommittee(StudentID, FacultyName, DepartmentName) VALUES (?, ?, ?)");
						pstmt.setString(1, request.getParameter("StudentID"));
						pstmt.setString(2, request.getParameter("FacultyName"));
						pstmt.setString(3, request.getParameter("DepartmentName"));

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

                    	/*
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE ThesisCommittee SET StudentID = ?, Faculty = ?, DepartmentName = ?  WHERE ProbationID = ?");

                        pstmt.setString(1, request.getParameter("StudentID"));
						pstmt.setString(2, request.getParameter("FacultySSN"));
						pstmt.setString(3, request.getParameter("DepartmentName")); 
						pstmt.setInt(4, Integer.parseInt(request.getParameter("ProbationID"))); 
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                        */
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
                            "DELETE FROM ThesisCommittee WHERE StudentID = ? and DepartmentName = ? and FacultyName = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("StudentID")));
                        pstmt.setInt(
                                2, Integer.parseInt(request.getParameter("DepartmantName")));
                        pstmt.setInt(
                                3, Integer.parseInt(request.getParameter("FacultyName")));
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
                        <th>DepartmentName</th>
                        <th>Faculty Name</th>
                    </tr>
                    <tr>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="StudentID" size="10"></th>
                            <th>
                            	<select name="DepartmentName" class="form-control">
			
								<%									
									Statement statement = conn.createStatement();
									ResultSet rs = statement.executeQuery("SELECT * FROM Department");
									if (!rs.isBeforeFirst() ) {    
								%>
									<option value="no department" name="DepartmentName" > There are no departments </option>
								<% 
									}
									else{
										while(rs.next()){
									%>	
									
									<option value="<%= rs.getString("DepartmentName") %>"> <%= rs.getString("DepartmentName") %> </option>
									<%
										}
									}
									%>
								</select>
                            </th>
                            <th><input value="" type="text" name="FacultyName" size="10"></th>
                            
                            <th><input class="btn btn-default" type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        			rs = statement.executeQuery
						("SELECT * FROM ThesisCommittee");
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the Name --%>
                            <td>
                                <input value="<%= rs.getString("StudentID") %>" 
                                    name="ProbationID" size="10">
                            </td>
    
                            <td>
                            	<select name="DepartmentName">
            	
            					<%
            						Statement departmentStatement = conn.createStatement();
                        			ResultSet rs_department = departmentStatement.executeQuery("SELECT * FROM Department");
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
								<option value="<%= rs_department.getString("DepartmentName") %>" name="DepartmentName" selected> <%= rs_department.getString("DepartmentName") %> </option>
								<% 
											}
											else{
								%>
								<option value="<%= rs_department.getString("DepartmentName") %>" name="DepartmentName" > <%= rs_department.getString("DepartmentName") %> </option>
								<%
											}
										} // close of while loop
									}// close of else statement
								%>
								</select>
                     
                            </td> 
							<td>
                                <input value="<%= rs.getString("FacultyName") %>" 
                                    name="StartTime" size="10">
                            </td>
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        <form action="thesis_committee.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("StudentID") %>" name="StudentID">
                             <input type="hidden" 
                                value="<%= rs.getString("DepartmentName") %>" name="DepartmentName">
                             <input type="hidden" 
                                value="<%= rs.getString("FacultyName") %>" name="FacultyName">
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
