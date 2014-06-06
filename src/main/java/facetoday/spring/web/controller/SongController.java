package facetoday.spring.web.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import facetoday.spring.service.SongService;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.SongListVo;
import facetoday.spring.web.vo.SongVo;

@Controller
public class SongController {
	
	@Resource(name="SongService")
	private SongService songService;
	
	//SelectAll 노래 뽑기
	@RequestMapping(value="/songSelectAll.do")
	public ModelAndView songSelectAll(MemberVo vo) {
		
		ModelAndView mv = new ModelAndView();
		List<SongVo> list = null;
		List<SongListVo> userlist = null;
		
		try {
			userlist = songService.userlistAll(vo);
			list = songService.selectAll();
			mv.setViewName("songList");
			mv.addObject("songs",list);
			mv.addObject("userlist",userlist);
		} catch (SQLException e) {
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
		return mv;
	}
	
	//체크된 소스 뽑기
	@RequestMapping(value = "/check.do")
	public ModelAndView checkSong(@RequestParam("check") String check, String email, String social, String list_name) {
		String sources = songService.checkSong(check);
		ModelAndView mv = new ModelAndView();

		boolean createList = false;
		SongListVo vo = new SongListVo(email,social,sources,list_name);
		
		try {
			if (list_name == "") {
				createList = songService.createList(vo);
			} else {
				createList = songService.userList(vo);
			}
			
			mv.setViewName("/news");
			mv.addObject("check", sources);
		} catch (SQLException e) {
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
	
		return mv;
	}
	
	//날씨에 따른 추천
	@RequestMapping(value = "/proposelist.do")
	public ModelAndView proposelist(String weather) {
		String sources = null;
		ModelAndView mv = new ModelAndView();
	
		try {
			sources = songService.songSelectByWeather(weather);
			mv.setViewName("/news");
			mv.addObject("check", sources);
		} catch (SQLException e) {
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
	
		return mv;
	}
	//날씨에 따른 추천
	@RequestMapping(value = "/proposelistEmotion.do")
	public ModelAndView proposelist(MemberVo vo) {
		String sources = null;
		ModelAndView mv = new ModelAndView();
	
		try {
			sources = songService.songSelectByState(vo);
			mv.setViewName("/news");
			mv.addObject("check", sources);
		} catch (SQLException e) {
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
	
		return mv;
	}

		
	@RequestMapping(value = "/naverList.do")
	public ModelAndView naverList() {
		ModelAndView mv = new ModelAndView();
		List list = null;

		try {
			list = songService.NaverList();
			mv.setViewName("naverList");
			mv.addObject("songs", list);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
		return mv;
	}
	
	@RequestMapping(value="/userlistPlay.do")
	public ModelAndView userlistPlay(String sources) {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/news");
		mv.addObject("check", sources);
		return mv;
	}
}
