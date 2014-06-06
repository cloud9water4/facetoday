package facetoday.spring.web.dao;

import java.sql.SQLException;
import java.util.List;

import facetoday.spring.web.vo.FriendsVo;
import facetoday.spring.web.vo.MemberVo;

public interface MemberDao {
	/**
	 * 회원 가입
	 */
	int memberInsert(MemberVo memberVo) throws SQLException;
	
	// 멤버 관련
	
	/**
	 * 로그인
	 */
	List<MemberVo> login(String email) throws SQLException;
	
	/**
	 * 친구 추천... 현재는 친구 추천을 전 멤버를 준다.
	 */
	List<MemberVo> selectAllMember(String email) throws SQLException;
	
	/**
	 * 이미 존재하는 이메일인지 체크하는 함수
	 */
	boolean emailCheck(String email) throws SQLException;
	
	/**
	 * 최근 들은 음악 목록 추출
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public String recentMusic(MemberVo vo) throws SQLException;
	
	/**
	 * 친구 찾기
	 */
	List<MemberVo> searchUser(FriendsVo vo) throws SQLException;
	
	/**
	 * 친구 추가하기
	 */
	int addFriends(FriendsVo vo) throws SQLException;
	
	/**
	 * 나를 체크한 친구가 있는지 살펴보기
	 */
	List<FriendsVo> checkFollower(MemberVo vo) throws SQLException;
}
