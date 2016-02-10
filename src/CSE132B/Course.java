package CSE132B;

public class Course {
	public String CourseName;
	public String DepartmentName;
	public int MaxUnits;
	public int MinUnits;
	public String RequireLabWorks;
	public String GradeOption;
	public String RequireConsentOfInstructor;
	
	public Course(String CourseName, String DepartmentName, int MaxUnits, int MinUnits,
			String RequireLabWorks, String GradeOption,
			String RequireConsentOfInstructor)
	{
		this.CourseName = CourseName;
		this.DepartmentName = DepartmentName;
		this.MaxUnits = MaxUnits;
		this.MinUnits = MinUnits;
		this.RequireLabWorks = RequireLabWorks;
		this.GradeOption = GradeOption;
		this.RequireConsentOfInstructor = RequireConsentOfInstructor;
	}
}
