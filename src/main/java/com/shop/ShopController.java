package com.shop;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShopController {
	@Autowired
	ShopDAO shopDAO;
	
	@Autowired
	MenuDAO menuDAO;
	
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	
	@RequestMapping("/addition")
	public String addition() {
		return "addition";
	}
	
	@GetMapping(value="/showList")
	public ResponseEntity<Object> getShopList() {
//		List<Shop> shopList = shopRepository.findAll();
//		System.out.print(shopList.get(0).toString());
		return new ResponseEntity<Object>("OK", HttpStatus.OK);
	}
	
	@PostMapping(value="/addShop")
	public ResponseEntity<String> addShop(@RequestBody Map<String, Object> shopInfo) {
		Shop shop = new Shop();
		Menu menu = new Menu();
		
		shop.setName(shopInfo.get("shopName").toString());		
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd-hh:mm");
		String regDate = format.format(calendar.getTime());
		shop.setRegDate(regDate);
		shop.setModDate(regDate);
		shop.setIsDeleted("n");
		shopDAO.registShop(shop);
		
		String coffees[] = shopInfo.get("menu").toString().split("/");
		for (int i=0; i<coffees.length; i++) {
			menu.setShopName(shop.getName());
			menu.setCoffeeName(coffees[i].trim());
			menuDAO.registMenu(menu);
		}
		
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
}
