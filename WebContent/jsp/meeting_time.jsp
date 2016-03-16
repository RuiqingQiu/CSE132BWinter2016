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
	<h2>Enter Meeting Time For Sections in Current Quarter</h2>

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
                        Boolean insertWeeklyMeeting = false;
                        String meetingIDEntered = request.getParameter("MeetingID");
           
                        // same meeting id but not the same section id
                        PreparedStatement ps_cm = null;
                      	// select all the meetingID where seciondID is being deleted
              	  	  	String sql_cm= "SELECT * FROM ClassMeeting WHERE MeetingID = ?";
              	  
              	  	  	ps_cm = conn.prepareStatement(sql_cm);
              	  	  	ps_cm.setString(1, meetingIDEntered);
              	  	  	ResultSet allSection = ps_cm.executeQuery();
              	  	  	// empty set, new meeting id
              	  	  	if(!allSection.isBeforeFirst()){
              	  	  		insertWeeklyMeeting = true;
              	  	  	}else{
              	  	  		insertWeeklyMeeting = false;// don't insert into weekly meeting table
              	  	  	}
                        
              	  	 	PreparedStatement pstmt = null;
              	  	 	int rowCount = 0;
              	  	 
                        if(insertWeeklyMeeting){
               
	                        // INSERT into Weekly Meeting Table
	    				    pstmt = conn.prepareStatement(
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
	    				   for(int i = 0;i < daysSelected.length;i++){
	    					   //finalResult = finalResult.concat(daysSelected[i].substring(0,3));
	    					   finalResult = finalResult.concat(daysSelected[i]);
	    					   //System.out.println("daysSelected[i]" + daysSelected[i]);
	    				   }
	    				   pstmt.setString(5,finalResult);
	    				   pstmt.setString(6,request.getParameter("Time"));
	    				 
	    				   rowCount = pstmt.executeUpdate();
                      }
    				   
    				// INSERT into class Meeting Table	
  				    pstmt = conn.prepareStatement(
                       	"INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES (?, ?)");
  				  	pstmt.setString(1,request.getParameter("SectionID"));
  				   	pstmt.setString(2,meetingIDEntered);
  				   		
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
                    	
                    	  // Begin transaction
                        conn.setAutoCommit(false);
                        
                        
                        // Delete from CourseHasClass table first because FK constraint
                        PreparedStatement pstmt = conn.prepareStatement(
                                 "UPDATE WeeklyMeeting SET Type = ?, Location = ?, IsMandatory = ?, DayOfTheWeek = ?, Time = ? WHERE MeetingID = ?");
                        
                       
                        pstmt.setString(
                                 1, request.getParameter("MeetingType"));
                        pstmt.setString(
                                2, request.getParameter("Location"));
                        
                        if(request.getParameter("IsMandatory").equals("Yes")){
                        	pstmt.setBoolean(3,true);
                        }else{
                        	pstmt.setBoolean(3,false);
                        }
                       
                        // get all the values where name = DaysOfTheWeek
      				   String[] daysUpdated = request.getParameterValues("DayOfTheWeek");
      				   String result = "";
      				   for(int i = 0;i<daysUpdated.length;i++){
      					   //result = result.concat(daysUpdated[i].substring(0,3));
      					   result = result.concat(daysUpdated[i]);

      					  // result = result.concat(" ");
      				   }
      				   pstmt.setString(4,result);
      				   pstmt.setString(5,request.getParameter("Time"));
      				   pstmt.setString(6,request.getParameter("MeetingID"));
                             
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
                        
                        
                        // Delete from CourseHasClass table first because FK constraint
                        PreparedStatement pstmt = conn.prepareStatement(
                                 "DELETE FROM WeeklyMeeting WHERE MeetingID = ?");
                        
                        pstmt.setString(
                                 1, request.getParameter("MeetingID"));
                             
                       int rowCount = pstmt.executeUpdate();
                       
                       // Delete from CourseHasClass table first because FK constraint
                     	pstmt = conn.prepareStatement(
                                "DELETE FROM ClassMeeting WHERE SectionID = ? AND MeetingID = ?");
                       
                       pstmt.setString(
                                1, request.getParameter("SectionID"));
                       pstmt.setString(
                               2, request.getParameter("MeetingID"));
                            
                      rowCount = pstmt.executeUpdate();
                       
                     
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    } 
            %>	 
				<!-- Insert form starts here -->	 
				<form action="meeting_time.jsp" method="get">
                         <input type="hidden" value="insert" name="action">
                    <%
						Statement findSection = conn.createStatement();
                    	String currentQuarter = "Winter";
                    	String currentYear = "2016";
                    	// get all the sections in current quarter
						ResultSet rs_section = findSection.executeQuery
								("SELECT * FROM Classes WHERE Quarter= '" + currentQuarter + "' AND Year = '"+currentYear+"'");
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
									// Displaying SectionID + CourseName
									PreparedStatement ps = null;
                           	  		String sql = "SELECT * FROM CourseHasClass WHERE SectionID = ?";
                           	  
                           	  		ps = conn.prepareStatement(sql);
                           	  		ps.setString(1, rs_section.getString("SectionID"));
                         		   // retrieve all the valid meetingID for that seciondID
                           	  		ResultSet rs_cm = ps.executeQuery();
                         		    while(rs_cm.next()){
							%>	
									<option value="<%= rs_section.getString("SectionID") %>" name="SectionID" > <%= rs_section.getString("SectionID") +" : " + rs_cm.getString("CourseName") %> </option>
			            	<%
                         		    }
								} // close of while loop
							}// close of else statement
							%>
						</select><br>
                            
                        MeetingID: <input value="" name="MeetingID" size="10"><br>
                        MeetingType:<select name = "MeetingType">
            						<option value = ""></option>
            						<option value="Lecture">Lecture</option>
									<option value="Discussion">Discussion</option>
									<option value="Lab">Lab</option>
									</select><br>
						Location: <input value="" name="Location" size=10><br>
						IsMandatory:<select name="IsMandatory">
								<option value=""></option>
								<option>Yes</option>
								<option>No</option>
							</select><br>
						DayOfWeek:  
							<input type="checkbox" name="DayOfTheWeek" value="M">Monday
  							<input type="checkbox" name="DayOfTheWeek" value="Tue">Tuesday
  							<input type="checkbox" name="DayOfTheWeek" value="W">Wednesday
  							<input type="checkbox" name="DayOfTheWeek" value="Thu">Thursday
  							<input type="checkbox" name="DayOfTheWeek" value="F">Friday 
  							<br>
  						Time:<input value="" type="time" name="Time" size="10"><br>
                    
                            <input class="btn btn-default" type="submit" value="Insert">
                        </form><!-- End Of Insert form -->

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                    	<th>SectionID</th>
                        <th>MeetingID</th>
                        <th>Type</th>
                        <th>Location</th>
                        <th>IsMandatory</th>
                        <th>DayOfTheWeek</th>
                        <th>Time</th>
                        <th>Update</th>
                        <th>Delete</th>
                    </tr>
                   

            <%-- -------- Iteration Code -------- --%>
            <%
                   // Iterate over the ResultSet
                   // Create the statement
                    Statement statement = conn.createStatement();
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM WeeklyMeeting");
                    while (rs.next()) {
            %>

                   <tr> 
                       <%-- GET method read form data --%>
                       <form action=""meeting_time.jsp" method="get">
                           <input type="hidden" value="update" name="action">
                           <%
                           
                           		PreparedStatement ps = null;
                  	  			String sql = "SELECT * FROM ClassMeeting WHERE MeetingID = ?";
                  	  
                  	  			ps = conn.prepareStatement(sql);
                  	  			ps.setString(1, rs.getString("MeetingID"));
                		   		// retrieve all the valid meetingID for that seciondID
                  	  			ResultSet rs_cm = ps.executeQuery();
                           		
                		   	    while(rs_cm.next()){
                           %>
                           			<tr>
                            		<td>
                            		
                            		<input type="hidden" value="<%= rs_cm.getString("SectionID") %>" 
                          					name="SectionID" size="10"><%= rs_cm.getString("SectionID") %>
                            		</td>

                            		<%-- Get the MeetingID --%>
                            		<td>
                            		<input type="hidden" value= "<%= rs.getString("MeetingID") %>" 
                            			name="MeetingID" size="10"><%=rs.getString("MeetingID") %>
                                	
                           			 </td>
                           			 <td>
                           			 	<%
                          					String typeSelected = rs.getString("Type");
                          							
                          				%>
                                			<select name="MeetingType">
                            			  		<%
                            			  				if(typeSelected.equals("Lec")){
                            			  		 %>
                            			  			 	<option value="Lec" selected>Lecture</option>
                            			  			 	<option value="Dis">Discussion</option>
                            			  			 	<option value="Lab">Lab</option>
                            			  			 <%
                            			  				}else if(typeSelected.equals("Dis")){
                            			  			 %>
                            			  			 	<option value="Lec">Lecture</option>
                            			  			 	<option value="Dis" selected>Discussion</option>
                            			  			 	<option value="Lab">Lab</option>
                            			  			 <%
                            			  			 	}else{
                            			  			 %>
                            			  			 		<option value="Lec">Lecture</option>
                                			  			 	<option value="Dis" selected>Discussion</option>
                                			  			 	<option value="Lab" selected>Lab</option>
                            						<% 
                            			  			 	}
                            			  			 %>
                            			  	</select>
                            		</td>
                           			<td>
                                		<input value="<%= rs.getString("Location") %>" 
                                    		name="Location" size="10">
                            		</td>
                           			<td>
                                		<select name="IsMandatory">
                          							<%
                          							  if(rs.getBoolean("IsMandatory") == true){
                          							%>
                          							   <option value= "Yes" selected>Yes</option>
                          							   <option value= "No">No</option>
                          							<%
                          							  }else{
                          							%>
                          								<option value= "No" selected>No</option>
                          								<option value= "Yes">Yes</option>
                          							<%
                          							  }
                          							%>
                          				</select>	
                            		</td>
                            		
                            		<td>
                                		<% 
                          				 	String dayOfWeek = rs.getString("DayOfTheWeek");
                          					Boolean mon = false;
                          					Boolean tue = false;
                          					Boolean wed = false;
                          					Boolean thu = false;
                          					Boolean fri = false;
                          					
                          					String current = "";
                 							for(int i = 0;i< dayOfWeek.length();i++){
                 								current = current + dayOfWeek.charAt(i);
                 								//System.out.println("current " + current);
                 								//System.out.println(current.equals("M"));
                 								switch(current){
                 								case "M": 
                 									mon = true;
                 									current = "";
                 									break;
                 								case "W":
                 									wed = true;
                 									current = "";
                 									break;
                 								case "F":
                 									fri = true;
                 									current = "";
                 									break;
                 								case "Tue":
                 									tue = true;
                 									current = "";
                 									break;
                 								case "Thu":
                 									thu = true;
                 									current = "";
                 									break;
                 								default:
                 									//System.out.println("default");
                 									continue;
                 								} // end of switch statement
                 							}
                 						
                          					if(mon){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="M" checked>Monday<br>
                          					
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="M">Monday<br>
                          				<%
                          					}
                          					
                          					if(tue){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Tue" checked>Tuesday<br>
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Tue">Tuesday<br>
                          				<%
                          					}
                          					
                          					if(wed){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="W" checked>Wednesday<br>
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="W">Wednesday<br>
                          				<%
                          					}
                          					
                          					if(thu){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Thu" checked>Thursday<br>
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Thu">Thursday<br>
                          				<%
                          					}
                          					
                          					if(fri){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="F" checked>Friday<br>
                          				<%
                          					}else{
                          				%>	
                          					<input type="checkbox" name= "DayOfTheWeek" value="F">Friday<br>
                          				<%
                          					}
                          				%>      	
                            		</td>
                            		<td>
                                		<input value="<%= rs.getString("Time") %>" 
                                    		name="Time" size="10">
                           			 </td>
                           
                            		<%-- Button --%>
                            		<td>
                                		<input class="btn btn-default" type="submit" value="Update">
                            		</td>
                            	
                        
                    </form><!-- End of update form -->
                        
                    <!--  Begin delete form here -->
                    <form action="meeting_time.jsp" method="get">
                       <input type="hidden" value="delete" name="action">
                       <input type="hidden" 
                              value="<%= rs.getString("MeetingID") %>" name="MeetingID">  
                       <input type="hidden" 
                              value="<%= rs_cm.getString("SectionID") %>" name="SectionID">     
                         <%-- Button --%>
                         <td>
                              <input class="btn btn-default" type="submit" value="Delete">
                         </td>
                    </form><!-- End of delete form -->
                   </tr>
                   
                   <%
                		   	    }
                   %>
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
