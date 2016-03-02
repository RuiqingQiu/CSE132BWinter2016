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
                        
                        PreparedStatement pstmt = conn.prepareStatement("Select a.StudentID, d.DegreeName,(d.TotalUnitsRequired-sum(a.Units)) AS UnitsLeftToTake "+ 
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
 	                    
 	       				
 	       			  <!-- Display Quarter GPA -->
 	                  <h2>Minimum number of units has to take from each category for Student X with SSN : <%= request.getParameter("SSN") %></h2>
 	       				<table border="1" class="table table-bordered">
 	       	              <tr>
 	       	                  <th>UnitsLeft</th>
 	       	                  <th>Category</th>
 	       	            </tr> 
 	       	             <% 
 	       	               pstmt = conn.prepareStatement(
 	       	            	
 	       	            	"Select (d.UnitsRequired-sum(a.Units)) AS UnitsLeft, d.Category " +
 	       	            	"From AcademicHistory a, DegreeDetailedUnitRequirement d " +
 	       	            	"Where a.StudentID in (Select StudentID from Student where SSN = ? ) " +
 	       	            	"AND d.DegreeName = 'Computer Science' " +
 	       	            	"AND d.Category in (Select g.Category " +
 	       	            			        "FROM CourseHasClass h,Course c, CourseCategory g "+
 	       	            					"WHERE a.SectionID = h.SectionID AND h.CourseName = c.CourseName AND c.CourseName = g.CourseName) "+			
 	       	            	"GROUP BY d.Category, d.UnitsRequired;");	   
							
 	       	         		pstmt.setString(1,request.getParameter("SSN"));
 	                      	
 	       	             	rs = pstmt.executeQuery();
 	       	                    
 	       					while(rs.next()){
 	       				  %>
 	      						<tr>
 	      							<td><%= rs.getString("UnitsLeft") %></td>
 	      							<td><%= rs.getString("Category") %></td>
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
