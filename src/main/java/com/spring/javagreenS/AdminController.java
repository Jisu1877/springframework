package com.spring.javagreenS;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.javagreenS.service.AdminService;
import com.spring.javagreenS.vo.AdminTestVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	//관리자 등록 창으로 이동하기 위한 인증확인 창으로 이동
	@RequestMapping(value = "/adminInputCheck", method = RequestMethod.GET)
	public String adminInputCheckGet() {
		return "admin/adminInputCheck";
	}
	
	//관리자 등록 창으로 이동하기 위한 인증확인
	@RequestMapping(value = "/adminInputCheck", method = RequestMethod.POST)
	public String adminInputCheckPost(String pwd) {
		if(pwd.equals("a!1234")) {
			return "redirect:/admin/adminInput";
		}
		else {
			return "redirect:/msg/adminInputCheckNo";
		}
	}
	
	//관리자 등록 창으로 이동
	@RequestMapping(value = "/adminInput", method = RequestMethod.GET)
	public String adminInputGet() {
		return "admin/adminInput";
	}
	
	
	//관리자 등록처리
	@RequestMapping(value = "/adminInput", method = RequestMethod.POST)
	public String adminInputPost(AdminTestVO vo) {
		//암호화를 위한 키 가져오기
		int random = (int)(Math.random()*50)+1;
		String keyValue = adminService.getKeyValue(random);
		
		//keyValue 를 아스키코드로 변환
		long key;
		String strKey = "";
		for(int i=0; i<keyValue.length(); i++) {
			key = keyValue.charAt(i);
			strKey += key;
		}
		
		//키를 long 타입으로 바꾸기
		key = Long.parseLong(strKey);
		
		//입력문자가 영문 소문자일 경우는 대문자로 변경처리(ㅇ자리수때문에)
		String pwd = vo.getPwd().toUpperCase();
		
		//입력된 비밀번호를 아스키코드로 변환하여 누적처리
		long longPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			longPwd = pwd.charAt(i);
			strPwd += longPwd;
		}
		
		//암호화한 키를 저장할 변수 선언
		long encPwd;
		
		//문자로 결합된 숫자를, 연산하기위해 다시 숫자로 변환한다.
		longPwd = Long.parseLong(strPwd);
		
		//암호화처리
		encPwd = longPwd ^ key;
		
		//DB에 저장을 할때 문장으로 저장하기 위해 바꿔준다.
		strPwd = String.valueOf(encPwd);
		
		adminService.setAdminInput(vo,strPwd,random);
		
		return "redirect:/msg/adminInputYes";
	}
	
	//관리자 로그인 창으로 이동
	@RequestMapping(value = "/adminLogin", method = RequestMethod.GET)
	public String adminLoginGet() {
		return "admin/adminLogin";
	}

	//관리자 로그인 체크 처리
	@RequestMapping(value = "/adminLogin", method = RequestMethod.POST)
	public String adminLoginPost(AdminTestVO vo, RedirectAttributes redirect, HttpSession session) {
		//아이디로 idxKey 가져오기
		AdminTestVO vo2 = adminService.getIdxKey(vo.getMid());
		
		if(vo2 == null ) {
			return "redirect:/msg/adminLoginNo";
		}
		//가져온 idxKey로 hashKey 테이블에서 keyValue 가져오기
		//int random = Integer.parseInt(vo2.getIdxKey());
		String keyValue = adminService.getKeyValue(vo2.getIdxKey());
		
		//keyValue 를 아스키코드로 변환
		long key;
		String strKey = "";
		for(int i=0; i<keyValue.length(); i++) {
			key = keyValue.charAt(i);
			strKey += key;
		}
		
		//키를 long 타입으로 바꾸기
		key = Long.parseLong(strKey);
		
		//입력문자가 영문 소문자일 경우는 대문자로 변경처리(자리수때문에)
		String pwd = vo.getPwd().toUpperCase();
		
		//입력된 비밀번호를 아스키코드로 변환하여 누적처리
		long longPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			longPwd = pwd.charAt(i);
			strPwd += longPwd;
		}
		
		//암호화한 키를 저장할 변수 선언
		long encPwd;
		
		// 문자로 결합된 숫자를, 연산하기위해 다시 숫자로 변환한다.
		longPwd = Long.parseLong(strPwd);
		
		//암호화처리
		encPwd = longPwd ^ key;
		
		//DB에 저장한 암호화 비밀번호와 비교를 하기위해 String type으로 변경.
		strPwd = String.valueOf(encPwd);
		
		if(vo2.getPwd().equals(strPwd)) {
			session.setAttribute("sMid", vo2.getMid());
			redirect.addAttribute("name", vo2.getName());
			return "redirect:/msg/adminLoginYes";
		}
		else {
			return "redirect:/msg/adminLoginNo";
		}
	}
	
	//관리자 로그아웃
	@RequestMapping(value = "/adminLogout", method = RequestMethod.GET)
	public String adminLogoutGet(HttpSession session, RedirectAttributes redirect) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		redirect.addAttribute("mid", mid);
		return "redirect:/msg/adminLogout";
	}
}
