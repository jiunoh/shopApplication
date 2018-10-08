package com.shop;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="totalcoffee")
public class TotalCoffee {
	@Id
	private int id;
	
	private String name;
	private int total_sale;
	private int toal_income;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTotal_sale() {
		return total_sale;
	}
	public void setTotal_sale(int total_sale) {
		this.total_sale = total_sale;
	}
	public int getToal_income() {
		return toal_income;
	}
	public void setToal_income(int toal_income) {
		this.toal_income = toal_income;
	}
	
	
}
