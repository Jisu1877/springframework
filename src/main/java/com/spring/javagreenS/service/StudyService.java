package com.spring.javagreenS.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS.vo.OperatorVO;
import com.spring.javagreenS.vo.PersonVO;

public interface StudyService {
	
	//아이디 중복체크
	public OperatorVO getOperator(String oid);
	
	//비밀번호 암호화 처리 후 등록
	public void setOperatorInputOk(OperatorVO vo);
	
	//운영자 목록 조회
	public ArrayList<OperatorVO> getOperatorList();
	
	//운영자 삭제
	public void setOperatorDelete(String oid);
	
	//운영자 인증
	public String setOperatorSearch(OperatorVO vo);
	
	
	//ajax 연습1
	public String[] getCityStringArr(String dodo);
	
	//ajax 연습2
	public ArrayList<String> getCityArrayListStr(String dodo);
	
	//ajax 연습3
	public ArrayList<OperatorVO> getOperatorSearch(String oid);
	
	//파일 업로드
	public int fileUpload(MultipartFile fName);

	public void setPersonInput(PersonVO vo);

	public ArrayList<PersonVO> getPersonList();

}
