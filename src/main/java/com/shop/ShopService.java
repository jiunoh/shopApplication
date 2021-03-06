package com.shop;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShopService {

	@Autowired
	ShopDAO shopRepository;
	
	public void addShop(Map<String, Object> shopInfo) {
		Shop shop = new Shop();
		shop.setName(shopInfo.get("shopName").toString());		
		String regDate = getCurrentDate();
		shop.setRegDate(regDate);
		shop.setModDate(regDate);
		shop.setMenu(shopInfo.get("menu").toString());
		shop.setTotalMoney(0);
		shop.setTotalSale(0);
		shop.setIsDeleted("n");
		shopRepository.save(shop);
	}
	
	public void updateShop(Map<String, Object> shopInfo, int id) {
		Shop shop = shopRepository.findById(id);
		shop.setName(shopInfo.get("shopName").toString());		
		String regDate = getCurrentDate();
		shop.setModDate(regDate);
		shop.setMenu(shopInfo.get("menu").toString());
		shopRepository.save(shop);
	}
	
	public void deleteShop(int id) {
		Shop shop = shopRepository.findById(id);
		shop.setIsDeleted("y");
		shop.setMenu(null);
		shop.setRegDate(null);
		shop.setModDate(null);
		shopRepository.save(shop);
	}
	
	public void updateSaleData(Map<String, Object> saleInfo, int id) {
		Shop shop = shopRepository.findById(id);
		int sale = Integer.parseInt(saleInfo.get("totalSale").toString());
		int money = Integer.parseInt(saleInfo.get("totalMoney").toString());
		int currentSale = shop.getTotalSale();
		int currentMoney = shop.getTotalMoney();
		shop.setTotalSale(currentSale + sale);
		shop.setTotalMoney(currentMoney + money);
		shopRepository.save(shop);
	}
	
	public void updateMenu(int id, String menu) {
		Shop shop = shopRepository.findById(id);
		shop.setMenu(menu);
		shopRepository.save(shop);
	}
	
	public Shop getShop(int id) {
		return shopRepository.findById(id);
	}
	
	public List<Shop> getShopList() {
		return shopRepository.findByIsDeleted("n");
	}
	
	public List<Shop> getShopListByCoffee(String coffee) {
		return shopRepository.findByMenuContaining(coffee);
	}
	
	private String getCurrentDate() {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd-hh:mm");
		String regDate = format.format(calendar.getTime());
		return regDate;
	}
}
