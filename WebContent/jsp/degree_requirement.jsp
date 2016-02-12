<html>
<head>
	<title>Degree Requirement Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>

            $(document).ready(function() { 
            	$('#DegreeDetailedCourseRequirement').toggle();
            	//$('#DegreeDetailedCourseRequirementTable').toggle();
                $('#FormType').change(function() { 
                	
                    var form_type=$(this).val();
                    console.log(form_type);
                    if(form_type == 'DegreeDetailedCourseRequirement'){
                    	$('#DegreeDetailedCourseRequirement').show();
                    	//$('#DegreeDetailedCourseRequirementTable').show();
                    	$('#DegreeDetailedUnitRequirement').hide();
                    	//$('#DegreeDetailedUnitRequirementTable').hide();
                    }
                    else{
                    	$('#DegreeDetailedCourseRequirement').hide();
                    	//$('#DegreeDetailedCourseRequirementTable').hide();
                    	//$('#DegreeDetailedUnitRequirementTable').show();
                    	$('#DegreeDetailedUnitRequirement').show();
                    }
                 	$.get('../StudentTypeSelectServlet',{StudentType:username},function(responseText) { 
                        $('#form').html(responseText);        
                    });
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
	<h2>Degree Requirement Form</h2>
           
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
            
			What type of form do you need for degree requirement?
            <select id="FormType" name="FormType">
			<option value="DegreeDetailedUnitRequirement">DegreeDetailedUnitRequirement</option>
			<option value="DegreeDetailedCourseRequirement">DegreeDetailedCourseRequirement</option>
			</select>
			<div id="DegreeDetailedUnitRequirement">
				<!-- Default form is undergraduate -->
				<h3>Degree Detailed Unit Requirement Form</h3><br>
				<form action="degree_requirement.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<input type="hidden" value="DegreeDetailedUnitRequirement" name="FormType">
	            DegreeName: 
	            <select name="DegreeName">
	            <% 
	              // Create the statement
                    Statement degree_statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs_degree = degree_statement.executeQuery
                        ("SELECT * FROM Degree");
                    
                	if (!rs_degree.isBeforeFirst() ) {    
				%>
							<option value="no degree" > There are no degrees </option>
				<% 
					}
					else{
						while(rs_degree.next()){
				%>	
							<option value="<%= rs_degree.getString("DegreeName") %>"> <%= rs_degree.getString("DegreeName") %> </option>
				<%
						}
					}
				%>
	            </select>
	         	<br>	            
	            RequirementDescription: <input value="" name="RequirementDescription" size="10"><br>
	            UnitsRequired: <input value="" name="UnitsRequired" size="10"><br>
	            <input class="btn btn-default" type="submit" value="Insert">
	            </form>
			</div>
			
			<div id="DegreeDetailedCourseRequirement">
				<!-- Default form is undergraduate -->
				<h3>Degree Detailed Course Requirement Form</h3><br>
				<form action="degree_requirement.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<input type="hidden" value="DegreeDetailedCourseRequirement" name="FormType">
	            DegreeName: 
	            <select name="DegreeName">
	            <% 
	              // Create the statement
                    Statement degree_s = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs_d = degree_s.executeQuery
                        ("SELECT * FROM Degree");
                    
                	if (!rs_d.isBeforeFirst() ) {    
				%>
							<option value="no degree" > There are no degrees </option>
				<% 
					}
					else{
						while(rs_d.next()){
				%>	
							<option value="<%= rs_d.getString("DegreeName") %>"> <%= rs_d.getString("DegreeName") %> </option>
				<%
						}
					}
				%>
	            </select>
	         	<br>	            
	            Course Name: 
	          	<select name="CourseName">
	            
	               <% 
	              // Create the statement
                    Statement course_s = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs_c = course_s.executeQuery
                        ("SELECT * FROM Course");
                    
                	if (!rs_c.isBeforeFirst() ) {    
				%>
							<option value="no course" > There are no courses </option>
				<% 
					}
					else{
						while(rs_c.next()){
				%>	
							<option value="<%= rs_c.getString("CourseName") %>"> <%= rs_c.getString("CourseName") %> </option>
				<%
						}
					}
				%>
	            </select><br>
	            <input class="btn btn-default" type="submit" value="Insert">
	            </form>
			</div>
			
			<br>
			
			
            <%-- -------- INSERT Code -------- --%>
            <%
            		// request is a implicit object
                    String action = request.getParameter("action");
            		
            				
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {
                    	if(request.getParameter("FormType").equals("DegreeDetailedUnitRequirement")){
                    		// Begin transaction
                            conn.setAutoCommit(false);
                            // Create the prepared statement and use it to
                            // INSERT the student attributes INTO the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO DegreeDetailedUnitRequirement "
                                + "(DegreeName, RequirementDescription ,UnitsRequired) VALUES (?, ?, ?)");
                                
                            pstmt.setString(1, request.getParameter("DegreeName"));
                    		pstmt.setString(2, request.getParameter("RequirementDescription"));
                    		pstmt.setInt(3, Integer.parseInt(request.getParameter("UnitsRequired")));
                    			// Commit transaction
                    		int rowCount = pstmt.executeUpdate();
                            conn.commit();
                            conn.setAutoCommit(true);
                    	}
                    	else{
                    		// Begin transaction
                            conn.setAutoCommit(false);
                            // Create the prepared statement and use it to
                            // INSERT the student attributes INTO the Student table.
                            PreparedStatement pstmt = conn.prepareStatement(
                                "INSERT INTO DegreeDetailedCourseRequirement "
                                + "(DegreeName, CourseName) VALUES (?, ?)");
                            pstmt.setString(1, request.getParameter("DegreeName"));
                    		pstmt.setString(2, request.getParameter("CourseName"));
                    			// Commit transaction
                    		int rowCount = pstmt.executeUpdate();
                            conn.commit();
                            conn.setAutoCommit(true);
                    		
                    	}
                    	
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {
						if(request.getParameter("FormType").equals("DegreeDetailedUnitRequirement")){
							// Begin transaction
	                         conn.setAutoCommit(false);
	                        
	                        // Create the prepared statement and use it to
	                        // UPDATE the student attributes in the Student table.
	                        PreparedStatement pstmt = conn.prepareStatement(
	                            "UPDATE DegreeDetailedUnitRequirement SET DegreeName = ?, RequirementDescription = ?"
	                            		+ ", UnitsRequired = ? WHERE DDUR_ID = ?");

	                        pstmt.setString(1, request.getParameter("DegreeName"));
	                        pstmt.setString(2, request.getParameter("RequirementDescription"));
	                        pstmt.setInt(3, Integer.parseInt(request.getParameter("UnitsRequired")));
	                        pstmt.setInt(4, Integer.parseInt(request.getParameter("DDUR_ID")));

	                                         

	                        int rowCount = pstmt.executeUpdate();

	                        // Commit transaction
	                        conn.commit();
	                        conn.setAutoCommit(true);
						}
						else{
							// Begin transaction
	                         conn.setAutoCommit(false);
	                        
	                        // Create the prepared statement and use it to
	                        // UPDATE the student attributes in the Student table.
	                        PreparedStatement pstmt = conn.prepareStatement(
	                            "UPDATE DegreeDetailedCourseRequirement SET DegreeName = ?, CourseName = ? WHERE DDCR_ID = ?");

	                        pstmt.setString(1, request.getParameter("DegreeName"));
	                        pstmt.setString(2, request.getParameter("CourseName"));
	                        pstmt.setInt(3, Integer.parseInt(request.getParameter("DDCR_ID")));
	                        int rowCount = pstmt.executeUpdate();

	                        // Commit transaction
	                        conn.commit();
	                        conn.setAutoCommit(true);
						}
                        

                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {
						if(request.getParameter("FormType").equals("DegreeDetailedUnitRequirement")){
	                        // Begin transaction
	                        conn.setAutoCommit(false);
	                        
	                        // Create the prepared statement and use it to
	                        // DELETE the student FROM the Student table.
	                        PreparedStatement pstmt = conn.prepareStatement(
	                            "DELETE FROM DegreeDetailedUnitRequirement WHERE DDUR_ID = ?");
	
	                        pstmt.setInt(
	                            1, Integer.parseInt(request.getParameter("DDUR_ID")));
	                        int rowCount = pstmt.executeUpdate();
	
	                        // Commit transaction
	                        conn.commit();
	                        conn.setAutoCommit(true);
						}
						else{
							// Begin transaction
	                        conn.setAutoCommit(false);
	                        
	                        // Create the prepared statement and use it to
	                        // DELETE the student FROM the Student table.
	                        PreparedStatement pstmt = conn.prepareStatement(
	                            "DELETE FROM DegreeDetailedCourseRequirement WHERE DDCR_ID = ?");
	
	                        pstmt.setInt(
	                            1, Integer.parseInt(request.getParameter("DDCR_ID")));
	                        int rowCount = pstmt.executeUpdate();
	
	                        // Commit transaction
	                        conn.commit();
	                        conn.setAutoCommit(true);
						}
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM DegreeDetailedUnitRequirement");
            %>
<!-- CREATE TABLE DegreeDetailedUnitRequirement(
	DDUR_ID Serial Primary Key,
	DegreeName varchar(255) references Degree(DegreeName),
	RequirementDescription varchar(255),
	UnitsRequired int,
);
CREATE TABLE DegreeDetailedCourseRequirement(
	DDCR_ID Serial Primary Key,
	DegreeName varchar(255) references Degree(DegreeName),
	CourseName varchar(255) references Course(CourseName),
); -->
            <!-- Add an HTML table header row to format the results -->
            <div id="DegreeDetailedUnitRequirementTable">
            <h2>Degree Detailed Unit Requirement</h2>	
                <table border="1" class="table table-bordered" >
                    <tr>
                        <th>ID</th>
                        <th>Degree Name</th>
                        <th>Degree Detailed Unit Requirement</th>
                     	<th>UnitsRequired</th>
                    </tr>
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    while ( rs.next() ) {
            %>

                    <tr>
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action="degree_requirement.jsp" method="get">
                            <input type="hidden" value="update" name="action">
							<input type="hidden" value="DegreeDetailedUnitRequirement" name="FormType">
                            <%-- Get the SSN --%>
                            <td>
                                <input type="hidden" value="<%= rs.getInt("DDUR_ID") %>" 
                                    name="DDUR_ID" size="10">
                                <%= rs.getInt("DDUR_ID") %>
                            </td>
    
                            <%-- Get the Name --%>
                            <td>
  								<select name="DegreeName">
            	
            					<%
            						Statement degreeStatement = conn.createStatement();
                        			ResultSet rs_dd = degreeStatement.executeQuery("SELECT * FROM Degree");
            						// if there is no entry in the Department table
									if (!rs_dd.isBeforeFirst() ) {    
								%>
											<option value="no degree" name="DegreeName" > There are no degrees </option>
								<% 
									}
									else{
		
										while(rs_dd.next()){
											if(rs_dd.getString("DegreeName").equals(rs.getString("DegreeName"))){
								%>
								<option value="<%= rs_dd.getString("DegreeName") %>" name="DegreeName" selected> <%= rs_dd.getString("DegreeName") %> </option>
								<% 
											}
											else{
								%>
								<option value="<%= rs_dd.getString("DegreeName") %>" name="DegreeName" > <%= rs_dd.getString("DegreeName") %> </option>
								<%
											}
										} // close of while loop
									}// close of else statement
								%>
								</select>    
                                    
                                    
                            </td>
                            
                            <%-- Get the Title --%>
                            <td>
                                <input value="<%= rs.getString("RequirementDescription") %>" 
                                    name="RequirementDescription" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getInt("UnitsRequired") %>" 
                                    name="UnitsRequired" size="10">
                            </td>
                             
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="degree_requirement.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getString("DDUR_ID") %>" name="DDUR_ID">
							<input type="hidden" value="DegreeDetailedUnitRequirement" name="FormType">
                                
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
                    
            <%
                    }
            %>
            </table>
            </div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
             <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    rs = statement.executeQuery
                        ("SELECT * FROM DegreeDetailedCourseRequirement");
            %>
            <!-- Add an HTML table header row to format the results -->
            <div id="DegreeDetailedCourseRequirementTable">
            <h2>Degree Detailed Course Requirement</h2>	
                <table border="1" class="table table-bordered" >
                    <tr>
                        <th>ID</th>
                        <th>Degree Name</th>
                        <th>Course Name</th>
                    </tr>
            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    while ( rs.next() ) {
            %>

                    <tr>
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action="degree_requirement.jsp" method="get">
                            <input type="hidden" value="update" name="action">
							<input type="hidden" value="DegreeDetailedCourseRequirement" name="FormType">
                            <%-- Get the SSN --%>
                            <td>
                                <input type="hidden" value="<%= rs.getInt("DDCR_ID") %>" 
                                    name="DDCR_ID" size="10">
                                <%= rs.getInt("DDCR_ID") %>
                            </td>
    
                            <%-- Get the Name --%>
                            <td>
  								<select name="DegreeName">
            	
            					<%
            						Statement degreeStatement = conn.createStatement();
                        			ResultSet rs_dd = degreeStatement.executeQuery("SELECT * FROM Degree");
            						// if there is no entry in the Department table
									if (!rs_dd.isBeforeFirst() ) {    
								%>
											<option value="no degree" name="DegreeName" > There are no degrees </option>
								<% 
									}
									else{
		
										while(rs_dd.next()){
											if(rs_dd.getString("DegreeName").equals(rs.getString("DegreeName"))){
								%>
								<option value="<%= rs_dd.getString("DegreeName") %>" name="DegreeName" selected> <%= rs_dd.getString("DegreeName") %> </option>
								<% 
											}
											else{
								%>
								<option value="<%= rs_dd.getString("DegreeName") %>" name="DegreeName" > <%= rs_dd.getString("DegreeName") %> </option>
								<%
											}
										} // close of while loop
									}// close of else statement
								%>
								</select>    
                                    
                                    
                            </td>
                            
                            <%-- Get the Title --%>
                            <td>
                                <select name="CourseName">
            	
            					<%
            						Statement courseStatement = conn.createStatement();
                        			ResultSet rs_cc = courseStatement.executeQuery("SELECT * FROM Course");
            						// if there is no entry in the Department table
									if (!rs_cc.isBeforeFirst() ) {    
								%>
											<option value="no course" name="CourseName" > There are no courses </option>
								<% 
									}
									else{
		
										while(rs_cc.next()){
											if(rs_cc.getString("CourseName").equals(rs.getString("CourseName"))){
								%>
								<option value="<%= rs_cc.getString("CourseName") %>" name="CourseName" selected> <%= rs_cc.getString("CourseName") %> </option>
								<% 
											}
											else{
								%>
								<option value="<%= rs_cc.getString("CourseName") %>" name="CourseName" > <%= rs_cc.getString("CourseName") %> </option>
								<%
											}
										} // close of while loop
									}// close of else statement
								%>
								</select>  
                            </td>
                             
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <form action="degree_requirement.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            
                            <input type="hidden" 
                                value="<%= rs.getInt("DDCR_ID") %>" name="DDCR_ID">
							<input type="hidden" value="DegreeDetailedCourseRequirement" name="FormType">
                                
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
                    
            <%
                    }
            %>
            </table>
            </div>
            
            
            

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
