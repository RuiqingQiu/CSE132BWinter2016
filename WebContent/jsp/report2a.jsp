<html>
<head>
	<title>Report 2A Assist a student X in producing his class schedule</title>
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
	<h2>Report 2A, Assist a student X in producing his class schedule</h2>

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
                    	 Statement stmt = conn.createStatement();
                    	 String StudentID = request.getParameter("StudentID");
                     	 stmt.executeUpdate(
                     			"CREATE OR REPLACE VIEW CurrentSchedule AS( "+
                     					"SELECT s.SectionID,w.DayOfTheWeek,w.Time,cl.Title,h.CourseName "+
                     					"FROM StudentEnrollment s, ClassMeeting c, WeeklyMeeting w, Classes cl,CourseHasClass h "+
                     					"WHERE s.StudentID = " + "'" + StudentID + "'" + " AND s.SectionID = c.SectionID AND w.MeetingID = c.MeetingID " +
                     					"AND cl.SectionID = s.SectionID AND h.SectionID = s.SectionID)");

                        PreparedStatement pstmt = conn.prepareStatement(
                        		"Select c.SectionID AS s1,c.Title AS t1,c.CourseName AS c1,c.DayOfTheWeek AS d1,c.Time as m1,m.SectionID AS s2,h.CourseName AS c2,s.Title AS t2,w.DayOfTheWeek AS d2,w.Time AS m2 " + 
                        		"FROM CurrentSchedule c, ClassMeeting m, WeeklyMeeting w, Classes s,CourseHasClass h " +
                        		"WHERE c.SectionID <> m.SectionID AND s.SectionID = m.SectionID AND s.Title not in (Select title from CurrentSchedule) "+
                        		"AND m.MeetingID = w.MeetingID AND w.DayOfTheWeek = c.DayOfTheWeek AND w.Time = c.Time " +  
                        		"AND s.SectionID = m.SectionID AND h.SectionID = s.SectionID");		
 						
 						// Commit transaction
 						ResultSet rs = pstmt.executeQuery();
 						%>
 						<h2>Conflict Schedule for Student X with StudentID: <%= request.getParameter("StudentID") %></h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>EnrolledSectionID</th>
 	                        <th>EnrolledClassTitle</th>
 	                        <th>EnrolledCourseName</th>
 	                        <th>EnrolledClassDayOfTheWeek</th>
 	                        <th>EnrolledClassTime</th>
 	                        <th>ConflictSectionID</th>
 	                        <th>ConflictClassTitle</th>
 	                        <th>ConflictCourseName</th>
 	                        <th>ConflictClassDayOfTheWeek</th>
 	                        <th>ConflictClassTime</th>
 	                    </tr> 
 	                    <% 
 					
 						while(rs.next()){
 						%>
							<tr>
								<td><%= rs.getString("s1") %></td>
								<td><%= rs.getString("t1") %></td>
								<td><%= rs.getString("c1") %></td>
								<td><%= rs.getString("d1") %></td>
								<td><%= rs.getString("m1") %></td>
								<td><%= rs.getString("s2") %></td>
								<td><%= rs.getString("t2") %></td>
								<td><%= rs.getString("c2") %></td>
								<td><%= rs.getString("d2") %></td>
								<td><%= rs.getString("m2") %></td>
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
									 <form action="report2a.jsp" method="get">
                      					<input type="hidden" value="query" name="action">
										<td><%= rs.getString("SSN") %></td>
										<td><%= rs.getString("StudentID") %></td>
										<td><%= rs.getString("Name") %></td>
										<input type="hidden" value="<%= rs.getString("StudentID") %>" name="StudentID">
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
