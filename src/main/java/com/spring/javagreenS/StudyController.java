package com.spring.javagreenS;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.common.ARIAUtil;
import com.spring.javagreenS.service.StudyService;
import com.spring.javagreenS.vo.MailVO;
import com.spring.javagreenS.vo.OperatorVO;
import com.spring.javagreenS.vo.PersonVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	BCryptPasswordEncoder PasswordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	
	@RequestMapping(value = "/password/passCheck1", method = RequestMethod.GET)
	public String passCheck1Get() {
		return "study/password/passCheck1";
	}
	
	@RequestMapping(value = "/password/passCheck1", method = RequestMethod.POST)
	public String passCheck1Post(long pwd, Model model) { //pwd가 문자라면 아스키코드화 해야한다.
		//암호화를 위한 키 : 0x1234ABCD(16진수)
		long encPwd, decPwd;
		long key = 0x1234ABCD;
		
		//암호화 : DB에 저장시켜준다.
		encPwd = pwd ^ key; //배타적 연산(^)
		
		//복호화
		decPwd = encPwd ^ key;
		
		model.addAttribute("pwd", pwd);
		model.addAttribute("encPwd", encPwd);
		model.addAttribute("decPwd", decPwd);
		return "study/password/passCheck1";
	}
	
	@RequestMapping(value = "/password/passCheck2", method = RequestMethod.POST)
	public String passCheck2Post(String pwd, Model model) { //pwd가 문자라면 아스키코드화 해야한다.
		//입력문자가 영문 소문자일 경우는 대문자로 변경처리(ㅇ자리수때문에)
		pwd = pwd.toUpperCase();
		
		//입력된 비밀번호를 아스키코드로 변환하여 누적처리
		long longPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			longPwd = pwd.charAt(i);
			strPwd += longPwd;
		}
		//암호화를 위한 키 : 0x1234ABCD(16진수)
		long encPwd, decPwd;
		long key = 0x1234ABCD;
		
		// 문자로 결합된 숫자를, 연산하기위해 다시 숫자로 변환한다.
		longPwd = Long.parseLong(strPwd);
		
		//암호화 : DB에 저장시켜준다.
		encPwd = longPwd ^ key; //배타적 연산(^)
		
		//DB에 저장을 할때 문장으로 저장하기 위해 바꿔준다.
		strPwd = String.valueOf(encPwd); //->이걸 DB에 저장
		model.addAttribute("encPwd", strPwd);
		
		
		//복호화 작업처리
		//DB에 저장된 값을 다시 long타입으로 바꾸기
		longPwd = Long.parseLong(strPwd);
		
		//복호화
		decPwd = longPwd ^ key;
		
		//문자로 변환
		strPwd = String.valueOf(decPwd);
		
		//문자로 변환된 복호화된 문장을 아스키코드 값으로 변환하기 위해 2자리씩 자르기
		String result = "";
		char ch;
		for(int i=0; i<strPwd.length(); i+=2) {
			ch = (char) Integer.parseInt(strPwd.substring(i,i+2));
			result += ch;
		}
		
		model.addAttribute("pwd", pwd);
		model.addAttribute("decPwd", result);
		
		return "study/password/passCheck1";
	}
	
	@RequestMapping(value = "/password2/operatorMenu", method = RequestMethod.GET)
	public String operatorMenuGet() {
		return "study/password2/operatorMenu";
	}
	
	@RequestMapping(value = "/password2/operatorInputOk", method = RequestMethod.POST)
	public String operatorInputOkPost(OperatorVO vo) {
		// 아이디 중복체크
		OperatorVO vo2 = studyService.getOperator(vo.getOid());
		if(vo2 != null) {
			return "redirect:/msg/operatorCheckNo";
		}
		
		//아이디가 중복되지 않았으면 비밀번호를 암호화하여 저장시켜준다. service객체에서 처리한다.
		studyService.setOperatorInputOk(vo);
		
		return "redirect:/msg/operatorInputOk";
	}
	
	@RequestMapping(value = "/password2/operatorList", method = RequestMethod.GET)
	public String operatorListGet(Model model) {
		ArrayList<OperatorVO> vos = studyService.getOperatorList();
		model.addAttribute("vos",vos);
		return "study/password2/operatorList";
	}
	
	@ResponseBody //ajax처리를 위해선 필수로 작성해야하는 어노테이션.(없으면 ajax에서 값을 넘기고 받을 수가 없다)
	@RequestMapping(value = "/password2/operatorDelete", method = RequestMethod.POST)
	public String operatorDeletePost(String oid) {
		studyService.setOperatorDelete(oid);
		return "1";
	}
	
	@ResponseBody 
	@RequestMapping(value = "/password2/operatorSearch", method = RequestMethod.POST)
	public String operatorSearchPost(OperatorVO vo) {
		String res = studyService.setOperatorSearch(vo);
		return res;
	}
	
	@RequestMapping(value = "/ajax/ajaxMenu", method = RequestMethod.GET)
	public String ajaxMenuGet() {
		return "study/ajax/ajaxMenu";
	}
	
	@RequestMapping(value = "/ajax/ajaxTest1", method = RequestMethod.GET)
	public String ajaxTest1Get() {
		return "study/ajax/ajaxTest1";
	}
	
	
	//배열을 이용한 값의 전달
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1", method = RequestMethod.POST)
	public String[] ajaxTest1Post(String dodo) {
//		String[] strArr = new String[100];
//		strArr = studyService.getCityStringArr(dodo);
		return studyService.getCityStringArr(dodo);
	}
	
	@RequestMapping(value = "/ajax/ajaxTest2", method = RequestMethod.GET)
	public String ajaxTest2Get(String dodo) {
		return "study/ajax/ajaxTest2";
	}
	
	//ArrayList의 String배열을 이용한 값의 전달
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest2Post(String dodo) {
		return studyService.getCityArrayListStr(dodo);
	}
	
	@RequestMapping(value = "/ajax/ajaxTest3", method = RequestMethod.GET)
	public String ajaxTest3Get(String dodo) {
		return "study/ajax/ajaxTest3";
	}
	
	//HashMap을 이용한 값의 전달(배열, ArrayList에 담아온 값을 다시 map에 담아서 넘길 수 있다.) 
	//이유 : JSON 데이터 가져오려면..
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest3Post(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		vos = studyService.getCityArrayListStr(dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		return map;
	}
	
	@RequestMapping(value = "/ajax/ajaxTest4", method = RequestMethod.GET)
	public String ajaxTest4Get() {
		return "study/ajax/ajaxTest4";
	}
	
	//vo를 이용한 값의 전달
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest4", method = RequestMethod.POST)
	public OperatorVO ajaxTest4Post(String oid) {
		return studyService.getOperator(oid);
	}
	
	//vos를 이용한 값의 전달(ArrayList)
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest5", method = RequestMethod.POST)
	public ArrayList<OperatorVO> ajaxTest5Post(String oid) {
		return studyService.getOperatorSearch(oid);
	}
	
	//aria 암호화 방식연습
	@RequestMapping(value = "/password3/aria", method = RequestMethod.GET)
	public String ariaGet() {
		return "study/password3/aria";
	}
	
	@ResponseBody
	@RequestMapping(value = "/password3/aria", method = RequestMethod.POST)
	public String ariaPost(String pwd) {
		String encPwd = "";
		String decPwd = "";
		
		try {
			encPwd = ARIAUtil.ariaEncrypt(pwd);
			decPwd = ARIAUtil.ariaDecrypt(encPwd);
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		pwd = "Encoding : " + encPwd + "/" + "Decoding :" + decPwd;
		
		return pwd;
	}
	
	
	//BCryptPasswordEncoder 암호화 방식연습
	@RequestMapping(value = "/password3/securityCheck", method = RequestMethod.GET)
	public String securityCheckGet() {
		return "study/password3/security";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/password3/securityCheck", method = RequestMethod.POST)
	public String securityCheckPost(String pwd) {
		String encPwd = PasswordEncoder.encode(pwd);
		
		pwd = "Encoding : " + encPwd + " / original :" + pwd;
		
		return pwd;
	}
	
	//메일폼 호출
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.GET)
	public String mailFormGet() {
		return "study/mail/mailForm";
	}
	
	//메일 전송
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailFormPost(MailVO vo) {
		try {
			String toMail = vo.getToMail();
			String title = vo.getTitle();
			String content = vo.getContent();
			
			//메세지를 변환시켜서 보관함(messageHelper)에 저장하여 준비한다.
			MimeMessage message  = mailSender.createMimeMessage();  //변환시켜주는 객체(변환기) : MimeMessage
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			//메일보관함에 회원이 보내온 메세지를 모두 저장시켜둔다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content); //편집할거라면 미리 set 하지 않아도 된다.
			
			//메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
			content = content.replace("\n", "<br>");
			content += "<br><hr><h3>지수가 보냅니다.</h3></hr><br>";
			content += "<p><img src=\"cid:main.jpg\"></p><hr>";
			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>javagreenJ사이트</a></p>";
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
		return "redirect:/msg/mailSendOk";
	}
	
	//UUID 입력폼
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	
	//UUID 처리하기
	@ResponseBody   //@controller 대신에 @RestController 를 작성하면 ajax 처리시 @ResponseBody 를 적어주지 않아도 된다.
	@RequestMapping(value = "/uuid/uuidProcess", method = RequestMethod.POST)
	public String uuidProcessPost() {
		UUID uid = UUID.randomUUID();
		return uid.toString();
	}
	
	//파일 업로드폼
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.GET)
	public String fileUploadGet() {
		return "study/fileUpload/fileUpload";
	}
	
	//파일 업로드 처리하기
	@RequestMapping(value = "/fileUpload/fileUpload", method = RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName) {
		int res = studyService.fileUpload(fName);
		
		if(res == 1) {
			return "redirect:/msg/fileUploadOk";
		}
		else {
			return "redirect:/msg/fileUploadNo";
		}
	}
	
	//트랜잭션 연습을 취한 person폼 불러오기
	@RequestMapping(value = "/personInput", method = RequestMethod.GET)
	public String personInputGet() {
		return "study/transaction/personInput";
	}
	
	@RequestMapping(value = "/personInput", method = RequestMethod.POST)
	public String personInputPost(PersonVO vo) {
		studyService.setPersonInput(vo);
		
		return "redirect:/msg/personInputOk";
	}
	
	@RequestMapping(value = "/personList", method = RequestMethod.GET)
	public String personListGet(Model model) {
		ArrayList<PersonVO> vos = studyService.getPersonList();
		model.addAttribute("vos", vos);
		
		return "study/transaction/personList";
	}
}
