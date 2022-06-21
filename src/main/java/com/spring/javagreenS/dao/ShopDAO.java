package com.spring.javagreenS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.ShopVO;

public interface ShopDAO {

	public ArrayList<ShopVO> getProduct1();

	public ArrayList<ShopVO> getProduct2(@Param("product1") String product1);

	public ArrayList<ShopVO> getProduct3(@Param("product2") String product2);

	public void getProductInput(@Param("vo") ShopVO vo);

	public ArrayList<ShopVO> getProductList(@Param("product") String product);
	
	//대분류만 조회
	public ArrayList<ShopVO> searchProduct1List(@Param("vo") ShopVO vo);
	
	//대.중분류 조회
	public ArrayList<ShopVO> searchProduct2List(@Param("vo") ShopVO vo);

	public ArrayList<ShopVO> searchProduct3List(@Param("vo") ShopVO vo);

	public ArrayList<ShopVO> getProList();
	
}
