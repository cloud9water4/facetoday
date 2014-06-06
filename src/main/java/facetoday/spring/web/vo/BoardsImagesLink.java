package facetoday.spring.web.vo;

public class BoardsImagesLink {
	private int board_num;
	private String email;
	private String social;
	private int image_num;
	
	public BoardsImagesLink(){}
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
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
	public int getImage_num() {
		return image_num;
	}
	public void setImage_num(int image_num) {
		this.image_num = image_num;
	}
	
	
}
