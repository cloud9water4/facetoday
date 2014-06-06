package facetoday.spring.web.controller;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import facetoday.spring.service.MemberService;
import facetoday.spring.web.vo.FriendsVo;
import facetoday.spring.web.vo.MemberVo;

@Controller
public class MemberController {
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@RequestMapping("/social.do")
	public ModelAndView join(String email, String name, final HttpSession session) {
		
		boolean check = false;
		List<MemberVo> list = null;
		ModelAndView mv = new ModelAndView();
		MemberVo vo = null;
		
		try {
			//1. 먼저 기존 이메일로 로그인되어 있는지 체크한다.
			check = memberService.emailCheck(email);
			vo = new MemberVo(email,"1",name,"facebook");
			
			//2. check가 true라면? 이메일 중복이 없다면 가입시킨다.
			if (check) {	
				memberService.memberInsert(vo);
			} 
			
			list = memberService.selectAllMember(email);
			//3.반드시 news로 페이지를 분기한다.
			mv.setViewName("/news");
			session.setAttribute("userInfo",vo);
			mv.addObject("FriendList",list);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		} 
		
		return mv;
	}
	
	@RequestMapping("/join.do")
	public ModelAndView join(MemberVo vo, String passwd_confirm) {
		ModelAndView mv = new ModelAndView();
			
		try {
			vo.setSocial("origin");
			memberService.memberInsert(vo, passwd_confirm);
			mv.addObject("name",vo.getName() );
			mv.setViewName("/login");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
		
		return mv;
	}

	@RequestMapping("signin.do")
	public ModelAndView signin(String signEmail, String signPasswd,final HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVo memberVo = null;
		List<MemberVo> list = null;
		List<FriendsVo> checkFollower = null;
		String sources = null;
		
		try {
			memberVo = memberService.login(signEmail, signPasswd);
			
			//소셜계정 로그인시 비밀번호 악용하여 들어오는 것 방지위해 origin 체크
			if (memberVo.getSocial().equals("origin")) {
				mv.setViewName("/news");
				session.setAttribute("userInfo",memberVo);
				checkFollower = memberService.checkFollower(memberVo);
				sources = memberService.recentMusic(memberVo);
				mv.addObject("sources",sources);
				mv.addObject("checkFollower",checkFollower);
	            
			} else {
				throw new Exception("아이디 혹은 비밀번호가 일치하지 않습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			mv.setViewName("/error");
			mv.addObject("message",e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("/error");
			mv.addObject("message",e.getMessage());
		}
				
		return mv;
	}
	
	@RequestMapping("searchUser.do")
	public ModelAndView searchUser(MemberVo vo, String keyword) {
		List<MemberVo> list = null;
		ModelAndView mv = new ModelAndView();
		FriendsVo friendVo = null;
		
		System.out.println(keyword);
		System.out.println(vo.getEmail());
		System.out.println(vo.getSocial());
		
		if (keyword.matches(".*@.*")) {
			friendVo = new FriendsVo(keyword, null, vo.getEmail(), vo.getSocial(), null);
		} else {
			friendVo = new FriendsVo(null, null, vo.getEmail(), vo.getSocial(), keyword);
		}
		
		System.out.println(friendVo);
		try {
			list = memberService.searchUser(friendVo);
			mv.addObject("searchUserlist",list);
		} catch(SQLException e) {
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping("addFriend.do")
	@ResponseBody
	public String addFriend(String emailFriend, String socialFriend,MemberVo vo) {
		ModelAndView mv = new ModelAndView();
		FriendsVo friendsVo = new FriendsVo(emailFriend,socialFriend,vo.getEmail(),vo.getSocial());
		String re = "0";
		
		try {
			if(memberService.addFriends(friendsVo)>0)
				re="1";
		} catch (SQLException e) {
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
		return re;
	}
}
