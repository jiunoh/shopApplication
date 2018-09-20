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

	//홈으로 이동
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	
	//샵 등록 페이지로 이동
	@RequestMapping("/addition")
	public String addition() {
		return "addition";
	}
	
	//리스트 페이지로 이동
	@GetMapping(value="/list")
	public String list(){
		return "list";
	}
	
	//리스트 화면에 사용할 샵들의 객체를 리스트로 보낸다.
    @GetMapping(value="/list/getShopList")
    public @ResponseBody ArrayList<Shop> getShopList() {
        List<Shop> shopList = shopService.getShopList();
        return (ArrayList<Shop>) shopList;
    }        
    
    //샵 등록을 수행한다.
	@PostMapping(value="/addShop")
	public ResponseEntity<String> addShop(@RequestBody Map<String, Object> shopInfo) {
		shopService.addShop(shopInfo);
        return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//샵을 삭제한다.
	@RequestMapping(value="deleteShop/{id}")
	public String deleteShop(@PathVariable int id) {
		shopService.deleteShop(id);
		return "redirect:/list";
	}
	
	//수정 페이지로 이동한다.
	@RequestMapping(value="/modification/{id}")
	public String modification(@PathVariable int id) {
		return "modification";
	}
	
	//샵 수정을 수행한다.
	@RequestMapping(value="/modification/updateShop/{id}")
	public ResponseEntity<String> updateShop(@RequestBody Map<String, Object> shopInfo, @PathVariable int id) {
		shopService.updateShop(shopInfo, id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//디테일 페이지로 이동한다.
	@RequestMapping(value="/details/{id}")
	public String details(Model model, @PathVariable int id) {
		return "details";
	}
	
	//디테일에 사용할 샵 객체를 리턴한다.
	@GetMapping(value="/details/getDetails/{id}")
	public @ResponseBody Shop getDetails(@PathVariable int id) {
		Shop shop = shopService.getShop(id);
		return shop;
	}
	
	// CORS에 사용. 내쪽에서 저쪽으로 데이터를 줄 때
	// 커피를 파는 샵 리스트를 보내줌 (파라미터: 커피 id)
	@CrossOrigin("*")
	@GetMapping(value="/getShopListByCoffee/{id}")
	public @ResponseBody ArrayList<Shop> getShopListByCoffee(@PathVariable String id) {
		List<Shop> shopList = shopService.getShopListByCoffee(","+id+",");
		return (ArrayList<Shop>) shopList;
	}

	
	/////////////////////저쪽에서 나한테 보내줘야 함////////////////////////////////	
	
	/*
	 * 메뉴(커피 아이디로 이루어진 스트링)를 받아 그에 해당하는 커피 객체들의 리스트를 리턴하는 메소드
	 * 사용처: addition, modification, list, (details)
	 * */
	@GetMapping(value="/getCoffees/{menuString}")
	public @ResponseBody ArrayList<Coffee> getCoffees(@PathVariable String menuString) {
		String menu[] = menuString.split(",");
		ArrayList<Coffee> coffeeList = new ArrayList<Coffee>();
		for (int i=0; i<menu.length; i++) {
			Coffee coffee = coffeeRepository.findById(Integer.parseInt(menu[i]));
			if (coffee != null)
				coffeeList.add(coffee);
		}
		return coffeeList;
	}
	
	
	/*
	 * 커피 테이블 전체를 불러오는 메소드
	 * 사용처: addition, modification
	 * */
	@GetMapping (value = "/getCoffeeList")
	public @ResponseBody List<Coffee> getCoffeeList() {
		return coffeeRepository.findAll();
	}
	
	
	/*
	 * 메뉴 스트링을 받아와서 커피 정보 수정 또는 삭제가 없었는지를 검사하고 커피 객체 리스트를 다시 돌려주는 메소드
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
