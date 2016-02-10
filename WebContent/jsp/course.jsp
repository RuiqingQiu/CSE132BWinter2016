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
						if(c.RequireLabWorks.equals("1")){
							pstmt.setBoolean(5,true);
						}else{
							pstmt.setBoolean(5,false);
						}
						
						pstmt.setString(6,c.GradeOption);
						
						if(c.RequireConsentOfInstructor.equals("1")){
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
                            "UPDATE Course SET  DepartmentName = ?, MaxUnits = ?, MinUnits = ?, RequireLabWorks = ?, GradeOption = ?, RequireConsentOfInstrcutor = ? WHERE CourseName = ?");

                        pstmt.setString(1, request.getParameter("DepartmentName"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MaxUnits")));  
                        pstmt.setInt(3,Integer.parseInt(request.getParameter("MinUnits")));
                        
                        if(request.getParameter("RequireLabWorks").equals("1")){
                        	pstmt.setBoolean(4,true);
                        }else{
                        	pstmt.setBoolean(4,false);
                        }
                        System.out.println("here");
                        
                        
                        pstmt.setString(5,request.getParameter("GradeOption"));
                       	System.out.println("Gradeoptino "+ request.getParameter("GradeOption"));
                    	System.out.println("consent "+ request.getParameter("RequireConsentOfInstructor"));
                        
                        if(request.getParameter("RequireConsentOfInstrcutor").equals("1")){
                        	pstmt.setBoolean(5,true);
                        }else{
                        	pstmt.setBoolean(5,false);
                        }
                        
                        System.out.println("here 2");
                        pstmt.setString(6,request.getParameter("CourseName"));                        
                        
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

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                   Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Course"); 
                    
            %>

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
     
                 <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <input value="" name="CourseName" size="10"></br>
                            <input value="" name="DepartmentName" size="10"></br>
                            <input value="" name="MaxUnits" size="10"></br>
                            <input value="" name="MinUnits" size="10"></br>
                            <input value="" name="RequireLabWorks" size="10"></br>
                            <input value="" name="GradeOption" size="10"></br>
                            <input value="" name="RequireConsentOfInstructor" size="10"></br>         
                            <input class="btn btn-default" type="submit" value="Insert"></br>
                        </form>
                 </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                  <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="update" name="action"> -->

                            <%-- Get the CourseName --%>
                            <td>
                                <input value="<%= rs.getString("CourseName") %>" 
                                    name="CourseName" size="10">
                            </td> 
    
                            <%-- Get the Department --%>
                            <td>
                                <input value="<%= rs.getString("DepartmentName") %>" 
                                    name="DepartmentName" size="10">
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
                                <input value="<%= rs.getString("RequireLabWorks") %>" 
                                    name="RequireLabWorks" size="10">
                            </td> 
                            
                            <%-- Get the GradeOption --%>
                            <td>
                                <input value="<%= rs.getString("GradeOption") %>" 
                                    name="GradeOption" size="10">
                            </td> 
                            
                            <%-- Get the RequireConsentOfInstructor --%>
                           <td>
                                <input value="<%= rs.getString("RequireConsentOfInstructor") %>" 
                                    name="RequireConsentOfInstructor" size="10">
                            </td> 
                      
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("CourseName") %>" name="CourseName"> --%>
                                
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
