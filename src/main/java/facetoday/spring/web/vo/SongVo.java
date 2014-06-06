package facetoday.spring.web.vo;

public class SongVo {
	private int song_num;
	private String singer;
	private String title;
	private String release;
	private String genre;
	private int state;
	private String weather;
	private String source;

	public SongVo() {}

	public SongVo(String title, String singer, String source) {
		this.title = title;
		this.singer = singer;
		this.source = source;
	}

	public SongVo(int song_num, String singer, String title, String release,String genre, int state, String weather) {
		this.song_num = song_num;
		this.singer = singer;
		this.title = title;
		this.release = release;
		this.genre = genre;
		this.state = state;
		this.weather = weather;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public int getSong_num() {
		return song_num;
	}

	public void setSong_num(int song_num) {
		this.song_num = song_num;
	}

	public String getSinger() {
		return singer;
	}

	public void setSinger(String singer) {
		this.singer = singer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRelease() {
		return release;
	}

	public void setRelease(String release) {
		this.release = release;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getWeather() {
		return weather;
	}

	public void setWeather(String weather) {
		this.weather = weather;
	}
}
