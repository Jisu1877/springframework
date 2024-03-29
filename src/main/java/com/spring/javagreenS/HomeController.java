package com.spring.javagreenS;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	@RequestMapping(value = {"/","/h","/main"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "main/main";
	}
	
	//ckeditor에서 글을 올릴때 이미지와 함께 올린다면 이곳에서 서버 파일시스템에 그림파일을 저장할 수 있도록 처리한다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, 
			MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		//ckeditor에서 올린(전송한) 파일을, 서버 파일시스템에 실제로 파일을 저장시킨다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		//서버 파일시스템에 저장된 파일을 화면에 보여주기위한 작업
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		
		//JSON 형식으로 값 보내기
		/* "atom":"12.jpg","uploaded":"1" originalFilename,uploaded,url은 예약어라서 반드시 이걸로 적어야한다. 1은 true를 표현.*/
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		out.close();
		outStr.close();
	}
	
	
	//error처리를 위한 페이지 불러오기
	@RequestMapping(value = "/error/error500", method = RequestMethod.POST)
	public String error500Post() {
		return "/error/error500";
	}
	
}
