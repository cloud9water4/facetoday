package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import facetoday.spring.web.vo.FriendsVo;
import facetoday.spring.web.vo.MemberVo;
import facetoday.util.DBUtil;

public class MemberDaoImpl implements MemberDao {
	
	@Override
	public int memberInsert(MemberVo memberVo) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		
		boolean commit = false;
		int result=0;
	
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("member.insertMember",memberVo);
			commit = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(session,commit);
		}
		return result;
	}
	
	/**
	 * 
	 *  member 부분
	 */
	
	@Override
	public List<MemberVo> login(String email) throws SQLException {
		SqlSession session = null;
		List<MemberVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("member.login",email);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return list;
	}
	
	@Override
	public String recentMusic(MemberVo vo) throws SQLException {
		SqlSession session = null;
		String sources = null;
		
		try {
			session = DBUtil.getSqlSession();
			sources = session.selectOne("member.recentList", vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return sources;
	}
	@Override
	public List<MemberVo> selectAllMember(String email) throws SQLException {
		SqlSession session = null;
		List<MemberVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("member.selectAllMember",email);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	
	/**
	 * 이메일 체크해서 기존에 존재하는 이메일인지 확인하기. false여야 가입시키기
	 * 
	 */
	@Override
	public boolean emailCheck(String email) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession session = null;
		MemberVo vo = null;
		boolean result = true;
		
		try {
			session = DBUtil.getSqlSession();
			vo = session.selectOne("member.emailCheck",email);
			
			if (vo != null && vo.getEmail()!=null && vo.getSocial().equals("facebook")) {
				result = false;
			}
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return result;
	}

	@Override
	public List<MemberVo> searchUser(FriendsVo vo) throws SQLException {
		SqlSession session = null;
		List<MemberVo> list = null;
		
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("member.searchUser",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		
		return list;
	}
	
	@Override
	public int addFriends(FriendsVo vo) throws SQLException {
		SqlSession session = null;
		int result = 0;
		boolean commit = false;
		
		try {
			session = DBUtil.getSqlSession();	
			result = session.insert("member.addFriend", vo);
			commit = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(session, commit);
		}	
		return result;
	}

	@Override
	public List<FriendsVo> checkFollower(MemberVo vo) throws SQLException {
		SqlSession session = null;
		List<FriendsVo> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("member.checkFollower",vo);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
}
