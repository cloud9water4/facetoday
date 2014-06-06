package facetoday.spring.web.controller;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import facetoday.spring.service.CommentService;
import facetoday.spring.web.vo.BoardJoinMemberVo;
import facetoday.spring.web.vo.CommentVo;

@Controller
public class CommentController {
	
	@Resource(name="commentService")
	private CommentService commentService;
	
	@RequestMapping("/writeComment.do")
	@ResponseBody
	public String writeComment(CommentVo vo) {
		String result = "0";
		
		try {
			int res = commentService.writeContent(vo);
			if (res > 0) {
				result = Integer.toString(vo.getBoard_num()); 
			} else {
				result = "0";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping("/commentView.do")
	public ModelAndView commetnView(int board_num) {
		List<CommentVo> list = null;
		ModelAndView mv = new ModelAndView();

		try {
			list = commentService.commentView(board_num);
		} catch(SQLException e) {
			e.printStackTrace();
			mv.setViewName("/error");
			mv.addObject("message", e.getMessage());
		}
		mv.addObject("Commentlist",list);
		mv.setViewName("jsonView");
		return mv;
		
	}

	@RequestMapping("/commentCount.do")
	@ResponseBody
	public String commentCount(int comment_num) {
		int result = 0;
		
		System.out.println(comment_num);
		try {
			result = commentService.commentCount(comment_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Integer.toString(result);
	}
}
