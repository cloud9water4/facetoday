package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import facetoday.spring.web.vo.BoardJoinMemberVo;
import facetoday.spring.web.vo.BoardVo;
import facetoday.spring.web.vo.ImageVo;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.MorphologyVo;
import facetoday.util.DBUtil;

public class BoardDaoImpl implements BoardDao {

	@Override
	public int boardInsert(BoardVo vo)throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		
		boolean commit = false;
		int result;
		
		
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("board.boardInsert",vo);
			commit = result > 0 ? true : false;

		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		
		return result;
	}
	
	@Override
	public List<BoardJoinMemberVo> boardSelectAll(String email, String social) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		List<BoardJoinMemberVo> list = null;
		MemberVo vo = new MemberVo(email,social);
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("board.boardSelectAll",vo);

		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return list;
	}
	
	@Override
	public List<BoardJoinMemberVo> boardSelectAll(MemberVo vo) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		List<BoardJoinMemberVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("board.boardSelectMe",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return list;
	}

	@Override
	public int boardDelete(int board_num) {
		// TODO Auto-generated method stub
		SqlSession session = null;
		boolean commit = false;
		
		int re = 0;
		
		try {
			session = DBUtil.getSqlSession();
			re = session.delete("board.boardDelete", board_num);
			commit = re > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		return re;
	}
	
	@Override
	public int boardUpdate(BoardVo boardVo) {
		SqlSession session = null;
		boolean commit = false;
		
		int re = 0;
		
		try {
			session = DBUtil.getSqlSession();
			re = session.update("board.boardUpdate",boardVo);
			commit = re > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		return re;
	}
	
	@Override
	public List<MorphologyVo> MorphologyList() throws SQLException {
		SqlSession session = null;
		List<MorphologyVo> morphologyList = null;
		
		try {
			session = DBUtil.getSqlSession();
			morphologyList = session.selectList("board.morphologyList");
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return morphologyList;
	}
	
	// 기분 관련
	
	/**
	 * 보드 날짜, 키워드, 수치 출력
	 */
	@Override
	public List<BoardVo> selectEmotion(MemberVo vo) throws SQLException {
		SqlSession session = null;
		List<BoardVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("board.selectEmotion",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return list;
	}
	
	/**
	 * 친구 맺기
	 */
	@Override
	public int matchingFriend(String email2, String email) throws SQLException {
		return 0;
	}
	
	/**
	 * 이미지 저장
	 */
	@Override
	public int imageInsert(ImageVo vo) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		
		boolean commit = false;
		int result;
		
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("board.imageInsert",vo);
			commit = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		
		return result;
	}
	
	@Override
	public int imageExtract(String image) throws SQLException {
		SqlSession session = null;
		int result = 0;
		
		try {
			session = DBUtil.getSqlSession();
			result = session.selectOne("board.imageExtract",image);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return result;
	}

	@Override
	public List<BoardVo> selectImages(MemberVo vo) throws SQLException {
		SqlSession session = null;
		List<BoardVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("board.imageList",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return list;
	}
	
	@Override
	public List<ImageVo> getPhotoWall(MemberVo vo) throws SQLException {
		SqlSession session = null;
		List<ImageVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("board.photoWall",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
}
