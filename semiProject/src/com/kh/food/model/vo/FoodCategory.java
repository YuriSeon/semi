package com.kh.food.model.vo;

public class FoodCategory {
	private int foodCategory;
	private String foodName;
	public FoodCategory() {
		super();
	}
	public FoodCategory(int foodCategory, String foodName) {
		super();
		this.foodCategory = foodCategory;
		this.foodName = foodName;
	}
	public int getFoodCategory() {
		return foodCategory;
	}
	public void setFoodCategory(int foodCategory) {
		this.foodCategory = foodCategory;
	}
	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}	
}