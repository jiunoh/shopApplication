package com.shop;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ShopDAO extends JpaRepository<Shop, Integer>  {
	Shop findById(int id);
	Shop findByName(String name);
	Shop findByNameAndIsDeleted(String name, String isDeleted);
}
