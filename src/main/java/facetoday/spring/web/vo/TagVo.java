package facetoday.spring.web.vo;

public class TagVo {
	private int board_num;
	private String email;
	private String social;
	private int tag_num;
	private String tag;
	
	private String tagString;
	
	public String getTagString() {
		return tagString;
	}
	public void setTagString(String tagString) {
		this.tagString = tagString;
	}
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
	public int getTag_num() {
		return tag_num;
	}
	public void setTag_num(int tag_num) {
		this.tag_num = tag_num;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
}