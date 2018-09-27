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
	
	@Autowired
	CoffeeDAO coffeeRepository;
	
	@Autowired
	TotalDAO totalRepository;

	//Ȩ���� �̵�
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	
	//�� ��� �������� �̵�
	@RequestMapping("/addition")
	public String addition() {
		return "addition";
	}
	
    //�� ����� �����Ѵ�.
	@PostMapping(value="/addition/addShop")
	public ResponseEntity<String> addShop(@RequestBody Map<String, Object> shopInfo) {
		shopService.addShop(shopInfo);
        return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//���� �����Ѵ�.
	@PutMapping(value="/delete/shop/{id}")
	public ResponseEntity<String> deleteShop(@PathVariable int id) {
		shopService.deleteShop(id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//����Ʈ �������� �̵�
	@GetMapping(value="/list")
	public String list(){
		return "list";
	}
	
	//����Ʈ ȭ�鿡 ����� ������ ��ü�� ����Ʈ�� ������.
    @GetMapping(value="/list/getShopList")
    public @ResponseBody ArrayList<Shop> getShopList() {
        List<Shop> shopList = shopService.getShopList();
        return (ArrayList<Shop>) shopList;
    }        
    
    //����Ʈ ȭ�鿡 ���� �� Ŀ�ǿ� ������ �־��� ��� �޴��� ������Ʈ�Ѵ�.
    @PutMapping(value = "/list/updateMenu/{id}")
    public ResponseEntity<String> updateMenu(@PathVariable int id, @RequestParam(value="menu") String menu) {
    	shopService.updateMenu(id, menu);
		return new ResponseEntity<>("Success", HttpStatus.OK);
    }
    
	//���� �������� �̵��Ѵ�.
	@RequestMapping(value="/modification/{id}")
	public String modification(@PathVariable int id) {
		return "modification";
	}
	
	//�� ������ �����Ѵ�.
	@PutMapping(value="/modification/updateShop/{id}")
	public ResponseEntity<String> updateShop(@RequestBody Map<String, Object> shopInfo, @PathVariable int id) {
		shopService.updateShop(shopInfo, id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	//������ �������� �̵��Ѵ�.
	@RequestMapping(value="/details/{id}")
	public String details(@PathVariable int id) {
		return "details";
	}
	
	//�����Ͽ� ����� �� ��ü�� �����Ѵ�.
	@GetMapping(value="/details/getDetails/{id}")
	public @ResponseBody Shop getDetails(@PathVariable int id) {
		Shop shop = shopService.getShop(id);
		return shop;
	}
	
	//�Ǹ� �������� �̵��Ѵ�.
	@RequestMapping (value="/sale/{id}")
	public String sale(@PathVariable int id) {
		return "sale";
	}
	
	//���Ǹŷ� ���Ǹž��� ������Ʈ�Ѵ�.
	@PutMapping (value = "/sale/updateSaleData/{id}")
	public ResponseEntity<String> updateSaleData(@RequestBody Map<String, Object> saleInfo, @PathVariable int id) {
		shopService.updateSaleData(saleInfo, id);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	
	// CORS�� ���. ���ʿ��� �������� �����͸� �� ��
	// Ŀ�Ǹ� �Ĵ� �� ����Ʈ�� ������ (�Ķ����: Ŀ�� id)
	@CrossOrigin("*")
	@GetMapping(value="/getShopListByCoffee/{id}")
	public @ResponseBody ArrayList<Shop> getShopListByCoffee(@PathVariable String id) {
		List<Shop> shopList = shopService.getShopListByCoffee(","+id+",");
		return (ArrayList<Shop>) shopList;
	}

	
	/////////////////////���ʿ��� ������ ������� ��////////////////////////////////	
	
	/*
	 * �޴�(Ŀ�� ���̵�� �̷���� ��Ʈ��)�� �޾� �׿� �ش��ϴ� Ŀ�� ��ü���� ����Ʈ�� �����ϴ� �޼ҵ�
	 * ���ó: modification, list, details, sale
	 * */
	@GetMapping(value="/getCoffees")
	public @ResponseBody ArrayList<Coffee> getCoffees(@RequestParam(value="menu") String menuString) {
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
	 * Ŀ�� ���̺� ��ü�� �ҷ����� �޼ҵ�
	 * ���ó: addition, modification
	 * */
	@GetMapping (value = "/getCoffeeList")
	public @ResponseBody List<Coffee> getCoffeeList() {
		return coffeeRepository.findAll();
	}	
	
	/* 
	 * Ŀ�� ��ü �ϳ� �޾ƿ�
	 * */
	@CrossOrigin("*")
	@GetMapping (value = "/getOneCoffee/{id}")
	public @ResponseBody Coffee getOneCoffee(@PathVariable int id) {
		Coffee coffee = coffeeRepository.findById(id);
		return coffee;
	}
	
	/*
	 * Ŀ�� ���̵�, ������ �޾Ƽ� ���� ���Ǹž� ���Ǹŷ� ������Ʈ��
	 * */
	@CrossOrigin("*")
	@PostMapping (value = "/postSaleData/{id}")
	public ResponseEntity<String> postSaleData(@PathVariable int id, @RequestParam(value="quantity") int quantity) {		
		Coffee coffee = coffeeRepository.findById(id);
		int inventory = coffee.getInventory();
		int price = coffee.getPrice();
		
		coffee.setInventory(inventory-quantity);
		coffeeRepository.save(coffee);
		
		TotalCoffee totalCoffee = totalRepository.findById(id);
		int currentSale = totalCoffee.getTotal_sale();
		int currentIncome = totalCoffee.getToal_income();
		totalCoffee.setTotal_sale(currentSale+quantity);
		totalCoffee.setToal_income(currentIncome+(price*quantity));
		totalRepository.save(totalCoffee);
		return new ResponseEntity<>("Success", HttpStatus.OK);
	}
	
	/*
	 * �ش��ϴ� total table�� ������ ������
	 * */
	@GetMapping(value= "/getTotalInfo/{id}")
	public @ResponseBody TotalCoffee getTotalInfo(@PathVariable int id) {
		return totalRepository.findById(id);
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
