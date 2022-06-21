package com.spring.javagreenS.service;

import com.spring.javagreenS.vo.AdminTestVO;

public interface AdminService {
	
	//난수로 keyValue값 가져오기
	public String getKeyValue(int random);
	
	//관리자 등록
	public void setAdminInput(AdminTestVO vo, String strPwd, int random);
	
	//아이디로 idxKey값 가져오기
	public AdminTestVO getIdxKey(String mid);

}
