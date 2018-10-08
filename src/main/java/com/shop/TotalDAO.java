package com.shop;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TotalDAO extends JpaRepository<TotalCoffee, Integer> {
	TotalCoffee findById(int id);
}
