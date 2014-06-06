package facetoday.spring.web.vo;

public class MemberVo {
	
	private String email;
	private String name;
	private String passwd;
	private String birth;
	private String social;
	
	public String getSocial() {
		return social;
	}
	public void setSocial(String social) {
		this.social = social;
	}
	public MemberVo(){};
	public MemberVo(String email, String name, String passwd, String birth, String social) {
		this.name = name;
		this.email = email;
		this.passwd = passwd;
		this.birth = birth;
		this.social = social;
	}
	public MemberVo(String email,String passwd, String name, String social) {
		this.email = email;
		this.passwd = passwd;
		this.name = name;
		this.social = social;
	}
	
	public MemberVo(String email, String social){
		this.email = email;
		this.social = social;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
}
