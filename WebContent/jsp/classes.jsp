<html>
<head>
	<title>Class Entry Form</title>
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
    <table border="1" class="table table-bordered">
        <tr>
            <td>
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="../form_html/class_menu.html" />
                
            </td>
            
            <td>
            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="CSE132B.*" %>
            <%@ page language="java" import="java.io.*" %>
            
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
                	   Classes c = new Classes(
                  				request.getParameter("SectionID"),
                  				request.getParameter("Title"), 
                  				request.getParameter("Quarter"), 
                  				request.getParameter("Year"),
                  				Integer.parseInt(request.getParameter("MaxEnrollment")));
                	
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Classes table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Classes VALUES (?, ?, ?, ?, ?)");
                        
                        pstmt.setString(1, c.SectionID);
						pstmt.setString(2, c.Title);
						pstmt.setString(3, c.Quarter);
						pstmt.setString(4,c.year);
						pstmt.setInt(5,c.MaxEnrollment);
						
                        int rowCount = pstmt.executeUpdate();
                        
                       // INSERT into CourseHasClass table as well
                        pstmt = conn.prepareStatement(
                                "INSERT INTO CourseHasClass(CourseName,SectionID) VALUES (?, ?)");
                            
                            pstmt.setString(1, request.getParameter("CourseName"));
                            pstmt.setString(2,c.SectionID);
    					
    				   rowCount = pstmt.executeUpdate();
    				   
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
    				   for(int i = 0;i<daysSelected.length;i++){
    					   finalResult = finalResult.concat(daysSelected[i].substring(0,3));
    					   finalResult = finalResult.concat(" ");
    				   }
    				   pstmt.setString(5,finalResult);
    				   pstmt.setString(6,request.getParameter("Time"));
    				 
    				   rowCount = pstmt.executeUpdate();
    				   
    					// INSERT into Weekly Meeting Table	
   				    	pstmt = conn.prepareStatement(
                        	"INSERT INTO ClassMeeting(SectionID,MeetingID) VALUES (?, ?)");
   				  	 	pstmt.setString(1,request.getParameter("SectionID"));
   				   		pstmt.setString(2,request.getParameter("MeetingID"));
   				   		
   				   		rowCount = pstmt.executeUpdate();
   				   	
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
                        // UPDATE the student attributes in the Classes table.
                        // Can't update SectionID because it is PK

                       PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Classes SET Title = ?, Quarter = ?, Year = ?, MaxEnrollment = ? WHERE SectionID = ?"); 

                        
                        pstmt.setString(1, request.getParameter("Title"));
                        pstmt.setString(2,request.getParameter("Quarter"));  
                        pstmt.setString(3,request.getParameter("Year"));
                        pstmt.setInt(4,Integer.parseInt(request.getParameter("MaxEnrollment")));
                        pstmt.setString(5,request.getParameter("SectionID")); 
                         
                        int rowCount = pstmt.executeUpdate();
                        
                        // update CourseHasClass Table
                     	pstmt = conn.prepareStatement(
                                "UPDATE CourseHasClass SET CourseName = ?, SectionID = ? WHERE ID = ?"); 
                        
                       
                        pstmt.setString(1, request.getParameter("CourseName"));
                        pstmt.setString(2, request.getParameter("SectionID"));
                        pstmt.setInt(3,Integer.parseInt(request.getParameter("ID")));  
                        
                        rowCount = pstmt.executeUpdate();
                        
                        // Update WeeklyMeeting Table, MeetingID is PK
                     	pstmt = conn.prepareStatement(
                                "UPDATE WeeklyMeeting SET Type = ?, Location = ?, IsMandatory = ?, DayOfTheWeek = ?, Time = ? WHERE MeetingID = ?"); 
                        
                        pstmt.setString(1, request.getParameter("MeetingType"));
                        System.out.println("update state " + request.getParameter("MeetingType"));
                        pstmt.setString(2, request.getParameter("Location"));
                        System.out.println("manda " + request.getParameter("IsMandatory"));
                        if(request.getParameter("IsMandatory").equals("Yes")){
                        	 pstmt.setBoolean(3,true);  
                        }else{
                        	 pstmt.setBoolean(3,false); 
                        }
                        // get all the values where name = DaysOfTheWeek
     				   String[] daysUpdated = request.getParameterValues("DayOfTheWeek");
     				   String result = "";
     				   for(int i = 0;i<daysUpdated.length;i++){
     					   result = result.concat(daysUpdated[i].substring(0,3));
     					   result = result.concat(" ");
     				   }
     				   pstmt.setString(4,result);
     				   pstmt.setString(5,request.getParameter("Time"));
     				   pstmt.setString(6,request.getParameter("MeetingID"));
                    
                       rowCount = pstmt.executeUpdate();
                       
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
                                 "DELETE FROM CourseHasClass WHERE ID = ?");
                        
                        pstmt.setInt(
                                 1, Integer.parseInt(request.getParameter("ID")));
                             
                       int rowCount = pstmt.executeUpdate();
                       
                      PreparedStatement ps_delete = null;
                      // select all the meetingID where seciondID is being deleted
              	  	  String stat_delete = "SELECT * FROM ClassMeeting WHERE SectionID = ?";
              	  
              	  	  ps_delete = conn.prepareStatement(stat_delete);
              	  	  ps_delete.setString(1, request.getParameter("SectionID"));
            		  // retrieve all the valid meetingID for that seciondID
              	  	  ResultSet meeting_to_delete = ps_delete.executeQuery();
            		  ResultSet tmp = meeting_to_delete;
              		
                       // Delete from WeeklyMeeting table
                       while(meeting_to_delete.next()){
                    	   pstmt = conn.prepareStatement(
                                   "DELETE FROM ClassMeeting WHERE MeetingID = ? and SectionID = ?");
                    	   pstmt.setString(1,meeting_to_delete.getString("MeetingID"));
                    	   pstmt.setString(2,request.getParameter("MeetingID"));
                    	   rowCount = pstmt.executeUpdate();
                    	   
                    	   pstmt = conn.prepareStatement(
                                   "DELETE FROM WeeklyMeeting WHERE MeetingID = ?");
                    	   pstmt.setString(1,meeting_to_delete.getString("MeetingID"));
                    	   rowCount = pstmt.executeUpdate();
                       }
                       
                       // Delete from WeeklyMeeting table
                       /* 
                       while(tmp.next()){
                         
                       }
                       */
                   
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                       pstmt = conn.prepareStatement(
                            "DELETE FROM Classes WHERE SectionID = ?");

                       pstmt.setString(
                            1, request.getParameter("SectionID"));
                        
                        rowCount = pstmt.executeUpdate();
                 
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    } 
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                 // Create the statement
                Statement statement = conn.createStatement();
            
                // the student attributes FROM the Student table.
                ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Classes"); 
                
                // Select from CourseHasClass Table
                statement = conn.createStatement();
                ResultSet rs_cc = statement.executeQuery("SELECT * FROM CourseHasClass");
                
                // Select from Course Table
                statement = conn.createStatement();
                ResultSet rs_c = statement.executeQuery("SELECT * FROM Course");
                   
            %>
            
            <!-- Make the input box vertically listed -->
            <form action="classes.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				
            	SectionID: <input value="" name="SectionID" size="10"><br>
            	
            	<!-- Create a drop down for all course -->
            	CourseName: <select name="CourseName">
            	<%
            		// if there is no entry in the Course table
					if (!rs_c.isBeforeFirst() ) {    
				%>
					<option value="no course" name="CourseName" > There are no courses </option>
				<% 
				}
				else{
				%>
					<option value=""></option>
				<% 
					while(rs_c.next()){
				%>	
						<option value="<%= rs_c.getString("CourseName") %>" name ="CourseName" > <%= rs_c.getString("CourseName") %> </option>
            	<%
					} // close of while loop
				}// close of else statement
				%>
				</select><br> <!-- end of select course  -->
           
            	Title: <input value="" name="Title" size="10"><br>
            	Quarter: <input value="" name="Quarter" size="10"><br>
            	Year:<input value="" name="Year" size="10"><br>
            	MaxEnrollment:<input value="" name="MaxEnrollment" size="10"><br>
            	
            	MeetingID: <input value="" name="MeetingID" size="10"><br>
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
            	<input class="btn btn-default" type="submit" value="Add Meeting Time">
            </form>
            <a href="instructor.jsp">Click here to Add an Instructor</a>
            

            <!-- Add an HTML table header row to format the results -->
                <table border="1" class="table table-bordered">
                    <tr>
                    	<th></th>
                    	<th>MeetingID</th>
                    	<th>TypeOfMeeting</th>
                    	<th>MeetingLocation</th>
                    	<th>MeetingMandatory</th>
                    	<th width="100px">Which
                    	 Day Of The Week</th>
                    	<th>MeetingTime</th>
                        <th>SectionID</th>
                        <th>CourseName</th>
                        <th>Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>MaxEnrollment</th>
						<th>Action</th>
   
            <%-- -------- Iteration Code for displaying the result -------- --%>
            <%
                    // Iterate over the ResultSet
                    statement = conn.createStatement();
                    rs = statement.executeQuery
       					("SELECT * FROM Classes"); 
        
                    while ( rs.next() ) {
                    	int id_selected=0;
            %>
                  <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">
                            
                            <%--Display the CourseHasClass ID column in the table --%>
                            <td>
                            	 <%
                        			// Select from CourseHasClass Table
                         			statement = conn.createStatement();
                         			rs_cc = statement.executeQuery("SELECT * FROM CourseHasClass");   
                          
                            		// if there is no entry in the Department table
									if (!rs_cc.isBeforeFirst() ) {   
                            	%>
                            		<option value="no id" name="ID" > There are no IDs in the CourseHasClass table</option>
                            	<% 
								}
								else{
		
										while(rs_cc.next()){
											if(rs_cc.getString("SectionID").equals(rs.getString("SectionID"))){
												id_selected = rs_cc.getInt("ID");
								%>
                            		<input type="hidden" value="<%= rs_cc.getInt("ID") %>" name="ID" size="10">
                                	<%= rs_cc.getInt("ID") %>
                                <% 
									}
								%>						
            		<%
						} // close of while loop
					}// close of else statement
					%>
                    </td><!-- End of display CC ID -->
                           
                           		 <% 
                           	  		PreparedStatement ps = null;
                           	  		String sql = "SELECT * FROM ClassMeeting WHERE SectionID = ?";
                           	  
                           	  		ps = conn.prepareStatement(sql);
                           	  		ps.setString(1, rs.getString("SectionID"));
                         		   // retrieve all the valid meetingID for that seciondID
                           	  		ResultSet rs_cm = ps.executeQuery();
                           		
                           	  		// No meeting created yet for that class section
                           	  		// display six columns of empty info
                         			if(!rs_cm.isBeforeFirst()){
                         		
                         		%>
                         			<td><input type="hidden" value="<%= "No Meeting ID" %>" name="MeetingID" size="10"><%= "No Meeting ID" %></td>
                         			<td><input value="<%= "No MeetingType" %>" name="MeetingType" size="10"></td>
                         			<td><input value="<%= "No MeetingLocation" %>" name="Location" size="10"></td>
                         			<td><input value="<%= "No Info" %>" name="IsMandatory" size="10"></td>
                         			<td><input value="<%= "No DayOfTheWeek" %>" name="DayOfTheWeek" size="10"></td>
                         			<td><input value="<%= "No MeetingTime" %>" name="Time" size="10"></td>
                                <%    
                                	// else there has meeting session created for the class section
                         			}else{
                         				// rs_cm has all the meetingID mapping the sectionID
                         				while(rs_cm.next()){	
                         					ps = null;
                               	  			sql = "SELECT * FROM WeeklyMeeting WHERE MeetingID = ?";
                                     	  
                               	  			ps = conn.prepareStatement(sql);
                               	  			ps.setString(1, rs_cm.getString("MeetingID"));
                             		
                               	  			// should be one because MeetingID is the primary key of WeeklyMeeting table
                               	  			ResultSet rs_wm = ps.executeQuery();	
                               	  			while(rs_wm.next()){
                         		%>
                         				<td>
                         					<input type="hidden" value="<%= rs_wm.getString("MeetingID") %>" 
                          						name="MeetingID" size="10"><%= rs_wm.getString("MeetingID") %>
                          				</td>
                          				<td>
                          						<%
                          							String typeSelected = rs_wm.getString("Type");
                          							System.out.println("meeting type is " + rs_wm.getString("Type"));
                          						%>
                            			  		<select name="MeetingType">
                            			  			<%
                            			  				if(typeSelected.equals("Lecture")){
                            			  			 %>
                            			  			 	<option value="Lecture" selected>Lecture</option>
                            			  			 	<option value="Discussion">Discussion</option>
                            			  			 <%
                            			  				}else{
                            			  			 %>
                            			  			 	<option value="Lecture">Lecture</option>
                            			  			 	<option value="Discussion" selected>Discussion</option>
                            			  			 <%
                            			  			 	}
                            			  			 %>
                            			  		</select>
                          					</td>
                          					
                          					<td>
                            			  		<input value="<%= rs_wm.getString("Location") %>" 
                          						name="Location" size="10">
                          					</td>
                          					
                          					<td>
                          						<select name="IsMandatory">
                          							<%
                          							  if(rs_wm.getBoolean("IsMandatory") == true){
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
                          			
                          				<td class="span4">
                          				<% 
                          				 	String dayOfWeek = rs_wm.getString("DayOfTheWeek");
                          					String split[]= dayOfWeek.split("\\s+");
                          					Boolean mon = false;
                          					Boolean tue = false;
                          					Boolean wed = false;
                          					Boolean thu = false;
                          					Boolean fri = false;
                          					
                          					for(int j = 0;j<split.length;j++){
                          						switch(split[j]){
                          							case "Mon": mon = true;break;
                          							case "Tue": tue = true;break;
                          							case "Wed": wed = true;break;
                          							case "Thu": thu = true;break;
                          							case "Fri": fri = true;break;
                          							default: 
                          								System.out.println("DefaultCase " + split[j]);
                          								break;	
                          						}// end of switch statement
                          					}// end of for loop	
                          					
                          					if(mon){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Monday" checked>Monday<br>
                          					
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Monday">Monday<br>
                          				<%
                          					}
                          					
                          					if(tue){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Tuesday" checked>Tuesday<br>
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Tuesday">Tuesday<br>
                          				<%
                          					}
                          					
                          					if(wed){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Wednesday" checked>Wednesday<br>
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Wednesday">Wednesday<br>
                          				<%
                          					}
                          					
                          					if(thu){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Thursday" checked>Thursday<br>
                          				<%
                          					}else{
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Thursday">Thursday<br>
                          				<%
                          					}
                          					
                          					if(fri){
                          				%>
                          					<input type="checkbox" name= "DayOfTheWeek" value="Friday" checked>Friday<br>
                          				<%
                          					}else{
                          				%>	
                          					<input type="checkbox" name= "DayOfTheWeek" value="Friday">Friday<br>
                          				<%
                          					}
                          				%>      	
                          				</td>
                          				<td>
                          					 <input type="time" value="<%= rs_wm.getString("Time") %>" 
                                    		name="Time" size="10">		
                          				</td>		
            		<%
                               	  			}// end of while rs_wm has next
						} // close of while loop
					}// close of else statement
					%>   	
                    <!-- End of displaying Meeting info-->
                            
                             
                             <%-- Get the SectionID, which is the PK --%>
                            <td>
              				 	<input type="hidden" value="<%= rs.getString("SectionID") %>" name="SectionID" size="10">
                                <%= rs.getString("SectionID") %>
                            </td> 
                 <td>  
                  	<select name="CourseName">
            		<%
						statement = conn.createStatement();
						rs_cc = statement.executeQuery
					   	 ("SELECT * FROM CourseHasClass");
					
            			// if there is no entry in the Course table
						if (!rs_cc.isBeforeFirst() ) {    
					%>
						<option value="no course class relationship" name="CourseName" > There are no course has class relationship</option>
					<% 
						}
						else{
							String courseNameSelected = "";
							while(rs_cc.next()){
								if(rs_cc.getString("SectionID").equals(rs.getString("SectionID"))){		
									courseNameSelected = rs_cc.getString("CourseName");
									break;
								}// end of IF finding same SectionID
							}// end of while 
								
							statement = conn.createStatement();
							rs_c = statement.executeQuery
						   	 ("SELECT * FROM Course");
							
							// if there is no entry in the Course table
							if (!rs_c.isBeforeFirst() ) {  
					%>
								<input value="no course" name="CourseName"> There are no course</option>
					<% 
							} // end of if checking empty result set
							while(rs_c.next()){
								if(rs_c.getString("CourseName").equals(courseNameSelected)){				
					%>	
							<option value="<%= rs_c.getString("CourseName") %>" selected> <%= rs_c.getString("CourseName") %> </option>
            		<%
							}else{
					%>
							<option value="<%= rs_c.getString("CourseName") %>"> <%= rs_c.getString("CourseName") %> </option>
            		<%	
							}// close of else statement 
						} // close of while loop
					}// close of else statement
					%>
					</select>             
        		 </td>
                            <%-- Get the title --%>
                            <td>
                              <input value="<%= rs.getString("Title") %>" 
                                    name="Title" size="10">
                            </td> 
                            
                            <%-- Get the Quarter --%>
                            <td>
                                <input value="<%= rs.getString("Quarter") %>" 
                                    name="Quarter" size="10">
                            </td>
                           
                            <%-- Get the Year --%>
                           <td>
                                <input value="<%= rs.getString("Year") %>" 
                                    name="Year" size="10">
                            </td> 
                            
                            <%-- Get the MaxEnrollment --%>
                           <td>
                                <input value="<%= rs.getInt("MaxEnrollment") %>" 
                                    name="MaxEnrollment" size="10">
                            </td> 
                
                            <%-- Button --%>
                            <td>
                                <input class="btn btn-default" type="submit" value="Update">
                            </td>
                        </form>
                        
                        <!--  Begin delete form here -->
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("SectionID") %>" name="SectionID"> 
                            <input type="hidden" 
                                value="<%= id_selected %>" name="ID">
                          
                                
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
