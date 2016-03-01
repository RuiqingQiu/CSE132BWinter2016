<html>
<head>
	<title>Report 1B Display the roster of class Y</title>
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
      	<li><a href="report1a.jsp">Report1A</a></li>
     	<li><a href="report1b.jsp">Report1B</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>Report 1B, Display the roster of class Y</h2>

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

            <%-- -------- HTML Display Control Code -------- --%>
            <%
            		// request is a implicit object
                    String action = request.getParameter("action");
            		
            				
                    // Check if an insertion is requested
                    if (action != null && action.equals("query")) {

                        PreparedStatement pstmt = conn.prepareStatement
                        		("SELECT distinct s.StudentID, s.Name,s.SSN,s.ResidenceStatus,s.AcademicLevel,e.Units,e.GradeOption " +
                        				"FROM Classes c, StudentEnrollment e, Student s " +
                        				"WHERE e.SectionID = ? " +
                        				"AND e.StudentID = s.StudentID");
                        	
          
                        pstmt.setString(1, request.getParameter("SectionID")); 
 						
 						// Commit transaction
 						ResultSet rs = pstmt.executeQuery();
 						%>
 						<h2> Roster for class Y with SectionID: <%= request.getParameter("SectionID") %></h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>StudentID</th>
 	                        <th>Name</th>
 	                        <th>SSN</th>
 	                        <th>ResidenceStatus</th>
 	                        <th>AcademicLevel</th>
 	                        <th>Units</th>
 	                        <th>GradeOption</th>
 	                    </tr> 
 	                    <% 
 					
 
 						while(rs.next()){
 						%>
							<tr>
								<td><%= rs.getString("StudentID") %></td>
								<td><%= rs.getString("Name") %></td>
								<td><%= rs.getString("SSN") %></td>
								<td><%= rs.getString("ResidenceStatus") %></td>
								<td><%= rs.getString("AcademicLevel") %></td>
								<td><%= rs.getString("Units") %></td>
								<td><%= rs.getString("GradeOption") %></td>
								
							</tr>
						<% 
 						}
                    }
            %>
            
            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>SectionID</th>
                        <th>Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MaxEnrollment</th>
                        <th>Action</th>
                        
                    </tr>                   
                            <%
							Statement statement = conn.createStatement();
							ResultSet rs = statement.executeQuery
									("SELECT * FROM Classes;");
			            		// if there is no entry in the Department table
								if (!rs.isBeforeFirst() ) {    

								}
								else{
									while(rs.next()){
									 
									%>
									<tr>
									 <form action="report1b.jsp" method="get">
                      					<input type="hidden" value="query" name="action">
										<td><%= rs.getString("SectionID") %></td>
										<td><%= rs.getString("Title") %></td>
										<td><%= rs.getString("Quarter") %></td>
										<td><%= rs.getString("Year") %></td>
										<td><%= rs.getString("MaxEnrollment") %></td>
							
										<input type="hidden" value="<%= rs.getString("SectionID") %>" name="SectionID">
										<td><input class="btn btn-default" type="submit" value="Search"></td>
                        			</form>
									</tr>
									<% 
									}
								}// close of else statement
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
