package CSE132B;

public class Faculty extends Person{
	public String Title;
	public Faculty(String Name, String SSN, String Title){
		super(Name, SSN);
		this.Title = Title;
	}
}
