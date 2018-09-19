package com.shop;

import java.util.ArrayList;
import java.util.HashMap;
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

@CrossOrigin(origins = "*")
@Controller
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	CoffeeDAO coffeeRepository;
	
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
	
	//����Ʈ ȭ�鿡 ���
    @GetMapping(value="/list/getShopList")
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
	
	@RequestMapping(value="/modification/updateShop/{id}")
	public ResponseEntity<String> updateShop(@RequestBody Map<String, Object> shopInfo, @PathVariable int id) {
		shopService.updateShop(shopInfo, id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	@RequestMapping(value="/details/{id}")
	public String details(Model model, @PathVariable int id) {
		return "details";
	}
	
	@GetMapping(value="/details/getDetails/{id}")
	public @ResponseBody Shop getDetails(@PathVariable int id) {
		Shop shop = shopService.getShop(id);
		return shop;
	}
	

	/////////////////////////////////////////////////////
	@GetMapping(value="/test/{coffee}")
	public @ResponseBody ArrayList<Shop> getShopList(@PathVariable String coffee) {
		List<Shop> shopList = shopService.getShopListByCoffee(","+coffee+",");
		return (ArrayList<Shop>) shopList;
	}

	
	@CrossOrigin("*")
	@RequestMapping(value="/demoCORS")
	public @ResponseBody String doCORS() {
		return "hello";
	}
	
	/* 
	 * Ŀ�Ǹ� �Ĵ� �� ����Ʈ�� ������ (�Ķ����: Ŀ�� id)
	 * */
	@CrossOrigin("*")
	@GetMapping(value="/getShopListByCoffee/{id}")
	public @ResponseBody ArrayList<Shop> getShopListByCoffee(@PathVariable String id) {
		List<Shop> shopList = shopService.getShopListByCoffee("/"+id+"/");
		return (ArrayList<Shop>) shopList;
	}
	
	/*
	 * �޴� ��Ʈ���� �޾ƿͼ� Ŀ�� ���� ���� �Ǵ� ������ ���������� �˻��ϰ� Ŀ�� ��ü ����Ʈ�� �ٽ� �����ִ� �޼ҵ�
	 * */
//	@GetMapping(value="/getMenuFromCoffee") 
//	public @ResponseBody ArrayList<Coffee> getMenuFromCoffee(String menuString) {
//		Map<String, String> coffee = new HashMap<>();
//		String menu[] = menuString.split(",");
//		for (int i=0; i<menu.length; i++) {
//			coffee.put(key, value)
//			Coffee coffee = coffeeRepository.findById(Integer.parseInt(menu[i]));
//			if (coffee != null)
//				coffeeList.add(coffee);
//		}
//		return coffeeList;
//	}
	
}
