package CSE132B;

public class Undergraduate extends Student {
	public String College;
	public Undergraduate(String name, String SSN, String StudentID, 
						String ResidenceStatus, String AcademicLevel,
						String College){
		super(name, SSN, StudentID, ResidenceStatus, AcademicLevel);
		this.College = College;
	}
}
