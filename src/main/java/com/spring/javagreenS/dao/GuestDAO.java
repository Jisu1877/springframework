package com.spring.javagreenS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.GuestVO;

public interface GuestDAO {

	//방명록 목록 가져오기
	public ArrayList<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	//방명록 등록
	public void setGuestInput(@Param("vo") GuestVO vo);
	
	//글 개수 가져오기
	public int totRecCnt();


}
