package com.spring.javagreenS.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.common.ProjectSupport;
import com.spring.javagreenS.dao.MemberDAO;
import com.spring.javagreenS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO getMemIdCheck(String mid) {
		return memberDAO.getMemIdCheck(mid);
	}

	@Override
	public MemberVO getNickNameCheck(String nickName) {
		return memberDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setMemInputOk(MultipartFile fName, MemberVO vo) {
		int res = 0;
		//사진작업 처리후 DB저장
		try {
			String oFileName = fName.getOriginalFilename();
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpg");
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				ProjectSupport ps = new ProjectSupport();
				ps.writeFile(fName, saveFileName, "member");
				vo.setPhoto(saveFileName);
			}
			
			memberDAO.setMemInputOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void setMemLoginUpdate(MemberVO vo) {
		//오늘 날짜 편집
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		String strToday = sdf.format(today);
		
		//DB에 저장된 최종 방문일 편집
		String lastDate = vo.getLastDate().substring(0,10);
		
		//최종방문일과 오늘 날짜가 다르다면 오늘방문카운트를 1으로 세팅
		//방문포인트를 1일 5회까지만 10점씩 증가처리
		int todayCnt = vo.getTodayCnt();
		int newPoint = 0;
		
		if(strToday.equals(lastDate)) { //오늘날짜와 최종방문일이 같을경우....
			if(todayCnt >= 5) {
				newPoint = 0;
			}
			else {
				newPoint = 10;
			}
			todayCnt++;
		}
		else {  //오늘 최초로그인 시 세팅		//오늘날짜와 최종방문일이 다를경우...(1일 1회만 통과됨)
			todayCnt = 1;				
			newPoint = 10;
		}
		
		memberDAO.setMemLoginUpdate(vo.getMid(), todayCnt, newPoint);
	}

	@Override
	public int setMemUpdateOk(MultipartFile fName, MemberVO vo) {
		int res = 0;
		//사진작업 처리후 DB저장
		try {
			String oFileName = fName.getOriginalFilename();
			if(!oFileName.equals("")) {
				if(!vo.getPhoto().equals("noimage.jpg")) {
					//기존에 존재하는 파일 삭제하기
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
					String uploadPath = request.getSession().getServletContext().getRealPath("/resources/member/");
					File file = new File(uploadPath + vo.getPhoto());
					file.delete();
				}
				
				//새로 업로드
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				ProjectSupport ps = new ProjectSupport();
				ps.writeFile(fName, saveFileName, "member");
				vo.setPhoto(saveFileName);
			}
			memberDAO.setMemUpdateOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void setMemDeleteOk(String mid) {
		memberDAO.setMemDeleteOk(mid);
	}

	@Override
	public void setPwdChange(String mid, String pwd) {
		memberDAO.setPwdChange(mid, pwd);
	}

	@Override
	public MemberVO getMemIdEmailCheck(String mid, String toMail) {
		return memberDAO.getMemIdEmailCheck(mid, toMail);
	}

	@Override
	public List<MemberVO> getMemList(int start, int end) {
		return memberDAO.getMemList(start,end);
	}

	@Override
	public int totRecCnt() {
		return memberDAO.totRecCnt();
	}

}
