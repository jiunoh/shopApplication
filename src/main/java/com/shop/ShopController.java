package com.shop;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ShopController {
	@RequestMapping("/")
	@ResponseBody
	public String home(){
		return "helloHome";
	}
	
	@RequestMapping("/viewjsp")
	public String viewTest(Model model) {
		model.addAttribute("name", "hello test");
		return "viewTest";
	}
}
