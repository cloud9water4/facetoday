package facetoday.spring.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import facetoday.spring.web.dao.CommentDao;
import facetoday.spring.web.vo.CommentVo;

public class CommentService {
	
	@Resource(name="commentDao")
	private CommentDao commentDao;
	
	public int writeContent(CommentVo vo) throws SQLException {
		return commentDao.writeComment(vo);
	}
	
	public int commentCount(int comment_num) throws SQLException {
		return commentDao.commentCount(comment_num);
	}
	
	public List<CommentVo> commentView(int board_num) throws SQLException {
		return commentDao.commentView(board_num);
	}
}
