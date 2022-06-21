package com.spring.javagreenS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS.dao.AdminDAO;
import com.spring.javagreenS.vo.AdminTestVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public String getKeyValue(int random) {
		return adminDAO.getKeyValue(random);
	}

	@Override
	public void setAdminInput(AdminTestVO vo, String strPwd, int random) {
		adminDAO.setAdminInput(vo, strPwd, random);
	}

	@Override
	public AdminTestVO getIdxKey(String mid) {
		return adminDAO.getIdxKey(mid);
	}
 
}
