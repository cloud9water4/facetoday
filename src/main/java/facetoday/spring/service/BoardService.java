package facetoday.spring.service;

import java.sql.SQLException;
import java.util.List;

import facetoday.spring.web.vo.BoardJoinMemberVo;
import facetoday.spring.web.vo.BoardVo;
import facetoday.spring.web.vo.ImageVo;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.MorphologyVo;

public interface BoardService {
	
	
	/**
	 * content 작성
	 */
	int boardInsert(BoardVo vo) throws SQLException;
	
	
	/**
	 * content 담벼락 구성하기, 뉴스피드 구성하기
	 */
	List<BoardJoinMemberVo> boardSelectAll(String email, String social) throws SQLException;
	
	/**
	 * content 내 담벼락 구성하기
	 */
	List<BoardJoinMemberVo> boardSelectAll(MemberVo vo) throws SQLException;
	
	/**
	 * content 삭제하기
	 */
	int boardDelete(int board_num);
	
	/**
	 * content 수정하기
	 */
	int boardUpdate(BoardVo boardVo);
	
	/**
	 * 형태소 목록 추출
	 */
	List<MorphologyVo> MorphologyList() throws SQLException;
	
	
	/**
	 * 기분 변화 관련 테이블 생성
	 */
	List<BoardVo> selectEmotion(MemberVo vo) throws SQLException;
	
	/**
	 * 이미지 삽입
	 */
	int imageInsert(ImageVo vo) throws SQLException;
	
	/**
	 * 이미지 번호 추출
	 */
	int imageExtract(String image) throws SQLException;
	
	/**
	 * 이미지 리스트 생성
	 */
	List<BoardVo> selectImage(MemberVo vo) throws SQLException;
	
	/*
	 * 포토월
	 */
	List<ImageVo> getPhotoWall(MemberVo vo) throws SQLException;
}
