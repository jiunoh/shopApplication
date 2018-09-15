package com.shop;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ShopController {
	@Autowired
	ShopDAO shopRepository;
	
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	
	@RequestMapping("/addition")
	public String addition() {
		return "addition";
	}
	
	@RequestMapping(value="/getCoffee", method=RequestMethod.GET)
	public ResponseEntity<Object> getCoffee() {
		Coffee coffee = new Coffee();
		coffee.setCid("1");
		coffee.setCname("coffee1");
		return new ResponseEntity<Object>(coffee, HttpStatus.OK);
	}
	
	@PostMapping(value="/addShop")
	public ResponseEntity<String> postCoffee(@RequestBody ShopVO shop) {
		System.out.println("shop name:"+shop.getName());
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy:MM:dd-hh:mm");
		String regDate = format.format(calendar.getTime());
		shop.setRegDate(regDate);
		shop.setModDate(regDate);
		shopRepository.save(shop);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
}
