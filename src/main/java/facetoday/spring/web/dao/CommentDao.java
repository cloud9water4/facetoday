package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import facetoday.spring.web.vo.CommentVo;
import facetoday.util.DBUtil;

public class CommentDao {
	
	public int writeComment(CommentVo vo) throws SQLException {
		SqlSession session = null;
		boolean commit = false;
		int result;
		String name = nameExtract(vo);
		vo.setName(name);
		
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("comment.commentInsert",vo);
			commit = result > 0 ? true : false;
			
			if (commit) {
				commentInsertCount(vo.getBoard_num());
			}
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		
		return result;
	}
	public int commentInsertCount(int board_num) throws SQLException {
		SqlSession session = null;
		int result = 0;
		boolean commit = false;
		
		try {
			session = DBUtil.getSqlSession();
			result = session.update("comment.commentInsertCount",board_num);
			commit = result > 0 ? true : false; 
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		
		return result;
	}
	public String nameExtract(CommentVo vo) {
		SqlSession session = null;
		String name = null;
		
		try {
			session = DBUtil.getSqlSession();
			name = session.selectOne("comment.extractName",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return name;
	}
	
	public int commentCount(int comment_num) throws SQLException {
		SqlSession session  = null;
		int num = 0;
		try {
			session = DBUtil.getSqlSession();
			num = session.selectOne("comment.commentCount", comment_num);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return num;
	}
	
	public List<CommentVo> commentView(int board_num) {
		SqlSession session = null;
		List<CommentVo> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("comment.commentView",board_num);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
}
