package com.shop;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MenuDAO extends JpaRepository<Menu, String> {
	String findByShopName(String shopName);
	String findByCoffeeName(String coffeeName);
}
