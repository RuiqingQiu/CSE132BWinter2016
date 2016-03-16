<html>
<head>
	<title>Report 3b</title>
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
     	<li><a href="report1c.jsp">Report1C</a></li>
     	<li><a href="report1d.jsp">Report1D</a></li>
     	<li><a href="report1e.jsp">Report1E</a></li>
     	<li><a href="report2a.jsp">Report2A</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>Report 3b</h2>

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
                    	 String CourseName = request.getParameter("CourseName");
                    	 String FacultyName = request.getParameter("FacultyName");
						
                        PreparedStatement pstmt = conn.prepareStatement(
                        		"Select * from CPG " + 
                        		" where CourseName = '" + CourseName + "' and FacultyName = '" + FacultyName + "' " +
                        		"Order by Grade;"
                        		);		
 						// Commit transaction
 						ResultSet rs = pstmt.executeQuery();
 						%>
 						<h2>Grade Distribution</h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>Counts</th>
 	                        <th>Letter</th>
 	                        
 	                    </tr> 
 	                    <% 
 					
 						while(rs.next()){
 						%>
							<tr>
								<td><%= rs.getString("GradeCount") %></td>
								<td><%= rs.getString("Grade") %></td>
								
							</tr>
						<% 
 						}
                    }
            %>
            
            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                      
                    </tr>                   
                            <%
							Statement statement = conn.createStatement();
							ResultSet rs = statement.executeQuery
									("SELECT * FROM Faculty;");
							Statement s1 = conn.createStatement();
							ResultSet c_rs = s1.executeQuery
									("SELECT * FROM Course;"); 
			            		
							%>
									<tr>
									 <form action="milestone5_3b.jsp" method="get">
                      					<input type="hidden" value="query" name="action">
										<label>Faculty Name : </label><select name="FacultyName">
										<%
											// if there is no entry in the Department table
											if (!rs.isBeforeFirst() ) { 
					
											}
											else{
										%>
												<option value="" ></option>
										<% 
												while(rs.next()){
										%>
												<option value="<%= rs.getString("Name") %>" >  <%= "Name : " + rs.getString("Name") +" , "+ "Title: " +  rs.getString("Title") %> </option>
										<%
												}// end of while rs.next
											}// end of else 
										%>	
										</select><br>
										
										<label>Course Name : </label><select name="CourseName">
										<%
											// if there is no entry in the Department table
											if (!c_rs.isBeforeFirst() ) { 
					
											}
											else{
										%>
												<option value="" ></option>
										<% 
												while(c_rs.next()){
										%>
												<option value="<%= c_rs.getString("CourseName") %>" >  <%= "Course Name : " + c_rs.getString("CourseName") %> </option>
										<%
												}// end of while rs.next
											}// end of else 
										%>	
										<input class="btn btn-default" type="submit" value="Calculate">
										
                        			</form>
									</tr>
									<% 
								
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
