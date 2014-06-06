package facetoday.spring.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.SongListVo;
import facetoday.spring.web.vo.SongVo;

public interface SongService {
	
	/**
	 * DB에 존재하는 모든 노래 출력하기
	 */
	List<SongVo> selectAll() throws SQLException;
	
	String checkSong(@RequestParam("check") String check);
	List NaverList() throws IOException;
	
	boolean createList(SongListVo vo) throws SQLException;
	boolean userList(SongListVo vo) throws SQLException;
	
	List<SongListVo> userlistAll(MemberVo vo) throws SQLException;
}
