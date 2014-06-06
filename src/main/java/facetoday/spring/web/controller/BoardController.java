package facetoday.spring.web.controller;

import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import facetoday.spring.service.BoardService;
import facetoday.spring.service.SongService;
import facetoday.spring.web.vo.BoardJoinMemberVo;
import facetoday.spring.web.vo.BoardVo;
import facetoday.spring.web.vo.ImageVo;
import facetoday.spring.web.vo.MemberVo;
import facetoday.spring.web.vo.SongListVo;

@Controller
public class BoardController {
	private int updSupport_boardNum;
	
	@Resource(name="boardService")
	private BoardService boardService;
	@Resource(name="SongService")
	private SongService songService;
	
	@RequestMapping("/insert.do")
	@ResponseBody
	public String insertBoard(BoardVo boardVo, String time, String filename, String tagString) {

		String re = "0";
		String imageName = null;
		if (filename != null) {
			String str = filename.replace("C:\\fakepath\\", "");
			imageName=boardVo.getEmail()+boardVo.getSocial()+time+str;
			boardVo.setImage(imageName);
		}

		try {
			int result = boardService.boardInsert(boardVo);
			if(result > 0) re ="1";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return re;
	}

	@RequestMapping("/upload.do")
	@ResponseBody
	public String upload(ImageVo vo, @RequestParam("file") MultipartFile file) {
		String re = "0";
		
		String name = file.getOriginalFilename();
		//long time = System.currentTimeMillis();
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMDDHHmmssSSS");
		String time = dateFormat.format(calendar.getTime());
		String temp = time.substring(0,18);
		
		time = temp;
		
		vo.setImage(vo.getEmail()+vo.getSocial()+time+name);
		
		try{
			//폴더에 파일 저장
			file.transferTo(new File("D://finalProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/projectSpring/facetodayDB/"+vo.getEmail()+vo.getSocial()+time+name));
		}catch(Exception e){
			System.out.println(e+ "=> 파일저장 fail");
		}
		
		try {
			int result = boardService.imageInsert(vo);
			if (result > 0) {
				re= time;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return re;
	}
	
	@RequestMapping("/selectAll.do")
	public ModelAndView selectBoardAll(String email, String social) {	
		List<BoardJoinMemberVo> list = null;
		try {
			list = boardService.boardSelectAll(email, social);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/selectAllMe.do")
	public ModelAndView selectBoardAll(MemberVo vo) {	
		List<BoardJoinMemberVo> list = null;
		try {
			list = boardService.boardSelectAll(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/emotion.do")
	public ModelAndView extractEmotion(MemberVo vo) {
		List<BoardVo> list = null;
		System.out.println("emotion");
		
		System.out.println(vo.getEmail());
		System.out.println(vo.getSocial());
		try {
			list = boardService.selectEmotion(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("Emotionlist",list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/delete.do")
	@ResponseBody
	public String deleteBoard(int board_num) {
		String re = "0";
		
		//console 확인용
		System.out.println("지울 글 번호:"+board_num);
		
		if(boardService.boardDelete(board_num)>0)
			re="1";
		
		return re;
	}
	
	@RequestMapping("/update.do")
	@ResponseBody
	public String updateBoard(String updateContent) {
		String re = "0";
		
		//console 확인용
		System.out.println("수정할 글 내용 및 번호:"+updateContent+","+updSupport_boardNum);		
		
		BoardVo boardVo = new BoardVo(updSupport_boardNum,updateContent);
		
		if(boardService.boardUpdate(boardVo)>0) 
			re="1";
		
		return re;
	}
	
	
		
	@RequestMapping("/updateSupport.do")
	@ResponseBody
	public String updateSupport(int board_num) {
		//console 확인 및 modal 글 번호 임시 저장.
		System.out.println("글 번호 :"+board_num);
		updSupport_boardNum = board_num;
		System.out.println(updSupport_boardNum);
		
		return "1";
	}
	
	@RequestMapping("/main.do")
	public ModelAndView myPageShift(MemberVo vo) {
		ModelAndView mv = new ModelAndView();
		List<BoardVo> list = null;
		List<SongListVo> userlist = null;
		
		try {
			list = boardService.selectImage(vo);
			userlist = songService.userlistAll(vo);
			mv.setViewName("/main");
			mv.addObject("imageList",list);
			mv.addObject("userlist",userlist);
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
	
	@RequestMapping("/deleteUserlist.do")
	public ModelAndView myPageShift(MemberVo vo, int list_num) {
		ModelAndView mv = new ModelAndView();
		List<BoardVo> list = null;
		List<SongListVo> userlist = null;
		
		
		try {
			songService.deleteList(list_num);
			list = boardService.selectImage(vo);
			userlist = songService.userlistAll(vo);
			mv.setViewName("/main");
			mv.addObject("imageList",list);
			mv.addObject("userlist",userlist);
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
	
	@RequestMapping("/imageInit.do")
	public ModelAndView gallery(MemberVo vo) {
		
		List<ImageVo> list = null;
			
		try {
			list = boardService.getPhotoWall(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("/gallery");
		
		return mv;
			
	}
	
	
	//진행 중....
	@RequestMapping("/friend.do")
	public void matchingFriend(String email, String email2) {
		System.out.println("내 이메일 :"+email);
		System.out.println("친구 이메일 :"+email2);
	}
}