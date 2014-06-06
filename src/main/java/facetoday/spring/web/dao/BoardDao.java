package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import facetoday.spring.web.vo.BoardJoinMemberVo;
import facetoday.spring.web.vo.BoardVo;
import facetoday.spring.web.vo.ImageVo;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.MorphologyVo;

public interface BoardDao {
	
	/**
	 *  글 작성
	 */
	int boardInsert(BoardVo vo) throws SQLException;
	
	/**
	 * 뉴스피드 검색해서 뿌리기(모든 글)
	 */
	List<BoardJoinMemberVo> boardSelectAll(String email,String social) throws SQLException;
	
	
	/**
	 * 모든 내 글 검색해서 뿌리기(담벼락)
	 */
	List<BoardJoinMemberVo> boardSelectAll(MemberVo vo) throws SQLException;
	
	/**
	 *  글 삭제하기
	 */
	int boardDelete(int board_num);
	
	/**
	 * 글 수정하기
	 */
	int boardUpdate(BoardVo boardVo);
	
	/**
	 * 형태소 목록
	 */
	List<MorphologyVo> MorphologyList() throws SQLException;
	
	/**
	 *  이미지 저장
	 */
	int imageInsert(ImageVo vo) throws SQLException;
	
	/**
	 * 이미지번호 추출하기
	 */
	int imageExtract(String image) throws SQLException;
	
	// 기분 변화 관련
	
	/**
	 * 보드 날짜, 키워드, 수치 출력
	 */
	List<BoardVo> selectEmotion(MemberVo vo) throws SQLException;
	
	/**
	 * 친구 맺기
	 */
	int matchingFriend(String email2, String email) throws SQLException;
	
	/**
	 * 
	 * 이미지 출력
	 */
	List<BoardVo> selectImages(MemberVo vo) throws SQLException;
	
	/**
	 * photoWall 생성
	 * @return
	 * @throws SQLException
	 */
	List<ImageVo> getPhotoWall(MemberVo vo) throws SQLException;
}
