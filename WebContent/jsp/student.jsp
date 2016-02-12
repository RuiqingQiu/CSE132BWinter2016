<html>
<head>
	<title>Student Entry Form</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js">   
        </script>
        <script>
            $(document).ready(function() { 
                $('#StudentType').change(function() {  
                    var username=$(this).val();
                 	$.get('../StudentTypeSelectServlet',{StudentType:username},function(responseText) { 
                        $('#form').html(responseText);        
                    });
                });
                $('#show_student').click(function(){
                	$("#student_table").toggle();
                });
            });
    </script>
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
            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <h2>Student Entry Form</h2>
            What type of students are you entering?
            <select id="StudentType" name="StudentType">
			<option value="Undergraduate">Undergraduate</option>
			<option value="BSMS">BS/MS</option>
			<option value="Master">Master</option>
			<option value="PhdPreCandidacy">Pre-Candidacy PhD</option>
			<option value="PhDCandidates">PhD Candidates</option>
			</select>
			<div id="form">
				<!-- Default form is undergraduate -->
				<h3>Undergraduate Student Form</h3><br>
				<form action="student.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<input type="hidden" value="Undergraduate" name="StudentType">
	            Name: <input value="" name="Name" size="10"><br>
	            SSN: <input value="" name="SSN" size="10"><br>
	            StudentID: <input value="" name="StudentID" size="10"><br>
	            Residence Status:<input value="" name="ResidenceStatus" size="10"><br>
	            Academic Level: <input value="" name="AcademicLevel" size="10"><br>
	            College: <input value="" name="College" size="10"><br>
	            <input class="btn btn-default" type="submit" value="Insert">
	            </form>
			</div>
			<br>
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
            		Student s = new Student(request.getParameter("Name"), request.getParameter("SSN"),
            							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
            							request.getParameter("AcademicLevel")
            				);
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {
						String table = request.getParameter("StudentType");
						if(table.equals("Undergraduate")){
							Undergraduate u = new Undergraduate(request.getParameter("Name"), request.getParameter("SSN"),
        							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
        							request.getParameter("AcademicLevel"), request.getParameter("College"));
							u.insert(conn);
						}
						else if(table.equals("BSMS")){
							BSMS b = new BSMS(request.getParameter("Name"), request.getParameter("SSN"),
        							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
        							request.getParameter("AcademicLevel"), request.getParameter("College"), 
        							request.getParameter("ExpectedGraduateDate"));
							b.insert(conn);
						}
						else if(table.equals("Master")){
							Master m = new Master(request.getParameter("Name"), request.getParameter("SSN"),
        							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
        							request.getParameter("AcademicLevel"));
							m.insert(conn);
						}
						else if(table.equals("PhdPreCandidacy")){
							PhdPreCandidacy m = new PhdPreCandidacy(request.getParameter("Name"), request.getParameter("SSN"),
        							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
        							request.getParameter("AcademicLevel"));
							m.insert(conn);
						}
						else if(table.equals("PhDCandidates")){
							PhDCandidates m = new PhDCandidates(request.getParameter("Name"), request.getParameter("SSN"),
        							request.getParameter("StudentID"), request.getParameter("ResidenceStatus"),
        							request.getParameter("AcademicLevel"));
							m.insert(conn);
						}
						else{
							System.out.println("Something went wrong");
						}
                    
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Student SET Name = ?, SSN = ?, ResidenceStatus = ?, AcademicLevel = ? WHERE StudentID = ?");

                  
                        pstmt.setString(1, request.getParameter("Name"));
                        pstmt.setString(2, request.getParameter("SSN"));
                        pstmt.setString(3, request.getParameter("ResidenceStatus"));                        
                        pstmt.setString(4, request.getParameter("AcademicLevel"));                        
                        pstmt.setString(5, request.getParameter("StudentID"));                        

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
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE StudentID = ?");

                        pstmt.setString(
                            1, request.getParameter("StudentID"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>
			
			<h2>Student Data</h2>
			<button id="show_student">Show Student Data</button>
            <table id="student_table" border="1" class="table table-bordered">
				<tr>
                   	<th>Name</th>
                   	<th>SSN</th>
                	<th>StudentID</th>
                   	<th>ResidenceStatus</th>
                   	<th>AcademicLevel</th>
                   	<th>Action</th>
               </tr>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Student");
                    // Iterate over the ResultSet
                    while ( rs.next() ) {
            %>

               <tr>
                   <form action="student.jsp" method="get">
                       <input type="hidden" value="update" name="action">
                       <td>
                           <input value="<%= rs.getString("Name") %>" 
                               name="Name" size="10">
                       </td>
                       <td>
                           <input value="<%= rs.getString("SSN") %>" 
                               name="SSN" size="10">
                       </td>
                       <td>
                           <input value="<%= rs.getString("StudentID") %>" 
                               name="StudentID" size="10">
                       </td>
                       <td>
                           <input value="<%= rs.getString("ResidenceStatus") %>" 
                               name="ResidenceStatus" size="10">
                       </td>
                       <td>
                           <input value="<%= rs.getString("AcademicLevel") %>" 
                               name="AcademicLevel" size="10">
                       </td>
                       <td>
                           <input class="btn btn-default" type="submit" value="Update">
                       </td>
                   </form>
                   <form action="student.jsp" method="get">
                       <input type="hidden" value="delete" name="action">
                       <input type="hidden" 
                           value="<%= rs.getString("StudentID") %>" name="StudentID">
                       <td>
                           <input class="btn btn-default" type="submit" value="Delete">
                       </td>
                   </form>
               </tr>
            <%
                    }
            %>
            </table>

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
              
</body>

</html>
