<html>
<head>
	<title>Report 2B Assist a professor X in scheduling a review session for a section Y</title>
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
     	<li><a href="report2b.jsp">Report2B</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>Report 2B Assist a professor X in scheduling a review session for a section Y</h2>

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
                    	 String SectionID = request.getParameter("SectionID");
                    	 String FacultyName = request.getParameter("FacultyName");
                     	 stmt.executeUpdate(
                     			"CREATE OR REPLACE VIEW EnrolledStudent AS( " +
											"SELECT s.StudentID "+
											"FROM StudentEnrollment s "+
											"WHERE s.SectionID = '" + SectionID + "');");
                     	 
				
                         PreparedStatement pstmt = conn.prepareStatement(
                        		"Select s.StudentID,s.SectionID,w.DayOfTheWeek,w.Time " + 
								"From EnrolledStudent e, StudentEnrollment s,ClassMeeting c,WeeklyMeeting w " + 
								"WHERE e.StudentID = s.StudentID AND c.SectionID = s.SectionID AND c.MeetingID = w.MeetingID " +
								"UNION " +
								"SELECT i.FacultyName,c.SectionID,w.DayOfTheWeek, w.Time "+ 
								"FROM Instructor i, ClassMeeting c,WeeklyMeeting w " +
								"WHERE i.FacultyName = 'Kelly Clarkson' AND i.SectionID = c.SectionID AND c.MeetingID = w.MeetingID;");	
 						
 						// Commit transaction
 						ResultSet rs = pstmt.executeQuery();
 						
 						int[] mon = new int[12];
 						int[] tue = new int[12];
 						int[] wed = new int[12];
 						int[] thu = new int[12];
 						int[] fri = new int[12];
 						
 						if (!rs.isBeforeFirst() ) {    
 							System.out.println("no data");
						}
 						
 						while(rs.next()){
 							System.out.println("again");
 							String tmp = rs.getString("DayOfTheWeek");
 							String time = rs.getString("Time");
 							int ind = time.indexOf(":");
 							//System.out.println("ind is " + ind);
 							// this is the time
 							int t = Integer.parseInt(time.substring(0,ind));
 							System.out.println("num part is "+ t);
 							String s = time.substring(time.length()-2,time.length());
 							System.out.println("s is "+ s);
 							
 							if(s.equals("PM")){
 								if(t != 12){
 									System.out.println("enter +12");
 									t = t + 12; // convert to 24 hour format
 								}
 							}
 							System.out.println("final time is "+ t);
 							// index of the day array for the time specified
 							int index = t-8;// 8AM - 8PM
 							System.out.println("index " + index);	
 									
 							String current = "";
 							System.out.println("tmp is " + tmp);
 							for(int i = 0;i< tmp.length();i++){
 								current = current + tmp.charAt(i);
 								System.out.println("current " + current);
 								//System.out.println(current.equals("M"));
 								switch(current){
 								case "M": 
 									mon[index] = 1;
 									System.out.println("Here Mon");
 									current = "";
 									break;
 								case "W":
 									wed[index] = 1;
 									current = "";
 									break;
 								case "F":
 									fri[index] = 1;
 									current = "";
 									break;
 								case "Tue":
 									tue[index] = 1;
 									current = "";
 									break;
 								case "Thu":
 									thu[index] = 1;
 									current = "";
 									break;
 								default:
 									System.out.println("default");
 									continue;
 								} // end of switch statement
 							}
 						}
 						
 						%>
 						<h2>Available Review Session Time for SectionID : <%= request.getParameter("SectionID") %></h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>DayOfTheWeek</th>
 	                        <th>Time</th>
 	                    </tr> 
 	                    <% 
 	                    for(int i = 0;i< mon.length;i++){
 	                    	// nothing scheduled
 	                    	if(mon[i] ==0){
 	       
 	                    %>
 	                    		<tr>
									<td><%= "Monday" %></td>
						<%
										if(i+9 < 12){
						%>			
									<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 AM" %></td>
						<%
										}else if(i+9 == 12){
						%>	
											<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 PM" %></td>
						<% 
									}else{
										if(i+8 == 12){
						%>
											<td><%= Integer.toString(i+8) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
						<%
										}else{
						%>
											<td><%= Integer.toString(i+8-12) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
						<% 			
										}
								}
						%>
							   </tr>
							   
							   
						<% 
 	                    	}
 	                    }

 	                   for(int i = 0;i< tue.length;i++){
	                    	// nothing scheduled
	                    	if(tue[i] ==0){
	                    %>
	                    		<tr>
									<td><%= "Tuesday" %></td>
						<%
										if(i+9 < 12){
						%>			
									<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 AM" %></td>
						<%
										}else if(i+9 == 12){
						%>	
											<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 PM" %></td>
						<% 
									}else{	if(i+8 == 12){
										%>
										<td><%= Integer.toString(i+8) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
					<%
										}else{
					%>
										<td><%= Integer.toString(i+8-12) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
						<% 			
										}
									}
						%>
							   </tr>
	                    <% 
	                  		}
	                    }
 	                   
 	                  for(int i = 0;i< wed.length;i++){
	                    	// nothing scheduled
	                    	if(wed[i] ==0){
	                   %>
		                    		<tr>
										<td><%= "Wednesday" %></td>
										<%
										if(i+9 < 12){
						%>			
									<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 AM" %></td>
						<%
										}else if(i+9 == 12){
						%>	
											<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 PM" %></td>
						<% 
									}else{	if(i+8 == 12){
										%>
										<td><%= Integer.toString(i+8) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
					<%
									}else{
					%>
										<td><%= Integer.toString(i+8-12) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
						<% 			
										}
									}
						%>
								   </tr>
		                  <% 
	                    	}
 	                  }
 	                  
 	                 for(int i = 0;i< thu.length;i++){
	                    	// nothing scheduled
	                    	if(thu[i] ==0){
	                    %>		
	                    		<tr>
									<td><%= "Thursday" %></td>
									<%
										if(i+9 < 12){
						%>			
									<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 AM" %></td>
						<%
										}else if(i+9 == 12){
						%>	
											<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 PM" %></td>
						<% 
									}else{	if(i+8 == 12){
										%>
										<td><%= Integer.toString(i+8) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
					<%
										}else{
					%>
										<td><%= Integer.toString(i+8-12) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
						<% 			
										}
									}
						%>
							   </tr>
						<% 
	                    	}
 	                 }
 	                for(int i = 0;i< fri.length;i++){
                    	// nothing scheduled
                    	if(fri[i] ==0){
                    %>
                    		<tr>
								<td><%= "Friday" %></td>
								<%
										if(i+9 < 12){
						%>			
									<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 AM" %></td>
						<%
										}else if(i+9 == 12){
						%>	
											<td><%= Integer.toString(i+8) + ":00 AM" + "-" + Integer.toString(i+9) + ":00 PM" %></td>
						<% 
									}else{	if(i+8 == 12){
										%>
										<td><%= Integer.toString(i+8) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
					<%
										}else{
					%>
										<td><%= Integer.toString(i+8-12) + ":00 PM" + "-" + Integer.toString(i+9-12) + ":00 PM" %></td>
						<% 			
										}
									}
						%>
					   		</tr>
					<% 
                    	}
 	                }
 	              
 	          } // end of it query
 	        %>
 	                    
 	                    

            	
               
                <table border="1" class="table table-bordered">
                 <caption>All sections in current quarter</caption>
                    <tr>
                        <th>SectionID</th>
                        <th>CourseName</th>
                        <th>Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MaxEnrollment</th>
                        <th>Action</th>
                    </tr>                   
                            <%
							Statement statement = conn.createStatement();
							ResultSet rs = statement.executeQuery
									("Select c.SectionID,h.CourseName,c.Title,c.Quarter,c.Year,c.MaxEnrollment " +
											"From Classes c, CourseHasClass h "+
											"WHERE c.Quarter='Winter' AND c.Year='2016' AND h.SectionID = c.SectionID;");
							
							
							
			            		// if there is no entry in the Department table
								if (!rs.isBeforeFirst() ) {    

								}
								else{
									while(rs.next()){
									 
									%>
									<tr>
									 <form action="report2b.jsp" method="get">
                      					<input type="hidden" value="query" name="action">
										<td><%= rs.getString("SectionID") %></td>
										<td><%= rs.getString("CourseName") %></td>
										<td><%= rs.getString("Title") %></td>
										<td><%= rs.getString("Quarter") %></td>
										<td><%= rs.getString("Year") %></td>
										<td><%= rs.getString("MaxEnrollment") %></td>
										<td>
										<label>Faculty Name : </label>
										<select name="FacultyName">
										<%
											// if there is no entry in the Department table
											Statement s = conn.createStatement();
											ResultSet f_rs = s.executeQuery
											("SELECT * FROM Faculty;");
											if (!f_rs.isBeforeFirst() ) { 
					
											}
											else{
										%>
												<option value="" ></option>
										<% 
												while(f_rs.next()){
										%>
												<option value="<%= f_rs.getString("Name") %>" >  <%= "Name : " + f_rs.getString("Name") +" , "+ "Title: " +  f_rs.getString("Title") %> </option>
										<%
												}// end of while rs.next
											}// end of else 
										%>	
										</select><br></td>
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
