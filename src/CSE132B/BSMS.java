package CSE132B;

public class BSMS extends Undergraduate {
	public String ExpectedGraduateDate;
	public BSMS(String name, String SSN, String StudentID, 
			String ResidenceStatus, String AcademicLevel,
			String College, String ExpectedGraduateDate){
		super(name, SSN, StudentID, ResidenceStatus, AcademicLevel,College);
		this.ExpectedGraduateDate = ExpectedGraduateDate;
	}
}
