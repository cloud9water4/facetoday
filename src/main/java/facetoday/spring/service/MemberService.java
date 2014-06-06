package facetoday.spring.service;

import java.sql.SQLException;
import java.util.List;

import facetoday.spring.web.vo.FriendsVo;
import facetoday.spring.web.vo.MemberVo;

public interface MemberService {
	
	/**
	 * 회원가입
	 */
	int memberInsert(MemberVo memberVo,String passwdConfirm) throws Exception;
	/**
	 * 
	 * 소셜 계정 회원가입
	 * 
	 */
	int memberInsert(MemberVo vo);
	
	/**
	 * 로그인 과정
	 */
	MemberVo login(String email, String passwd) throws SQLException;
	
	/**
	 * 친구 추천... 현재는 친구 추천을 전 멤버를 준다.
	 */
	List<MemberVo> selectAllMember(String email) throws SQLException;
	
	/**
	 * email 확인용
	 */
	boolean emailCheck(String email) throws SQLException;
	
	/**
	 * 최근 들은 노래 목록
	 */
	String recentMusic(MemberVo vo) throws SQLException;
	
	/**
	 * 유저 검색
	 */
	List<MemberVo> searchUser(FriendsVo vo) throws SQLException;
	
	/**
	 * 친구 추가
	 */
	int addFriends(FriendsVo vo) throws SQLException;
	
	/**
	 * 팔로워 체킹
	 */
	List<FriendsVo> checkFollower(MemberVo vo) throws SQLException;
}
