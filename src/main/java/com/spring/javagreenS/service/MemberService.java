package com.spring.javagreenS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemIdCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemInputOk(MultipartFile fName, MemberVO vo);

	public void setMemLoginUpdate(MemberVO vo);

	public List<MemberVO> getMemList(int start, int end);

	public int setMemUpdateOk(MultipartFile fName, MemberVO vo);

	public void setMemDeleteOk(String mid);

	public void setPwdChange(String mid, String pwd);

	public MemberVO getMemIdEmailCheck(String mid, String toMail);

	public int totRecCnt();

}
