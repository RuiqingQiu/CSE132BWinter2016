<html>
<head>
	<title>Report 1A</title>
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
      	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>Report 1A, Display classes taken by Student X</h2>

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
                    if (action != null && action.equals("query")) {

                        PreparedStatement pstmt = conn.prepareStatement(
                        	"SELECT a.SectionID,a.Title,a.Year,a.Quarter,a.MaxEnrollment,b.Units FROM " +
                            	"(SELECT c.SectionID,c.Title,c.Quarter,c.Year,c.MaxEnrollment " +
                            	"FROM Classes c " +
                            	"WHERE c.Quarter = 'Spring' and c.Year = '2009' "+
                            			"and c.SectionID in " +
                            					"(SELECT a.SectionID " +
                            					   	"FROM AcademicHistory a " +
                            					    "WHERE a.StudentID in " +
                            						"(SELECT StudentID " +
                            						"FROM Student " +
                            						"WHERE SSN = ?))) a " +
                            "INNER JOIN " +
                            	"(SELECT a.SectionID, a.Units " +
                            	"FROM AcademicHistory a " +
                            	"WHERE a.StudentID in (SELECT StudentID " +
                            			      "FROM Student " +
                            			      "WHERE SSN = ?)) b " +
                            "ON a.SectionID = b.SectionID")
                            ;
                        		
                        		
                        pstmt.setString(1, request.getParameter("SSN")); 
                        pstmt.setString(2, request.getParameter("SSN")); 		
 						
 						// Commit transaction
 						ResultSet rs = pstmt.executeQuery();
 						%>
 						<h2>Classes taken by Student with SSN: <%= request.getParameter("SSN") %></h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>SectionID</th>
 	                        <th>Title</th>
 	                        <th>Year</th>
 	                        <th>Quarter</th>
 	                        <th>MaxEnrollment</th>
 	                        <th>Units</th>
 	                    </tr> 
 	                    <% 
 						
 						
 						while(rs.next()){
 						%>
							<tr>
								<td><%= rs.getString("SectionID") %></td>
								<td><%= rs.getString("Title") %></td>
								<td><%= rs.getString("Year") %></td>
								<td><%= rs.getString("Quarter") %></td>
								<td><%= rs.getString("MaxEnrollment") %></td>
								<td><%= rs.getString("Units") %></td>
								
							</tr>
						<% 
 						}
                    }
            %>
            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>Student SSN</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Action</th>
                    </tr>                   
                            <%
							Statement statement = conn.createStatement();
							ResultSet rs = statement.executeQuery
									("SELECT s.SSN, s.StudentID, s.Name FROM PeriodOfAttendence p, Student s WHERE isCurrentStudent = true and s.StudentID = p.StudentID;");
			            		// if there is no entry in the Department table
								if (!rs.isBeforeFirst() ) {    

								}
								else{
									while(rs.next()){
									 
									%>
									<tr>
									 <form action="report1a.jsp" method="get">
                      					<input type="hidden" value="query" name="action">
										<td><%= rs.getString("SSN") %></td>
										<td><%= rs.getString("StudentID") %></td>
										<td><%= rs.getString("Name") %></td>
										<input type="hidden" value="<%= rs.getString("SSN") %>" name="SSN">
										<td><input class="btn btn-default" type="submit" value="Search"></td>
                        			</form>
									</tr>
									<% 
									}
								}// close of else statement
							%>
                            
                     

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                     // Create the statement
                    statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    rs = statement.executeQuery
                        ("SELECT * FROM Instructor");
                    while (rs.next() ) {
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
