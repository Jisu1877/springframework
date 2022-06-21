package com.spring.javagreenS;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value = "name", defaultValue = "", required = false) String name,
			@RequestParam(value = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(value = "idx", defaultValue = "0", required = false) String idx) {
		
		if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록 등록이 완료되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("adminInputCheckNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "admin/adminInputCheck");
		}
		else if(msgFlag.equals("adminInputYes")) {
			model.addAttribute("msg", "관리자 등록이 완료되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("adminLoginYes")) {
			model.addAttribute("msg", name+"님 환영합니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memLoginOk")) {
			model.addAttribute("msg", mid+"님 반갑습니다.");
			model.addAttribute("url", "member/memMain");
		}
		else if(msgFlag.equals("memLoginNo")) {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("adminLoginNo")) {
			model.addAttribute("msg", "입력하신 정보와 일치하는 관리자 정보가 없습니다.");
			model.addAttribute("url", "admin/adminLogin");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되었습니다.");
			model.addAttribute("url", "");
		}
		else if(msgFlag.equals("memLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("operatorCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다. 다시 입력하세요.");
			model.addAttribute("url", "study/password2/operatorMenu");
		}
		else if(msgFlag.equals("operatorInputOk")) {
			model.addAttribute("msg", "운영자 등록이 완료되었습니다.");
			model.addAttribute("url", "study/password2/operatorMenu");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품등록이 완료되었습니다.");
			model.addAttribute("url", "shop/input/productMenu");
		}
		else if(msgFlag.equals("memIdCheckNo")) {
			model.addAttribute("msg", "회원가입 처리 실패(중복된 아이디입니다.)");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memNickCheckNo")) {
			model.addAttribute("msg", "회원가입 처리 실패(중복된 닉네임입니다.)");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memInputOk")) {
			model.addAttribute("msg", "회원가입이 완료되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memInputNo")) {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일 업로드가 완료되었습니다.");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일 업로드에 실패했습니다.");
			model.addAttribute("url", "study/fileUpload/fileUpload");
		}
		
		return "include/message";
	}
}
