package com.spring.javagreenS.service;

import java.util.ArrayList;

import com.spring.javagreenS.vo.GuestVO;

public interface GuestService {
	
	//방명록 목록가져오기
	public ArrayList<GuestVO> getGuestList(int startIndexNo, int pageSize);
	
	//방명록 등록
	public void setGuestInput(GuestVO vo);
	
	//글 개수 가져오기
	public int totRecCnt();
	
}
