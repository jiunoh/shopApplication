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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@CrossOrigin(origins = "*")
@Controller
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	//홈으로 이동
	@GetMapping("/")
	public String index() {
		return "home";
	}
	
	//샵 등록 페이지로 이동
	@GetMapping("/addition")
	public String addition() {
		return "addition";
	}
	
    //샵 등록을 수행한다.
	@PostMapping(value="/addition/addShop")
	public ResponseEntity<String> addShop(@RequestBody Map<String, Object> shopInfo) {
		shopService.addShop(shopInfo);
        return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//샵을 삭제한다.
	@PutMapping(value="/delete/shop/{id}")
	public ResponseEntity<String> deleteShop(@PathVariable int id) {
		shopService.deleteShop(id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
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
    
    //리스트 화면에 갔을 때 커피에 삭제가 있었을 경우 메뉴를 업데이트한다.
    @PutMapping(value = "/list/updateMenu/{id}")
    public ResponseEntity<String> updateMenu(@PathVariable int id, @RequestParam(value="menu") String menu) {
    	shopService.updateMenu(id, menu);
		return new ResponseEntity<>("Success", HttpStatus.OK);
    }
    
	//수정 페이지로 이동한다.
    @GetMapping(value="/modification/{id}")
	public String modification(@PathVariable int id) {
		return "modification";
	}
	
	//샵 수정을 수행한다.
	@PutMapping(value="/modification/updateShop/{id}")
	public ResponseEntity<String> updateShop(@RequestBody Map<String, Object> shopInfo, @PathVariable int id) {
		shopService.updateShop(shopInfo, id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//디테일 페이지로 이동한다.
	@GetMapping(value="/details/{id}")
	public String details(@PathVariable int id) {
		return "details";
	}
	
	//디테일에 사용할 샵 객체를 리턴한다.
	@GetMapping(value="/details/getDetails/{id}")
	public @ResponseBody Shop getDetails(@PathVariable int id) {
		Shop shop = shopService.getShop(id);
		return shop;
	}
	
	//판매 페이지로 이동한다.
	@GetMapping (value="/sale/{id}")
	public String sale(@PathVariable int id) {
		return "sale";
	}
	
	//총판매량 총판매액을 업데이트한다.
	@PutMapping (value = "/sale/updateSaleData/{id}")
	public ResponseEntity<String> updateSaleData(@RequestBody Map<String, Object> saleInfo, @PathVariable int id) {
		shopService.updateSaleData(saleInfo, id);
        return new ResponseEntity<>("Success", HttpStatus.OK);
    }	
	
	// CORS에 사용. 내쪽에서 저쪽으로 데이터를 줄 때
	// 커피를 파는 샵 리스트를 보내줌 (파라미터: 커피 id)
	@CrossOrigin("*")
	@GetMapping(value="/getShopListByCoffee/{id}")
	public @ResponseBody ArrayList<Shop> getShopListByCoffee(@PathVariable String id) {
		List<Shop> shopList = shopService.getShopListByCoffee(","+id+",");
		return (ArrayList<Shop>) shopList;
	}
}