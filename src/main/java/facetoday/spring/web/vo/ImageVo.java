package facetoday.spring.web.vo;

public class ImageVo {
	private int image_num;
	private String email;
	private String social;
	private String image;
	
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
	public int getImage_num() {
		return image_num;
	}
	public void setImage_num(int image_num) {
		this.image_num = image_num;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
}
