package com.spring.javagreenS.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.AdminTestVO;

public interface AdminDAO {
	
	//keyValue 값 가져오기
	public String getKeyValue(@Param("random") int random);
	
	//관리자 등록
	public void setAdminInput(@Param("vo") AdminTestVO vo, @Param("strPwd") String strPwd, @Param("random") int random);
	
	//idxKey 가져오기
	public AdminTestVO getIdxKey(@Param("mid") String mid);
	
}
