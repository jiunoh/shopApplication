package com.shop;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.ShopService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@GetMapping(value="/list")
	public String list(){
		return "list";
	}
	
	@GetMapping(value="list/getShopList")
	public @ResponseBody ArrayList<Shop> getShopList() {
		List<Shop> shopList = shopService.getShopList();
		return (ArrayList<Shop>) shopList;
	}
	
	@PostMapping(value="/addShop")
	public ResponseEntity<String> addShop(@RequestBody Map<String, Object> shopInfo) {
		shopService.addShop(shopInfo);
        return new ResponseEntity<>("Success", HttpStatus.OK);
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
	
	@CrossOrigin(origins = { "*" })
	@RequestMapping(value="/demoCORS")
	public List<Shop> doCORS(String coffee) {
		return shopService.getShopListByCoffee(coffee);
	}
	
}
