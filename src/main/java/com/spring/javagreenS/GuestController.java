package com.spring.javagreenS;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS.pagination.PageVO;
import com.spring.javagreenS.pagination.PagingProcess;
import com.spring.javagreenS.service.GuestService;
import com.spring.javagreenS.vo.GuestVO;
import com.spring.javagreenS.vo.MemberVO;

@Controller
@RequestMapping("/guest")
public class GuestController {
	
	@Autowired
	GuestService guestService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/guestList", method = RequestMethod.GET)
	public String guestListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag) {
		/*
		 * //페이징처리를 위한 준비... int pageSize = 3; int totRecCnt = guestService.totRecCnt();
		 * int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt
		 * / pageSize) + 1; int startIndexNo = (pag - 1) * pageSize; int curScrStartNo =
		 * totRecCnt - startIndexNo;
		 * 
		 * int blockSize = 3; int curBlock = (pag - 1) / blockSize; int lastBlock =
		 * (totPage % blockSize) == 0 ? (totPage / blockSize) - 1 : (totPage /
		 * blockSize);
		 * 
		 * ArrayList<GuestVO> vos = guestService.getGuestList(startIndexNo, pageSize);
		 * 
		 * model.addAttribute("vos", vos); //request에 담기(웹서버에 올라감)
		 * model.addAttribute("curScrStartNo", curScrStartNo); model.addAttribute("pag",
		 * pag); model.addAttribute("totPage", totPage); model.addAttribute("blockSize",
		 * blockSize); model.addAttribute("curBlock", curBlock);
		 * model.addAttribute("lastBlock", lastBlock); model.addAttribute("pageSize",
		 * pageSize);
		 */
		
		PageVO pageVO = pagingProcess.pageProcess("guest", pag);
		ArrayList<GuestVO> vos = guestService.getGuestList(pageVO.getStartIndexNo(), pageVO.getPageSize());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "guest/guestList";
	}
	
	@RequestMapping(value = "/guestInput", method = RequestMethod.GET)
	public String guestInputGet() {
		return "guest/guestInput";
	}
	
	@RequestMapping(value = "/guestInput", method = RequestMethod.POST)
	public String guestInputPost(GuestVO vo) {
		guestService.setGuestInput(vo);
		return "redirect:/msg/guestInputOk";
	}
}
