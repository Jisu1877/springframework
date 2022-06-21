package com.spring.javagreenS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.OperatorVO;

public interface StudyDAO {
	
	//아이디 중복체크
	public OperatorVO getOperator(@Param("oid") String oid);
	
	//key값 가져오기
	public String getOperatorHashKey(@Param("keyIdx") int keyIdx);
	
	//등록하기
	public void setOperatorInputOk(@Param("vo") OperatorVO vo);
	
	//목록조회
	public ArrayList<OperatorVO> getOperatorList();
	
	//운영자 삭제
	public void setOperatorDelete (@Param("oid") String oid);
	
	//일부검색
	public ArrayList<OperatorVO> getOperatorSearch(@Param("oid") String oid);
	
}
