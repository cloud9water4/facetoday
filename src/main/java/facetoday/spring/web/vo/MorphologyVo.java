package facetoday.spring.web.vo;

public class MorphologyVo {
	private String f_word;     // 감정 형태소
	private String s_word;     // 형태소 형태 (어근,일반부사 등)
	private int state;         // 감정 형태소의 감정 수치.
	
	public MorphologyVo(){}
	
	public String getF_word() {
		return f_word;
	}
	public void setF_word(String f_word) {
		this.f_word = f_word;
	}
	public String getS_word() {
		return s_word;
	}
	public void setS_word(String s_word) {
		this.s_word = s_word;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "MorphologyVo [f_word=" + f_word + ", s_word=" + s_word
				+ ", state=" + state + "]";
	}
	
}
