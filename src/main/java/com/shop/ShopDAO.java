package com.shop;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopDAO {
	void registShop(Shop shop);
}
