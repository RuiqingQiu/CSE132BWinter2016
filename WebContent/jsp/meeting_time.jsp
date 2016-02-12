<html>
<head>
	<title>Meeting Time Form</title>
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
	<h2>Enter Meeting Time For Classes</h2>

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

                        conn.setAutoCommit(false);
                        
               
                        // INSERT into Weekly Meeting Table
    				    PreparedStatement pstmt = conn.prepareStatement(
                         "INSERT INTO WeeklyMeeting(MeetingID,Type,Location,IsMandatory,DayOfTheWeek,Time) VALUES (?, ?, ?, ?, ?, ?)");
    				   
                        pstmt.setString(1,request.getParameter("MeetingID"));
    				  		 pstmt.setString(2,request.getParameter("MeetingType"));
    				   pstmt.setString(3,request.getParameter("Location"));
    				   if(request.getParameter("IsMandatory").equals("Yes")){
    					   pstmt.setBoolean(4,true);
    				   }else{
    					   pstmt.setBoolean(4,false);
    				   }
    				   
    				   // get all the values where name = DaysOfTheWeek
    				   String[] daysSelected = request.getParameterValues("DayOfTheWeek");
    				   String finalResult = "";
    				   for(int i = 0;i<daysSelected.length;i++){
    					   finalResult = finalResult.concat(daysSelected[i].substring(0,3));
    					   finalResult = finalResult.concat(" ");
    				   }
    				   pstmt.setString(5,finalResult);
    				   pstmt.setString(6,request.getParameter("Time"));
    				 
    				   int rowCount = pstmt.executeUpdate();
    				   
    					// INSERT into Weekly Meeting Table	
   				    	pstmt = conn.prepareStatement(
                        	"INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES (?, ?)");
   				  	 	pstmt.setString(1,request.getParameter("SectionID"));
   				   		pstmt.setString(2,request.getParameter("MeetingID"));
   				   		
   				   		rowCount = pstmt.executeUpdate();
   				   	
                    
                        
// commit transactions
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

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
                            "DELETE FROM HasMajor WHERE StudentID = ? and MajorName = ?");

                        pstmt.setString(1, request.getParameter("StudentID")); 
                        pstmt.setString(2, request.getParameter("MajorName")); 		

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>
 <form action="meeting_time.jsp" method="get">
                         <input type="hidden" value="insert" name="action">
                     
                            <%
							Statement findSection = conn.createStatement();
							ResultSet rs_section = findSection.executeQuery
									("SELECT * FROM Classes");
							%>
			               SectionID:<select name="SectionID">
			            	<%
			            		// if there is no entry in the Department table
								if (!rs_section.isBeforeFirst() ) {    
							%>
								<option value="no section" name="SectionID" > There are no sections</option>
							<% 
							}
							else{
							%>
								<option value="" ></option>
							<% 	
								while(rs_section.next()){
							%>	
								<option value="<%= rs_section.getString("SectionID") %>" name="SectionID" > <%= rs_section.getString("SectionID") %> </option>
			            	<%
								} // close of while loop
							}// close of else statement
							%>
							</select>
                            
                             MeetingID: <input value="" name="MeetingID" size="10">
                             MeetingType:<select name = "MeetingType">
            						<option value = ""></option>
            						<option value="Lecture">Lecture</option>
									<option value="Discussion">Discussion</option>
									</select><br>
							Location: <input value="" name="Location" size=10><br>
							IsMandatory:<select name="IsMandatory">
								<option value=""></option>
								<option>Yes</option>
								<option>No</option>
							</select><br>
				DayOfWeek:  
					<input type="checkbox" name="DayOfTheWeek" value="Monday">Monday
  					<input type="checkbox" name="DayOfTheWeek" value="Tuesday">Tuesday
  					<input type="checkbox" name="DayOfTheWeek" value="Wednesday">Wednesday
  					<input type="checkbox" name="DayOfTheWeek" value="Thursday">Thursday
  					<input type="checkbox" name="DayOfTheWeek" value="Friday">Friday
  					<br>
  				Time:<input value="" type="time" name="Time" size="10"><br>
                             
                     
                            
                            <input class="btn btn-default" type="submit" value="Insert">
                        </form>

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>MeetingID</th>
                        <th>Type</th>
                        <th>Location</th>
                        <th>IsMandatory</th>
                        <th>DayOfTheWeek</th>
                        <th>Time</th>
                    </tr>
                    <tr>
                       
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                     // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM WeeklyMeeting");
                    while (rs.next() ) {
            %>

                    <tr>
                    	<%--need to update person table if faculty name changes --%>
                        
                        <%-- GET method read form data --%>
                        <form action=""meeting_time.jsp" method="get">
                            <input type="hidden" value="delete" name="action">

                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getString("MeetingID") %>" 
                                    name="MeetingID" size="10">
                            </td>
                            <td>
                                <input value="<%= rs.getString("Type") %>" 
                                    name="Type" size="10">
                            </td><td>
                                <input value="<%= rs.getString("Location") %>" 
                                    name="Location" size="10">
                            </td><td>
                                <input value="<%= rs.getBoolean("IsMandatory") %>" 
                                    name="IsMandatory" size="10">
                            </td><td>
                                <input value="<%= rs.getString("DayOfTheWeek") %>" 
                                    name="DayOfTheWeek" size="10">
                            </td><td>
                                <input value="<%= rs.getString("Time") %>" 
                                    name="Time" size="10">
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
