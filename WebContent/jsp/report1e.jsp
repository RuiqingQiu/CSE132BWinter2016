<html>
<head>
	<title>Report 1e</title>
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
     	<li><a href="#">Report</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>Report 1E, Master Student X find remaining degree requirements for a MS in Y</h2>

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
                        
                        PreparedStatement pstmt = conn.prepareStatement(
                        		"Select a.StudentID, d.DegreeName,(d.TotalUnitsRequired-sum(a.Units)) AS UnitsLeftToTake "+ 
                        		"From AcademicHistory a, Degree d "+
                        		"Where a.StudentID in (Select StudentID from Student where SSN = ? ) "+ 
                        				"AND d.DegreeName = ? "+
                        		"GROUP BY a.StudentID,d.DegreeName;");
                        
                        pstmt.setString(1,request.getParameter("SSN"));
                        pstmt.setString(2,request.getParameter("DegreeName"));
                        
                        ResultSet rs = pstmt.executeQuery();
 					
 						%>
 						<h2> Total Units Left To Take for Student X with SSN : <%= request.getParameter("SSN") %></h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>StudentID</th>
 	                        <th>DegreeName</th>
 	                        <th>TotalUnitsLeftToTake</th>
 	                    </tr> 
 	                    <% 
 					
 						while(rs.next()){
 						%>
							<tr>
								<td><%= rs.getString("StudentID") %></td>
								<td><%= rs.getString("DegreeName") %></td>
								<td><%= rs.getInt("UnitsLeftToTake") %></td>
							</tr>
						<% 
 						}
 	                   %>
 	                    </table>
 	                    
 	       			 <h2>Concentrations completed by Student X with SSN: <%= request.getParameter("SSN") %>
 	       			 		in Degree: <%= request.getParameter("DegreeName") %>
 	       			 </h2>
 	       			 <table border="1" class="table table-bordered">
 	       	              <tr>
 	       	                  <th>Concentration Completed</th>
 	       	            </tr> 
 	       	            	<%
 	       	            	
 	       	            	Statement stmt = conn.createStatement();
 	       	            	String DegreeName = request.getParameter("DegreeName");
 	       	            	String SSN = request.getParameter("SSN");
 	                    	stmt.executeUpdate(
 	                    			"CREATE OR REPLACE VIEW CompleteConcentration AS (" +
 	                    					"SELECT c.ConcentrationName " +
 	                    					"FROM DegreeConcentration d, Concentration c " +
 	                    					"WHERE " + 
 	                    					"d.DegreeName = '" + DegreeName + "' And d.ConcentrationName = c.ConcentrationName " +
 	                    					"And NOT EXISTS (SELECT d1.CourseName " +
 	                    							"FROM ConcentrationCourse d1 " +
 	                    							"WHERE c.ConcentrationName = d1.ConcentrationName " + 
 	                    							"and d1.CourseName not in " +
 	                    								"(Select h.CourseName " +
 	                    								"From AcademicHistory a, CourseHasClass h " +
 	                    								"Where a.StudentID in (Select StudentID from Student where SSN = '" + SSN + "' ) and a.SectionID = h.SectionID)) " +
 	                    					"AND "+ 
 	                    						"(Select sum(g.NUMBER_GRADE) / count(a.SectionID) AS GPA " +
 	                    						"FROM AcademicHistory a, Grade_Conversion g, CourseHasClass h, ConcentrationCourse cc " +
 	                    						"WHERE a.StudentID in (Select StudentID from Student where SSN = '" + 
 	                    						SSN + "') and a.FinalGrade <> 'IN' and a.FinalGrade = g.LETTER_GRADE and cc.ConcentrationName = c.ConcentrationName " +
 	                    						"and a.SectionID = h.SectionID and h.CourseName = cc.CourseName) > c.MinGPA);"
 	                    			);
 	                                             
 	                        pstmt = conn.prepareStatement("Select * FROM CompleteConcentration");
 	                        rs = pstmt.executeQuery();

 	       	            	while(rs.next()){
 	       	            	%>
 	       	            		<tr>
 	       	            			<td><%= rs.getString("ConcentrationName") %></td>
 	       	            		</tr>
 	       	            	<% 
 	       	            	}
 	       	            	%>
 	       	          </table> 
					  
					<h2>Courses needed to completeConcentrations by Student X with SSN: <%= request.getParameter("SSN") %>
 	       			 		in Degree: <%= request.getParameter("DegreeName") %>
 	       			 </h2>
 	       			 <table border="1" class="table table-bordered">
 	       	              <tr>
 	       	                  <th>Degree Name</th>
  	       	                  <th>Concentration Name</th>
  	       	                  <th>Course Name</th>
  	       	                  <th>Section ID</th>
  	       	                  <th>Quarter</th>
  	       	                  <th>Year</th>
 	       	                 
 	       	            </tr> 
 	       	            	<%
 	       	            	
 	                                            
 	                        pstmt = conn.prepareStatement(
 	                        		"Select d.DegreeName, d.ConcentrationName, c.CourseName, h.SectionID, classes.Quarter, classes.Year " +
 	                        		"from DegreeConcentration d, StudentPursueDegree s, ConcentrationCourse c, CourseHasClass h, Classes classes " +
 	                        		"WHERE d.DegreeName = ? and " +
 	                        		"s.StudentID in (Select StudentID from Student where SSN = ? ) and d.DegreeName = s.DegreeName and " + 
 	                        		"d.ConcentrationName = c.ConcentrationName " +
 	                        		"and d.ConcentrationName not in (Select * from CompleteConcentration) " +
 	                        		"and c.CourseName not in " +
 	                        			"(Select cc.CourseName From AcademicHistory a, CourseHasClass cc " +
 	                        			"Where a.StudentID in (Select StudentID from Student where SSN = ? ) and cc.SectionID = a.SectionID) " +
 	                        		"and c.CourseName = h.CourseName " +
 	                        		"and h.SectionID = classes.SectionID " +
 	                        		"and " +
 	                        		"((classes.Year = '2016' and classes.Quarter = 'Fall') or " + 
 	                        				"(classes.Year = '2016' and classes.Quarter = 'Spring') or (classes.Year = '2017'));"
 	                        		
 	                        		);
 	       	            	pstmt.setString(1, request.getParameter("DegreeName"));
 	       	            	pstmt.setString(2, request.getParameter("SSN"));
 	       	            	pstmt.setString(3, request.getParameter("SSN"));

 	                        rs = pstmt.executeQuery();

 	       	            	while(rs.next()){
 	       	            	%>
 	       	            		<tr>
 	       	            			<td><%= rs.getString("DegreeName") %></td>
 	       	            			<td><%= rs.getString("ConcentrationName") %></td>
 	       	            			<td><%= rs.getString("CourseName") %></td>
 	       	            			<td><%= rs.getString("SectionID") %></td>
 	       	            			<td><%= rs.getString("Quarter") %></td>
 	       	            			<td><%= rs.getString("Year") %></td>
 	       	            		</tr>
 	       	            	<% 
 	       	            	}
 	       	            	%>
 	       	          </table> 
     			
 	        <%          
                    }// end if action == query
            %>
                       
                            <%
                            PreparedStatement pstmt = conn.prepareStatement("SELECT m.SSN, m.Name " +
									"FROM Master m "+
									"WHERE m.StudentID in (Select StudentID FROM PeriodOfAttendence WHERE isCurrentStudent=true);");
                            ResultSet rs = pstmt.executeQuery();
                            
                            pstmt = conn.prepareStatement("Select * From Degree d WHERE d.Type = 'M.S.';");
                            ResultSet rs1 = pstmt.executeQuery();
					
							%>
								<!-- <tr> -->
									<form action="report1e.jsp" method="get">
                      				<input type="hidden" value="query" name="action">
										<label>SSN : </label><select name="SSN">
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
												<option value="<%= rs.getString("SSN") %>" >  <%= "SSN : " + rs.getString("SSN") +" , "+ "Name: " +  rs.getString("Name") %> </option>
										<%
												}// end of while rs.next
											}// end of else 
										%>	
										</select><br>
										<!-- </td> -->
										
										<!-- <td> -->
											<label>DegreeName : </label><select name="DegreeName">
											<%
												// if there is no entry in the Department table
												if (!rs1.isBeforeFirst() ) {    
												}
												else{
											%>
													<option value="" ></option>
											<%
													while(rs1.next()){
											%>
													<option value="<%= rs1.getString("DegreeName") %>" >  <%= "DegreeName : " + rs1.getString("DegreeName") +" , "+ "Type: " +  rs1.getString("Type") + "TotalUnitsRequired: " + rs1.getInt("TotalUnitsRequired")%> </option>
											<%
													}// end of while
												}// end of else
											%>	
											</select><br>
										<!-- </td> -->
										
										<%-- <input type="hidden" value="<%= rs.getString("SSN") %>" name="SSN">
										<input type="hidden" value="<%= rs.getString("DegreeName") %>" name="DegreeName"> --%>
										<input class="btn btn-default" type="submit" value="Search">
                        			</form>
								
                            

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
            		rs1.close();
    
                    // Close the Statement
                    pstmt.close();
    
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
