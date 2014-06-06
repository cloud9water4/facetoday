package facetoday.spring.web.vo;

public class FriendsVo {
	
	private String emailFriend;
	private String socialFriend;
	private String email;
	private String social;
	private String name;
	
	public FriendsVo(){}
	public FriendsVo(String emailFriend, String socialFriend, String email, String social){
		this.emailFriend = emailFriend;
		this.socialFriend = socialFriend;
		this.email = email;
		this.social = social;
	}
	public FriendsVo(String emailFriend, String socialFriend, String email, String social, String name){
		this.emailFriend = emailFriend;
		this.socialFriend = socialFriend;
		this.email = email;
		this.social = social;
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmailFriend() {
		return emailFriend;
	}
	public void setEmailFriend(String emailFriend) {
		this.emailFriend = emailFriend;
	}
	public String getSocialFriend() {
		return socialFriend;
	}
	public void setSocialFriend(String socialFriend) {
		this.socialFriend = socialFriend;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSocial() {
		return social;
	}
	public void setSocial(String social) {
		this.social = social;
	}
	@Override
	public String toString() {
		return "FriendsVo [emailFriend=" + emailFriend + ", socialFriend="
				+ socialFriend + ", email=" + email + ", social=" + social
				+ ", name=" + name + "]";
	}
}
