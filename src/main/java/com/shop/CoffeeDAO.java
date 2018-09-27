package com.shop;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface CoffeeDAO extends JpaRepository<Coffee, Integer> {
	@Query
	Coffee findById(int id);

	@Query
	Coffee findByName(String name);
}
