package com.shop;

import org.springframework.data.repository.CrudRepository;

public interface ShopDAO extends CrudRepository<ShopVO, Integer>  {
	ShopVO findById(int id);
}
