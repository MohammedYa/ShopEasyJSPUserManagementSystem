package classes;

public class User {
private String name;
private String password;
private String email;
private String governerate ;
private String birthdate ;
private String langueges ;
private boolean status ;

public User(String name,String password,String email,String governerate,String birthdate,String langueges,boolean status ){
	setName(name);
	setEmail(email);
	setGovernerate(governerate);
	setBirthdate(birthdate);
	setPassword(password);
	setStatus(status);
	setLangueges(langueges);
}
public User(String name,String password,String langueges,boolean status){
	setName(name);
	setPassword(password);
	setStatus(status);
	setLangueges(langueges);
}
public void setName(String name) {
	this.name = name;
}
public void setEmail(String email) {
	this.email = email;
}
public void setGovernerate(String governerate) {
	this.governerate = governerate;
}
public void setBirthdate(String birthdate) {
	this.birthdate = birthdate;
}
public void setPassword(String password) {
	this.password = password;
}



public String getName() {
	return name;
}
public String getEmail() {
	return email;
}
public String getPassword() {
	return password;
}
public String getGovernerate() {
	return governerate;
}
public String getBirthdate() {
	return birthdate;
}


public String getLangueges() {
	return langueges;
}

public void setLangueges(String langueges) {
	this.langueges = langueges;
}
public boolean getStatus() {
	return status;
}
public void setStatus(boolean status) {
	this.status = status;
}


}
