package CSE132B;

public class Student extends Person {
	public String StudentID;
	public String ResidenceStatus;
	public String AcademicLevel;
	
	public Student(String name, String SSN, String StudentID, String ResidenceStatus, String AcademicLevel){
		super(name, SSN);
		this.StudentID = StudentID;
		this.ResidenceStatus = ResidenceStatus;
		this.AcademicLevel = AcademicLevel;
	}
}
