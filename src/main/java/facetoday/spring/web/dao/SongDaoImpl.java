package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.SongListVo;
import facetoday.spring.web.vo.SongVo;
import facetoday.util.DBUtil;

public class SongDaoImpl implements SongDao {

	@Override
	public List<SongVo> selectAll() throws SQLException {
		SqlSession session = null;
		List<SongVo> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("song.songSelect");
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}

	@Override
	public List<SongVo> songSelectByWeather(String weather) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		List<SongVo> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectOne("song.songSelectByWeather", weather);

		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}

	@Override
	public boolean createList(SongListVo vo) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		boolean commit = false;
		int result = 0;
		String check = null;
		
		try {
			session = DBUtil.getSqlSession();
			check = session.selectOne("member.recentList", vo);
			if (check == null) {
				result = session.insert("song.createList",vo);
				commit = result > 0 ? true : false;
			} else {
				result = session.update("song.updateList",vo);
				commit = result > 0 ? true : false;
			}
			
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		
		return commit;
	}
	
	@Override
	public boolean userList(SongListVo vo) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		boolean commit = false;
		int result = 0;
		String check = null;
		
		try {
			session = DBUtil.getSqlSession();
			check = session.selectOne("song.userListCheck", vo);
			
			if (check == null) {
				result = session.insert("song.userList",vo);
				commit = result > 0 ? true : false;
			} else {
				result = session.update("song.userListUpdate",vo);
				commit = result > 0 ? true : false;
			}
			
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}
		
		return commit;
	}

	@Override
	public List<SongListVo> userlistAll(MemberVo vo) throws SQLException {
		SqlSession session = null;
		List<SongListVo> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("song.userlistAll",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
}