package com.spring.javagreenS;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.javagreenS.pagination.PageVO;
import com.spring.javagreenS.pagination.PagingProcess;
import com.spring.javagreenS.service.MemberService;
import com.spring.javagreenS.vo.GuestVO;
import com.spring.javagreenS.vo.MailVO;
import com.spring.javagreenS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService; 
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder; 
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	PagingProcess pagingProcess;
	
	//회원 로그인
	@RequestMapping(value = "/memLogin", method = RequestMethod.GET)
	public String memLoginGet(HttpServletRequest request) {
		// 로그인폼 호출시 기존에 저장된 쿠키가 있다면 불러와서 mid에 담아서 넘겨준다.
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		return "member/memLogin";
	}
	
	//로그인 인증처리
	@RequestMapping(value = "/memLogin", method = RequestMethod.POST)
	public String memLoginPost(Model model, HttpServletRequest request, HttpServletResponse response,
			String mid,
			String pwd,
			@RequestParam(name ="idCheck", defaultValue = "", required = false) String idCheck,
			HttpSession session) {
		
		MemberVO vo = memberService.getMemIdCheck(mid);
		
		//passwordEncoder.matches(내가 로그인시 입력한 비번, 회원가입시 입력한 비번)
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			//회원 인증처리된 경우에 수행할 내용들을 기술한다.(session에 저장할 자료 처리, 쿠키값 처리...)
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "운영자";
			else if(vo.getLevel() == 2) strLevel = "우수회원";
			else if(vo.getLevel() == 3) strLevel = "정회원";
			else if(vo.getLevel() == 4) strLevel = "준회원";

			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			if(idCheck.equals("on")) { //체크한 경우 'on'이라고 넘어간다.
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*7); //쿠키값을 7일간 저장(단위 : 초)
				response.addCookie(cookie); //쿠키저장
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0); //기존에 저장된 현재 mid값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			//방문횟수, 오늘방문횟수 누적하기, 최종 접속일 처리 - service 객체에서 처리
			memberService.setMemLoginUpdate(vo);
			
			//redirect.addAttribute("mid", vo.getMid());
			//request.setAttribute("name", vo.getName()); //값 안넘어감
			model.addAttribute("mid", vo.getMid()); //redirect 와 같이 사용이 불가하다.
			return "redirect:/msg/memLoginOk";
		}
		else {
			return "redirect:/msg/memLoginNo";
		}
	}
	
	
	@RequestMapping(value = "/memJoin", method = RequestMethod.GET)
	public String memJoinGet() {
		return "member/memJoin";
	}
	
	//회원가입 처리
	@RequestMapping(value = "/memJoin", method = RequestMethod.POST)
	public String memJoinPost(MultipartFile fName, MemberVO vo) {
		// 아이디 체크
		if(memberService.getMemIdCheck(vo.getMid()) != null) {
			return "redirect:/msg/memIdCheckNo";
		}
		// 닉네임체크
		if(memberService.getNickNameCheck(vo.getNickName()) != null) {
			return "redirect:/msg/memNickCheckNo";
		}
		
		//비밀번호 암호화 처리 후 vo에 다시 담기
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		//체크 완료된 자료를 다시 vo에 담았다면 DB에 저장시켜준다.
		int res = memberService.setMemInputOk(fName, vo);
		
		if(res == 1) {
			return "redirect:/msg/memInputOk";
		}
		else {
			return "redirect:/msg/memInputNo";
		}
	}
	
	//회원정보 수정 처리
	@RequestMapping(value = "/memUpdateOk", method = RequestMethod.POST)
	public String memUpdateOkPost(MultipartFile fName, MemberVO vo, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");
		if(!nickName.equals(vo.getNickName())) {
			// 닉네임체크
			if(memberService.getNickNameCheck(vo.getNickName()) != null) {
				return "redirect:/msg/memNickCheckNo2";
			}
		}
		
		//비밀번호 암호화 처리 후 vo에 다시 담기
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		//체크 완료된 자료를 다시 vo에 담았다면 DB에 저장시켜준다.
		int res = memberService.setMemUpdateOk(fName, vo);
		
		if(res == 1) {
			session.setAttribute("sNickName", vo.getNickName());
			return "redirect:/msg/memUpdateOk";
		}
		else {
			return "redirect:/msg/memUpdateNo";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/memIdCheck", method = RequestMethod.POST)
	public String memIdCheckPost(String mid) {
		String res = "0";
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null) {
			res = "1";
		}
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/nickNameCheck", method = RequestMethod.POST)
	public String nickNameCheck(String nickName) {
		String res = "0";
		MemberVO vo = memberService.getNickNameCheck(nickName);
		if(vo != null) {
			res = "1";
		}
		return res;
	}
	
	
	//로그아웃
	@RequestMapping(value = "/memLogout", method = RequestMethod.GET)
	public String adminLogoutGet(HttpSession session, RedirectAttributes redirect) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		redirect.addAttribute("mid", mid);
		return "redirect:/msg/memLogout";
	}
	
	@RequestMapping(value = "/memMain", method = RequestMethod.GET)
	public String memMainGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "member/memMain";
	}
	
	//회원 리스트 호출
	@RequestMapping(value = "/memList", method = RequestMethod.GET)
	public String memListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		/*
		PageVO pageVO = pagingProcess.pageProcess("member", pag);
		List<MemberVO> vos = memberService.getMemList(pageVO.getStartIndexNo(), pageVO.getPageSize());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		*/
		
		PageVO pageVO = pagingProcess.pageProcess2(pag, pageSize, "member","","");
		List<MemberVO> vos = memberService.getMemList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "member/memList";
	}
	
	//회원 상세 정보
	@RequestMapping(value = "/memInfor", method = RequestMethod.GET)
	public String memInforGet(Model model, String mid) {
		System.out.println("mid : " + mid);
		MemberVO vo = memberService.getMemIdCheck(mid);
		model.addAttribute("vo", vo);
		return "member/memInfor";
	}
	
	//회원 정보 변경처리를 위한 비밀번호 확인
	@RequestMapping(value = "/memPwdCheck", method = RequestMethod.GET)
	public String memPwdCheckGet() {
		return "member/memPwdCheck";
	}
	
	//회원 정보 변경처리를 위한 비밀번호 확인
	@RequestMapping(value = "/memPwdCheck", method = RequestMethod.POST)
	public String memPwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			vo.setPwd(pwd);
			model.addAttribute("vo",vo);
			return "member/memUpdate";
		}
		else {
			return "redirect:/msg/memPwdCheckNo";
		}
	}
	
	//회원탈퇴삭제하기
	@RequestMapping(value = "/memDeleteOk", method = RequestMethod.GET)
	public String memDeleteOkGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		memberService.setMemDeleteOk(mid);
		
		session.invalidate();
		model.addAttribute("mid", mid);
		
		return "redirect:/msg/memDeleteOk";
	}
	
	//아이디,비밀번호 찾기를 위한 창 호출
	@RequestMapping(value = "/memIdPwdSearch", method = RequestMethod.GET)
	public String memIdPwdSearchGet() {
		
		return "member/memIdPwdSearch";
	}
	
	//아이디,비밀번호 찾기를 위한 '임시비밀번호 발급'해주기
	@RequestMapping(value = "/memIdPwdSearchOk", method = RequestMethod.GET)
	public String memIdPwdSearchOkGet(String mid, String toMail) {
		MemberVO vo = memberService.getMemIdEmailCheck(mid, toMail);
		if(vo != null) {
			//회원정보가 맞으면 임시비밀번호를 만든다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			
			//발급한 임시비밀번호를 DB에 저장시키기
			memberService.setPwdChange(mid,passwordEncoder.encode(pwd));
			
			//임시비밀번호를 메일로 전송한다.
			String res = mailSend(toMail, pwd);
			
		  if(res.equals("1")) { 
			  return "redirect:/msg/memPwdSendOk"; 
		  } 
		  else { 
			  return "redirect:/msg/memPwdSendNo"; 
		  }
			 
		}
		else {
			return "redirect:/msg/memIdPwdSearchNo";
		}
	}
	
	//임시비밀번호 메일로 발송하기
	public String mailSend(String toMail, String pwd) {
		try {
			String title = "임시비밀번호 입니다.";
			String content = "";
			
			//메세지를 변환시켜서 보관함(messageHelper)에 저장하여 준비한다.
			MimeMessage message  = mailSender.createMimeMessage();  //변환시켜주는 객체(변환기) : MimeMessage
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			//메일보관함에 회원이 보내온 메세지를 모두 저장시켜둔다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			//messageHelper.setText(content); //편집할거라면 미리 set 하지 않아도 된다.
			
			//메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
			content = "<br><h3>임시비밀번호</h3><br><hr>";
			content += "<br><h4>아래 비밀번호로 다시 로그인하여 비밀번호를 변경하세요.</h4><br>";
			content += "<strong><h3>" + pwd + "</h3></strong>";
			content += "<p><img src=\"cid:main.jpg\"></p><hr>";
			content += "<p>사이트주소 : <a href='http://49.142.157.251:9090/cjgreen'>javagreenJ사이트</a></p>";
			content += "<hr>";
			messageHelper.setText(content, true);
			
			// 본문의 기재된 그림파일의 경로를 따로 표시시켜준다.
			FileSystemResource file = new FileSystemResource("C:\\Users\\Hayoung\\Desktop\\JISU\\JavaGreen\\springframework\\works\\javagreenS\\src\\main\\webapp\\resources\\images\\main.jpg");
			messageHelper.addInline("main.jpg", file);
			
			//메일 전송하기
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return "1";
	}
	
}
