package com.shop;

import org.springframework.stereotype.Repository;

@Repository
public interface MenuDAO {
	void registMenu(Menu menu);
}
