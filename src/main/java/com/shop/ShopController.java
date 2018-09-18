package com.shop;

import java.util.List;
import java.util.Map;

import com.shop.ShopService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@RequestMapping("/")
	public String index() {
		return "home";
	}
		
	@RequestMapping("/addition")
	public String addition() {
		return "addition";
	}
	
	@RequestMapping(value="/list")
	public String getShopList(Model model) {
		List<Shop> shopList = shopService.getShopList();
		model.addAttribute("shopList", shopList);
		return "list";
	}
	
	@RequestMapping(value="/addShop")
	public String addShop(@RequestBody Map<String, Object> shopInfo) {
		shopService.addShop(shopInfo);
		return "redirect:/list";
	}
	
	@RequestMapping(value="deleteShop/{id}")
	public String deleteShop(@PathVariable int id) {
		shopService.deleteShop(id);
		return "redirect:/list";
	}
	
	@RequestMapping(value="/modification/{id}")
	public String modification(Model model, @PathVariable int id) {
		Shop shop = shopService.getShop(id);
		model.addAttribute("shop", shop);
		return "modification";
	}
	
	@RequestMapping(value="/updateShop/{id}")
	public String updateShop(@RequestBody Map<String, Object> shopInfo, @PathVariable int id) {
		shopService.updateShop(shopInfo, id);
		return "redirect:/list";
	}
	
	@RequestMapping(value="/details/{id}")
	public String getDetails(Model model, @PathVariable int id) {
		Shop shop = shopService.getShop(id);
		model.addAttribute("shop", shop);
		return "details";
	}
	
}
