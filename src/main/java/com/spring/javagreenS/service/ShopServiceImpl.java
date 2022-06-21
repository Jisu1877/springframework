package com.spring.javagreenS.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS.dao.ShopDAO;
import com.spring.javagreenS.vo.ShopVO;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	ShopDAO shopDAO;

	@Override
	public ArrayList<ShopVO> getProduct1() {
		return shopDAO.getProduct1();
	}

	@Override
	public ArrayList<ShopVO> getProduct2(String product1) {
		return shopDAO.getProduct2(product1);
	}

	@Override
	public ArrayList<ShopVO> getProduct3(String product2) {
		return shopDAO.getProduct3(product2);
	}

	@Override
	public void getProductInput(ShopVO vo) {
		shopDAO.getProductInput(vo);
	}

	@Override
	public ArrayList<ShopVO> getProductList(String product) {
		return shopDAO.getProductList(product);
	}

	@Override
	public ArrayList<ShopVO> searchCheck(ShopVO vo) {
		String pro1 = vo.getProduct1();
		String pro2 = vo.getProduct2();
		String pro3 = vo.getProduct3();
		
		//전체검색
		if(pro1.equals("") && pro2.equals("") && pro3.equals("")) {
			return shopDAO.getProductList("");
		}
		//대분류만 검색
		else if(!pro1.equals("") && pro2.equals("") && pro3.equals("")) {
			return shopDAO.searchProduct1List(vo);
		}
		//대분류/중분류만 검색
		else if(!pro1.equals("") && !pro2.equals("") &&pro3.equals("")) {
			return shopDAO.searchProduct2List(vo);
		}
		//대.중.소 검색
		else {
			return shopDAO.searchProduct3List(vo);
		}
	}
}
