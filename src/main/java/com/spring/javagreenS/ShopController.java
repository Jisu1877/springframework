package com.spring.javagreenS;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS.service.ShopService;
import com.spring.javagreenS.vo.ShopVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@RequestMapping(value = "/input/productMenu", method = RequestMethod.GET)
	public String productMenuGet() {
		return "shop/input/productMenu";
	}
	
	@RequestMapping(value = "/input/productList", method = RequestMethod.GET)
	public String productListGet(Model model) {
		ArrayList<ShopVO> vos = shopService.getProductList("");
		model.addAttribute("vos", vos);
		
		ArrayList<ShopVO> producut1 = shopService.getProduct1();
		model.addAttribute("producut1", producut1);
		return "shop/input/productList";
	}
	
	@RequestMapping(value = "/input/productList", method = RequestMethod.POST)
	public String productListPost(ShopVO vo, Model model) {
		ArrayList<ShopVO> vos = shopService.searchCheck(vo);
		ArrayList<ShopVO> producut1 = shopService.getProduct1();
		model.addAttribute("producut1", producut1);
		model.addAttribute("vos", vos);
		model.addAttribute("select", vo);
		return "shop/input/productList";
	}
	
	//상품등록창 호출
	@RequestMapping(value = "/input/productInput", method = RequestMethod.GET)
	public String productInputGet(Model model) {
		ArrayList<ShopVO> vos = shopService.getProduct1();
		model.addAttribute("vos", vos);
		return "shop/input/productInput";
	}
	
	//상품등록처리
	@RequestMapping(value = "/input/productInput", method = RequestMethod.POST)
	public String productInputPost(ShopVO vo) {
		shopService.getProductInput(vo);
		
		return "redirect:/msg/productInputOk";
	}
	
	//중분류 가져오기
	@ResponseBody
	@RequestMapping(value = "/input/getProduct2", method = RequestMethod.POST)
	public ArrayList<ShopVO> getProduct2Post(String product1) {
		return shopService.getProduct2(product1);
	}
	
	//소분류 가져오기
	@ResponseBody
	@RequestMapping(value = "/input/getProduct3", method = RequestMethod.POST)
	public ArrayList<ShopVO> getProduct3Post(String product2) {
		return shopService.getProduct3(product2);
	}
	
	
	// 상품검색
	@RequestMapping(value = "/list/productSearch", method = RequestMethod.GET)
	public String productSearchGet(Model model, String product) {
		ArrayList<ShopVO> vos = shopService.getProductList(product);
		ArrayList<ShopVO> producut1 = shopService.getProduct1();
		model.addAttribute("vos", vos);
		model.addAttribute("shopSw", "search");
		model.addAttribute("producut1", producut1);
		return "shop/input/productList";
	}
	
}
