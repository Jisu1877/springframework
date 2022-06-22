package com.spring.javagreenS;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS.pagination.PageVO;
import com.spring.javagreenS.pagination.PagingProcess;
import com.spring.javagreenS.service.BoardService;
import com.spring.javagreenS.service.MemberService;
import com.spring.javagreenS.vo.BoardVO;
import com.spring.javagreenS.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService; 
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/boList", method = RequestMethod.GET)
	public String boListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			Model model) {
		PageVO pageVO = pagingProcess.pageProcess2(pag, pageSize, "board", "", "");
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		return "board/boList";
	}
	
	@RequestMapping(value = "/boInput", method = RequestMethod.GET)
	public String boInputGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemIdCheck(mid);
		model.addAttribute("vo", vo);
		return "board/boInput";
	}
	
	@RequestMapping(value = "/boInput", method = RequestMethod.POST)
	public String boInputPost(BoardVO vo) {
		//만약에 content에 이미지가 저장되어 있다면, 저장된 이미지만을 /resources/data/ckeditor/board/ 폴더에 저장시켜준다.
		boardService.imgCheck(vo.getContent());
		
		//이미지 복사작업이 끝나면, board폴더에 실제로 저장된 파일명을 DB에 저장시켜준다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		boardService.setBoardInput(vo);
		
		return "redirect:/msg/boInputOk";
	}
	
	@RequestMapping(value = "/boContent", method = RequestMethod.GET)
	public String boContentGet(int idx, int pag, int pageSize, Model model) {
		//조회수 증가
		boardService.setReadNum(idx);
		
		//원본글 가져오기
		BoardVO vo = boardService.getBoardContent(idx);
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "board/boContent";
	}
	
	
}
