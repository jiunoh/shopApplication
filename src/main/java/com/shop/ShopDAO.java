package com.shop;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ShopDAO extends JpaRepository<ShopVO, Integer>  {
	ShopVO findById(int id);
	ShopVO findByName(String name);
	ShopVO findByNameAndIsDeleted(String name, String isDeleted);
}
