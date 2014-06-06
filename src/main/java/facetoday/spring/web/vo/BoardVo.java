package facetoday.spring.web.vo;

import org.springframework.web.multipart.MultipartFile;

public class BoardVo {
	
	private int board_num;
	private String email;
	private String social;
	private String write_date;
	private String content;
	private String filename;
	private String lat;
	private String lon;
	private int state;
	private String keyword;
	private String image;
	private String tagString;
	private int c_num;
	
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public String getTagString() {
		return tagString;
	}
	public void setTagString(String tagString) {
		this.tagString = tagString;
	}
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	//upload 변수
	private MultipartFile file;
	
	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public BoardVo(){}
	
	public BoardVo(int boardNum, String content){
		this.board_num = boardNum;
		this.content = content;
	}
	
	public String getTags() {
		return social;
	}

	public void setTags(String tag) {
		
	}
	
	public String getSocial() {
		return social;
	}

	public void setSocial(String social) {
		this.social = social;
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

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
