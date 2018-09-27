package com.shop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ShopDAO extends JpaRepository<Shop, Integer>  {
	Shop findById(int id);
	Shop findByName(String name);
	List<Shop> findByIsDeleted(String isDeleted);
	Shop findByNameAndIsDeleted(String name, String isDeleted);
	List<Shop> findByMenuContaining(String coffee);	
}