package facetoday.spring.web.vo;

public class SongListVo {
	private String email;
	private String social;
	private int list_num;
	private String sources;
	private String list_name;
	
	public SongListVo(){}
	public SongListVo(String email, String social, String sources, String list_name) {
		this.email = email;
		this.social = social;
		this.sources = sources;
		this.list_name = list_name;
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
	public int getList_num() {
		return list_num;
	}
	public void setList_num(int list_num) {
		this.list_num = list_num;
	}
	public String getSources() {
		return sources;
	}
	public void setSources(String sources) {
		this.sources = sources;
	}
	public String getList_name() {
		return list_name;
	}
	public void setList_name(String list_name) {
		this.list_name = list_name;
	}
	
	
}
