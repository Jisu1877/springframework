package com.spring.javagreenS;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS.common.SecurityUtil;
import com.spring.javagreenS.pagination.PageVO;
import com.spring.javagreenS.pagination.PagingProcess;
import com.spring.javagreenS.service.PdsService;
import com.spring.javagreenS.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@RequestMapping(value = "/pdsList", method = RequestMethod.GET)
	public String pdsListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			Model model) {
		
		PageVO pageVo = pagingProcess.pageProcess2(pag, pageSize, "pds", part, "");
		
		ArrayList<PdsVO> vos = pdsService.getPdsList(pageVo.getStartIndexNo(), pageVo.getPageSize(), part);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		return "pds/pdsList";
	}
	
	@RequestMapping(value = "/pdsInput", method = RequestMethod.GET)
	public String pdsInputGet() {
		
		return "pds/pdsInput";
	}
	
	@RequestMapping(value = "/pdsInput", method = RequestMethod.POST)
	public String pdsInputPost(MultipartHttpServletRequest file, PdsVO vo) {
		String pwd = vo.getPwd();
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		vo.setPwd(pwd);
		
		pdsService.setPdsInput(file, vo);
		
		return "redirect:/msg/pdsInputOk";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pdsDownNum", method = RequestMethod.POST)
	public String pdsDownNumPost(int idx) {
		pdsService.setPdsDownNum(idx);
		return "";
	}
	
	
	@RequestMapping(value = "/pdsContent", method = RequestMethod.GET)
	public String pdsContentGet(int idx, Model model) {
		PdsVO vo = pdsService.getPdsContent(idx);
		
		model.addAttribute("vo", vo);
		return "pds/pdsContent";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pdsPwdCheck", method = RequestMethod.POST)
	public String pdsPwdCheckPost(int idx, String pwd) {
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		PdsVO vo = pdsService.getPdsContent(idx);
		
		if(!vo.getPwd().equals(pwd)) {
			return "0";
		}
		
		pdsService.setPdsDelete(vo);
		
		return "1";
	}
	
	@RequestMapping(value = "/pdsTotalDown", method = RequestMethod.GET)
	public String pdsTotalDownGet(HttpServletRequest request, PdsVO vo) throws IOException {
		pdsService.setPdsDownNum(vo.getIdx()); //압축전에 다운로드 수를 증가처리.
		
		//여러개의 파일이 존재한다는 가정하에 모든 파일을 '제목.zip'로 압축한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		String[] fNames = vo.getFName().split("/");
		String[] fSNames = vo.getFSName().split("/");
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		String zipPath = realPath + "work/";  //파일이 겹쳐서 덮어씌워지는 것을 방지하기 위해 zip파일 저장은 다른 폴더를 사용한다.
		String zipName = vo.getTitle() + ".zip";
		
		ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(zipPath + zipName));
		
		byte[] buffer = new byte[2048];
		
		for(int i=0; i<fSNames.length; i++) {
			//File file = new File(realPath + fSNames[i]);
			fis = new FileInputStream(realPath + fSNames[i]);
			fos = new FileOutputStream(realPath + "work/" + fNames[i]);
			
			File moveAndRename = new File(zipPath + fNames[i]);
			
			//file.renameTo(moveAndRename);   //파일이 pds폴더에서 pds/work 폴더로 이름이 바뀌면서 이동됨.
			
			//앞의 renameTo 메소드는 파일을 이동처리하기에, 다시 아래에서 복사처리로 변경했다.
			int data;
			while((data = fis.read(buffer, 0, buffer.length))!= -1) {
				fos.write(buffer, 0, data); //내용물 채워넣기
			}
			fos.close();
			fis.close();
			
			fis = new FileInputStream(moveAndRename); //work폴더에 있는 파일 객체를 생성
			zout.putNextEntry(new ZipEntry(fNames[i]));  //zout에 put 하는데 ZipEntry 객체로 fNames[i]라는 파일명의 이름으로 껍데기 생성
			
			while((data = fis.read(buffer, 0, buffer.length))!= -1) {
				zout.write(buffer, 0, data); //내용물 채워넣기
			}
			
			zout.closeEntry();
			fis.close();
		}
		zout.close();
		
		return "redirect:/pds/pdsDownAction?file="+java.net.URLEncoder.encode(zipName, "UTF-8");
	}
	
	@RequestMapping(value = "/pdsDownAction", method = RequestMethod.GET)
	public void pdsDownActionGet(String file, HttpServletRequest request, HttpServletResponse response) throws IOException {
		//String file = request.getParameter("file");
		String downPathFile = request.getSession().getServletContext().getRealPath("/resources/data/pds/work/") + file;
		
		File downFile = new File(downPathFile);
		
		//if(request.getHeader("user-agent").indexOf("MSIE") == -1) { //인터넷 익스플로어가 아니라면..
			String downFileName = new String(file.getBytes("UTF-8"), "8859_1"); //윈도우 코드로 변환.
		//}
		//else {
			//new String(file.getBytes("EUC-KR"), "8859_1");	//인터넷 익스플로어라면..
		//}
			
		response.setHeader("Content-Disposition", "attachment;filename="+downFileName); //header파일에 inline형식으로 정보 삽입
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream(); //웹형식의 껍데기 만들기
		
		byte[] buffer = new byte[2048];
		int data = 0;
		
		while((data = fis.read(buffer, 0, buffer.length))!= -1) {
			sos.write(buffer, 0, data); //껍데기에 내용물 채워넣기
		}
		sos.flush();
		sos.close();
		fis.close();
		
		new File(downPathFile).delete();
	}
}
