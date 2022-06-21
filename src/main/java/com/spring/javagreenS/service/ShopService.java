package com.spring.javagreenS.service;

import java.util.ArrayList;

import com.spring.javagreenS.vo.ShopVO;

public interface ShopService {
	
	//대분류 가져오기
	public ArrayList<ShopVO> getProduct1();
	
	//중분류 가져오기
	public ArrayList<ShopVO> getProduct2(String product1);
	
	//소분류 가져오기
	public ArrayList<ShopVO> getProduct3(String product2);
	
	//상품등록
	public void getProductInput(ShopVO vo);
	
	//상품리스트
	public ArrayList<ShopVO> getProductList(String product);
	
	//상품조회ShopVO
	public ArrayList<ShopVO> searchCheck(ShopVO vo);

}
