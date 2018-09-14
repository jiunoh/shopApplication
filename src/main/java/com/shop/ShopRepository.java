package com.shop;

import org.springframework.data.repository.CrudRepository;

public interface ShopRepository extends CrudRepository<Shop, Integer>  {
	Shop findById(int id);
}
