package facetoday.spring.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import facetoday.service.MorphologicalAnalysis;
import facetoday.spring.web.dao.BoardDao;
import facetoday.spring.web.vo.BoardJoinMemberVo;
import facetoday.spring.web.vo.BoardVo;
import facetoday.spring.web.vo.ImageVo;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.MorphologyVo;

public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDao")
	private BoardDao boardDao;
	
	MorphologicalAnalysis mAnalysis = new MorphologicalAnalysis();
	
	/**
	 * 글 저장
	 */
	@Override
	public int boardInsert(BoardVo vo) throws SQLException{
		
		// TODO Auto-generated method stub
		List<String> list = null;
		List<MorphologyVo> morphologyList;
		
		try {
			morphologyList = MorphologyList();
			
			int state = 0;
			
			System.out.println("유입된 문장 : " + vo.getContent());
			list = mAnalysis.morphologicalAnalysis(vo.getContent());
			
			for (int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i));
				for (int j = 0; j < morphologyList.size(); j++ ) {
					if (list.get(i).equals(morphologyList.get(j).getF_word())){
						vo.setKeyword(morphologyList.get(j).getF_word());
						System.out.println("값 :"+morphologyList.get(j).getState());
						state = state + morphologyList.get(j).getState();
					}
				}
			}
			
			System.out.println("기분값 : "+state);
			vo.setState(state);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return boardDao.boardInsert(vo);
	}
	
	
	/**
	 * 형태소 목록 추출. 나중에 로그인할 때 최초 한 번만 추출하기.
	 */
	@Override
	public List<MorphologyVo> MorphologyList() throws SQLException {
		
		List<MorphologyVo> morphologyList = boardDao.MorphologyList();
		
		if (morphologyList.isEmpty()) {
			throw new SQLException("형태소 목록을 가져오는 중 오류가 발생했습니다.");
		}
		return morphologyList;
	}
	
	/**
	 * 저장된 글 담벼락 구성
	 */
	@Override
	public List<BoardJoinMemberVo> boardSelectAll(String email, String social) throws SQLException{
		// TODO Auto-generated method stub
		
		List<BoardJoinMemberVo> list = boardDao.boardSelectAll(email,social);
		
		if(list.isEmpty())
			throw new SQLException("저장된 글이 없습니다.");
		
		return list;
	}
	
	/**
	 * 저장된 내 글 담벼락 구성
	 */
	@Override
	public List<BoardJoinMemberVo> boardSelectAll(MemberVo vo) throws SQLException{
		// TODO Auto-generated method stub
		
		List<BoardJoinMemberVo> list = boardDao.boardSelectAll(vo);
		
		if(list.isEmpty())
			throw new SQLException("저장된 글이 없습니다.");
		
		return list;
	}

	/**
	 * 해당 글 삭제하기
	 */
	public int boardDelete(int board_num) {
		return boardDao.boardDelete(board_num);
	}
	
	/**
	 * 글 내용 수정하기
	 */
	@Override
	public int boardUpdate(BoardVo boardVo) {
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}
	
	/**
	 * 기분 변화 테이블 생성
	 */
	@Override
	public List<BoardVo> selectEmotion(MemberVo vo) throws SQLException {
		
		List<BoardVo> list = boardDao.selectEmotion(vo);
		
		if (list.isEmpty()) {
			throw new SQLException("board 테이블 접근 불가");
		}
		
		return list;
	}

	/**
	 * 이미지 저장
	 */
	@Override
	public int imageInsert(ImageVo vo) throws SQLException {
		return boardDao.imageInsert(vo);
	}
	
	/**
	 * 이미지 추출
	 */
	@Override
	public int imageExtract(String image) throws SQLException {
		return boardDao.imageExtract(image);
	}

	/**
	 * 이미지 리스트 생성
	 */
	@Override
	public List<BoardVo> selectImage(MemberVo vo) throws SQLException {
		return boardDao.selectImages(vo);
	}
	
	/**
	 * 포토월 생성
	 */
	@Override
	public List<ImageVo> getPhotoWall(MemberVo vo) throws SQLException {
		return boardDao.getPhotoWall(vo);
	}
}
