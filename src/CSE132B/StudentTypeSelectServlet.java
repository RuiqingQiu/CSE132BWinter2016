package CSE132B;

import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ActionServlet
 */

public class StudentTypeSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public String UndergraduateForm = "<h3>Undergraduate Student Form</h3><br>" + 
								"<form action=\"student.jsp\" method=\"get\">"+ 
								"<input type=\"hidden\" value=\"insert\" name=\"action\">" +
								"<input type=\"hidden\" value=\"Undergraduate\" name=\"StudentType\">" +
								"Name: <input value=\"\" name=\"Name\" size=\"10\"><br>"+
								"SSN: <input value=\"\" name=\"SSN\" size=\"10\"><br>" +
								"StudentID: <input value=\"\" name=\"StudentID\" size=\"10\"><br>" +
								"Residence Status:<input value=\"\" name=\"ResidenceStatus\" size=\"10\"><br>" +
								"Academic Level: <input value=\"\" name=\"AcademicLevel\" size=\"10\"><br>"+
								"College: <input value=\"\" name=\"College\" size=\"10\"><br>" +
								"<input class=\"btn btn-default\" type=\"submit\" value=\"Insert\"></form>";
	
	public String MasterForm = "<h3>Master Student Form</h3><br>" +
			"<form action=\"student.jsp\" method=\"get\">"+ 
			"<input type=\"hidden\" value=\"insert\" name=\"action\">" +
			"<input type=\"hidden\" value=\"Master\" name=\"StudentType\">" +
			"Name: <input value=\"\" name=\"Name\" size=\"10\"><br>"+
			"SSN: <input value=\"\" name=\"SSN\" size=\"10\"><br>" +
			"StudentID: <input value=\"\" name=\"StudentID\" size=\"10\"><br>" +
			"Residence Status:<input value=\"\" name=\"ResidenceStatus\" size=\"10\"><br>" +
			"Academic Level: <input value=\"\" name=\"AcademicLevel\" size=\"10\"><br>"+
			"<input class=\"btn btn-default\" type=\"submit\" value=\"Insert\"></form>";
	public String BSMSForm = 
			"<h3>BS/MS Student Form</h3><br>" +
			"<form action=\"student.jsp\" method=\"get\">"+ 
			"<input type=\"hidden\" value=\"insert\" name=\"action\">" +
			"<input type=\"hidden\" value=\"BSMS\" name=\"StudentType\">" +
			"Name: <input value=\"\" name=\"Name\" size=\"10\"><br>"+
			"SSN: <input value=\"\" name=\"SSN\" size=\"10\"><br>" +
			"StudentID: <input value=\"\" name=\"StudentID\" size=\"10\"><br>" +
			"Residence Status:<input value=\"\" name=\"ResidenceStatus\" size=\"10\"><br>" +
			"Academic Level: <input value=\"\" name=\"AcademicLevel\" size=\"10\"><br>"+
			"College: <input value=\"\" name=\"College\" size=\"10\"><br>" +
			"Expected Date to Enter Graduate Program: <input value=\"\" type=\"date\" name=\"ExpectedGraduateDate\" size=\"10\"><br>" + 
			"<input class=\"btn btn-default\" type=\"submit\" value=\"Insert\"></form>";
	public String PhdPreCandidacyForm = 
			"<h3>PhD Pre-Candidacy Student Form</h3><br>" +
			"<form action=\"student.jsp\" method=\"get\">"+ 
			"<input type=\"hidden\" value=\"insert\" name=\"action\">" +
			"<input type=\"hidden\" value=\"PhdPreCandidacy\" name=\"StudentType\">" +
			"Name: <input value=\"\" name=\"Name\" size=\"10\"><br>"+
			"SSN: <input value=\"\" name=\"SSN\" size=\"10\"><br>" +
			"StudentID: <input value=\"\" name=\"StudentID\" size=\"10\"><br>" +
			"Residence Status:<input value=\"\" name=\"ResidenceStatus\" size=\"10\"><br>" +
			"Academic Level: <input value=\"\" name=\"AcademicLevel\" size=\"10\"><br>"+
			"<input class=\"btn btn-default\" type=\"submit\" value=\"Insert\"></form>";
	public String PhDCandidatesForm = 
			"<h3>PhD Candidates Student Form</h3><br>" +
			"<form action=\"student.jsp\" method=\"get\">"+ 
			"<input type=\"hidden\" value=\"insert\" name=\"action\">" +
			"<input type=\"hidden\" value=\"PhDCandidates\" name=\"StudentType\">" +
			"Name: <input value=\"\" name=\"Name\" size=\"10\"><br>"+
			"SSN: <input value=\"\" name=\"SSN\" size=\"10\"><br>" +
			"StudentID: <input value=\"\" name=\"StudentID\" size=\"10\"><br>" +
			"Residence Status:<input value=\"\" name=\"ResidenceStatus\" size=\"10\"><br>" +
			"Academic Level: <input value=\"\" name=\"AcademicLevel\" size=\"10\"><br>"+
			"<input class=\"btn btn-default\" type=\"submit\" value=\"Insert\"></form>";

    public StudentTypeSelectServlet() {
        // TODO Auto-generated constructor stub
    }


  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  String type = null;
	  type = request.getParameter("StudentType");
	  
	  response.setContentType("text/plain");  
	  
	  response.setCharacterEncoding("UTF-8"); 
	  
	  //response.getWriter().write(studentForm);
	  if(type.equals("Undergraduate"))
		  response.getWriter().println(UndergraduateForm);
	  else if(type.equals("Master"))
		  response.getWriter().println(MasterForm);
	  else if(type.equals("BSMS"))
		  response.getWriter().println(BSMSForm);
	  else if(type.equals("PhdPreCandidacy"))
		  response.getWriter().println(PhdPreCandidacyForm);
	  else if(type.equals("PhDCandidates"))
		  response.getWriter().println(PhDCandidatesForm);

 }

  
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  // TODO Auto-generated method stub
  
 }

}