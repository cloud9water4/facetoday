package facetoday.spring.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import facetoday.exception.PasswdConfirmException;
import facetoday.service.PwdEncryption;
import facetoday.spring.web.dao.MemberDao;
import facetoday.spring.web.vo.FriendsVo;
import facetoday.spring.web.vo.MemberVo;

public class MemberServiceImpl implements MemberService {
	
	
	@Resource(name = "memberDao")
	private MemberDao memberDao;
	
	
	/**
	 * 회원 가입 - 소셜 계정의 경우
	 */
	@Override
	public int memberInsert(MemberVo vo) {
		
		int result = 0;
		
		try {
			result = memberDao.memberInsert(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 회원 가입
	 */
	@Override
	public int memberInsert(MemberVo memberVo, String passwdConfirm) throws Exception {
		
		int result = 0;
		
		if (memberVo.getPasswd().equals(passwdConfirm)) {
			memberVo.setPasswd(PwdEncryption.pwdCode(memberVo.getPasswd()));
			result = memberDao.memberInsert(memberVo);
		} else {
			System.out.println("비번 틀림");
			throw new PasswdConfirmException();
		}
		
		if (result == 0) {
			throw new SQLException("가입하는 중 오류가 발생했습니다.");
		}
		
		return result;
	}
	
	@Override
	public String recentMusic(MemberVo vo) throws SQLException {
		return memberDao.recentMusic(vo);
	}
	/**
	 * 로그인 과정
	 */
	@Override
	public MemberVo login(String email, String passwd) throws SQLException {
		
		List<MemberVo> list = memberDao.login(email);
		MemberVo memberVo = null;
		
		if(list.isEmpty()) {
			throw new SQLException("없는 이메일입니다.");
		} else {
			if(PwdEncryption.pwdCode(passwd).equals(list.get(0).getPasswd()))
				memberVo = new MemberVo(list.get(0).getEmail(),list.get(0).getName(),list.get(0).getPasswd(),list.get(0).getBirth(),list.get(0).getSocial());
			else
				throw new SQLException("비밀번호가 일치하지 않습니다.");
		}
		
		return memberVo;
	}
	
	/**
	 * 친구 추천... 현재는 친구 추천을 전 멤버를 준다.
	 */
	@Override
	public List<MemberVo> selectAllMember(String email) throws SQLException {
		
		List<MemberVo> list = memberDao.selectAllMember(email);
		
		if (list.isEmpty()) {
			throw new SQLException("추천할 친구가 없습니다.");
		} 
		
		return list;
	}
	
	/**
	 * 이메일 체크
	 */
	@Override
	public boolean emailCheck(String email) throws SQLException {
		// TODO Auto-generated method stub
		return memberDao.emailCheck(email);
	}

	@Override
	public List<MemberVo> searchUser(FriendsVo vo) throws SQLException {
		return memberDao.searchUser(vo);
	}

	@Override
	public int addFriends(FriendsVo vo) throws SQLException {
		int result = memberDao.addFriends(vo);
		
		if (result == 0)
			throw new SQLException("친구가 추가되지 않았습니다.");
			
		return result;
	}

	@Override
	public List<FriendsVo> checkFollower(MemberVo vo) throws SQLException {
		
		return memberDao.checkFollower(vo);
	}
}
