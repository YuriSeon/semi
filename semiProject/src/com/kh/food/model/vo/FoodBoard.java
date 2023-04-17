package com.kh.food.model.vo;

public class FoodBoard {
	   //BOARD_TYPE NUMBER DEFAULT 3 NOT NULL,
	   //DETAIL_TYPE NUMBER DEFAULT 1 NOT NULL CONSTRAINT DETAIL_CHECK CHECK(DETAIL_TYPE IN (1,2)),
	   //BOARD_NO NUMBER PRIMARY KEY,
	   //FOOD_CATEGORY NUMBER NOT NULL,
	   //ADDRESS VARCHAR2(1000)
	private int boardType;
	private int detailType;
	private int boardNo;
	private int foodCategory;
	private String address;
	public FoodBoard() {
		super();
	}
	public FoodBoard(int boardType, int detailType, int boardNo, int foodCategory, String address) {
		super();
		this.boardType = boardType;
		this.detailType = detailType;
		this.boardNo = boardNo;
		this.foodCategory = foodCategory;
		this.address = address;
	}
	public int getBoardType() {
		return boardType;
	}
	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}
	public int getDetailType() {
		return detailType;
	}
	public void setDetailType(int detailType) {
		this.detailType = detailType;
	}
	public int getBoardNo() { 
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getFoodCategory() {
		return foodCategory;
	}
	public void setFoodCategory(int foodCategory) {
		this.foodCategory = foodCategory;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	
}