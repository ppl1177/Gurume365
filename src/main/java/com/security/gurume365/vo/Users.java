package com.security.gurume365.vo;

public class Users  {
	
	/**
	 * 
	 */
	
	
	private String id;
	private String pw;
	private String name;
	private String dateOfBirth;
	private String phone;
	private String permit;
	private int division;
	private int enabled;	
	private String permitToken;
	
	public Users() {
		super();
	}
	public Users(String id, String pw, String name, String dateOfBirth, String phone, String permit, int division,
			int enabled, String permitToken) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.dateOfBirth = dateOfBirth;
		this.phone = phone;
		this.permit = permit;
		this.division = division;
		this.enabled = enabled;
		this.permitToken = permitToken;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public String getPw() {
		return pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPermit() {
		return permit;
	}
	public void setPermit(String permit) {
		this.permit = permit;
	}
	public int getDivision() {
		return division;
	}
	public void setDivision(int division) {
		this.division = division;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getPermitToken() {
		return permitToken;
	}
	public void setPermitToken(String permitToken) {
		this.permitToken = permitToken;
	}
	@Override
	public String toString() {
		return "Users [id=" + id + ", pw=" + pw + ", name=" + name + ", dateOfBirth=" + dateOfBirth + ", phone="
				+ phone + ", permit=" + permit + ", division=" + division + ", enabled=" + enabled + ", authority="
				 + ", permitToken=" + permitToken + "]";
	}
}
