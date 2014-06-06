package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.SongListVo;
import facetoday.spring.web.vo.SongVo;

public interface SongDao {
	
	List<SongVo> selectAll() throws SQLException;
	  
	/**
	 * 날씨에 해당하는 날씨 검색
	 * 작성자 : 박찬희
	 * @param weather
	 * @param singer
	 * @param title
	 * @return
	 * @throws SQLException
	 */
	
	List<SongVo> songSelectByWeather(String weather) throws SQLException;
	
	boolean createList(SongListVo vo) throws SQLException;
	boolean userList(SongListVo vo) throws SQLException;
	List<SongListVo> userlistAll(MemberVo vo) throws SQLException;
}
