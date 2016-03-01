<html>
<head>
	<title>Report 1D</title>
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
     	<li><a href="#">Report</a></li>
     	<li><a href="#">Report</a></li>
      </ul>   
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	<h2>Report 1D, Undergrad X find remaining degree requirements for a bachelors in Y</h2>

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
                        
                    	String ssn = request.getParameter("SSN");
                    	
                    	Statement stmt = conn.createStatement();
                    	stmt.executeUpdate("CREATE OR REPLACE VIEW ClassesTaken AS "+ 
                				"(SELECT a.SectionID,a.Title,a.Quarter,a.Year,a.MaxEnrollment,b.Units,b.FinalGrade FROM " + 
                				"(SELECT c.SectionID,c.Title,c.Quarter,c.Year,c.MaxEnrollment " + 
                				"FROM Classes c "+
                				"WHERE c.SectionID in (SELECT a.SectionID " + 
                						      "FROM AcademicHistory a " + 
                						      "WHERE a.StudentID in (SELECT StudentID " + 
                									     "FROM Student " + 
                									     "WHERE SSN = '" + ssn + "')) "+ 
                				"ORDER BY c.Year,c.Quarter) a " +
                				"INNER JOIN "+
                				"((SELECT a.SectionID, a.Units,a.FinalGrade " + 
                					  "FROM AcademicHistory a "+ 
                					  "WHERE a.StudentID in (SELECT StudentID "+ 
                								"FROM Student "+ 
                								"WHERE SSN = '" + ssn + "'))) b " +
                				"ON a.SectionID = b.SectionID);");
                                             
                        PreparedStatement pstmt = conn.prepareStatement("Select * FROM ClassesTaken");
                        ResultSet rs = pstmt.executeQuery();
 					
 						%>
 						<h2> Classes taken by student X with SSN : <%= request.getParameter("SSN") %></h2>
 						<table border="1" class="table table-bordered">
 	                    <tr>
 	                        <th>SectionID</th>
 	                        <th>Title</th>
 	                        <th>Quarter</th>
 	                        <th>Year</th>
 	                        <th>MaxEnrollment</th>
 	                        <th>Units</th>
 	                        <th>FinalGrade</th>
 	                    </tr> 
 	                    <% 
 					
 						while(rs.next()){
 						%>
							<tr>
								<td><%= rs.getString("SectionID") %></td>
								<td><%= rs.getString("Title") %></td>
								<td><%= rs.getString("Quarter") %></td>
								<td><%= rs.getString("Year") %></td>
								<td><%= rs.getString("MaxEnrollment") %></td>
								<td><%= rs.getString("Units") %></td>
								<td><%= rs.getString("FinalGrade") %></td>
	
							</tr>
						<% 
 						}
 	                   %>
 	                   </table>
 	                    
 	                   <!-- Display cumulative GPA -->
 	                  <h2> Cumulative GPA for Student X with SSN : <%= request.getParameter("SSN") %></h2>
 	       				<table border="1" class="table table-bordered">
 	       	              <tr>
 	       	                  <th>SSN</th>
 	       	                  <th>Cumulative_GPA</th>
 	       	            </tr> 
 	       	             <% 
 	       	               pstmt = conn.prepareStatement("Select" + "'"+ ssn + "'"+ "AS SSN,sum(g.NUMBER_GRADE)/(count(c.SectionID)) AS Cumulative_GPA "+
  	                    		  "from ClassesTaken c, Grade_Conversion  g "+
  	                    		 "Where c.FinalGrade <> 'IN' and c.FinalGrade = g.LETTER_GRADE;");
 	                      	rs = pstmt.executeQuery();
 	       	                    
 	       						while(rs.next()){
 	       						%>
 	      							<tr>
 	      								<td><%= rs.getString("SSN") %></td>
 	      								<td><%= rs.getString("Cumulative_GPA") %></td>
 	      							</tr>
 	      						<% 
 	       						}
 	       				%>
 	       				</table>
 	       				
 	       			  <!-- Display Quarter GPA -->
 	                  <h2> Quarter GPA for Student X with SSN : <%= request.getParameter("SSN") %></h2>
 	       				<table border="1" class="table table-bordered">
 	       	              <tr>
 	       	                  <th>Year</th>
 	       	                  <th>Quarter</th>
 	       	                  <th>Quarter_GPA</th>
 	       	            </tr> 
 	       	             <% 
 	       	               pstmt = conn.prepareStatement("Select c.Year AS Year, c.Quarter AS Quarter, sum(g.NUMBER_GRADE) / (count(c.SectionID)) AS GPA " + 
 	       	            	"from ClassesTaken c, Grade_Conversion g " + 
 	       	            	"Where c.FinalGrade <> 'IN' and c.FinalGrade = g.LETTER_GRADE "+ 
 	       	            	"GROUP BY c.Year, c.Quarter;");
 	                      	
 	       	             	rs = pstmt.executeQuery();
 	       	                    
 	       					while(rs.next()){
 	       				  %>
 	      						<tr>
 	      							<td><%= rs.getString("Year") %></td>
 	      							<td><%= rs.getString("Quarter") %></td>
 	      							<td><%= rs.getString("GPA") %></td>
 	      						</tr>
 	      				<% 
 	       					}
 	       				%>
 	       				</table>
 	       			
 	        <%          
                    }// end if action == query
            %>
            
            <!-- Add an HTML table header row to format the results 
                <table border="1" class="table table-bordered">
                    <tr>
                        <th>SSN</th>
                    	<th>BSC_Degree</th>
                    	
                    </tr> 
                    -->                  
                            <%
                            PreparedStatement pstmt = conn.prepareStatement("SELECT u.SSN,u.Name " +
									"FROM Undergraduate u "+
									"WHERE u.StudentID in (Select StudentID FROM PeriodOfAttendence WHERE isCurrentStudent=true);");
                            ResultSet rs = pstmt.executeQuery();
                            
                            pstmt = conn.prepareStatement("Select * From Degree d WHERE d.Type = 'B.S.';");
                            ResultSet rs1 = pstmt.executeQuery();
					
							%>
								<!-- <tr> -->
									<form action="report1d.jsp" method="get">
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
