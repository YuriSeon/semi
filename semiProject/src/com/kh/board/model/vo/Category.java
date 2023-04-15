package com.kh.board.model.vo;

public class Category {
//	  CATEGORY_NO NUMBER PRIMARY KEY
//    CATEGORY_TYPE VARCHAR2(30) NOT NULL
	private int categoryNo; //카테고리번호
	private String category_type; //카테고리 타입 (1릴스,2대나무숲)
	public Category() {
		super();
	}
	public Category(int categoryNo, String category_type) {
		super();
		this.categoryNo = categoryNo;
		this.category_type = category_type;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategory_type() {
		return category_type;
	}
	public void setCategory_type(String category_type) {
		this.category_type = category_type;
	}
	@Override
	public String toString() {
		return "Category [categoryNo=" + categoryNo + ", category_type=" + category_type + "]";
	}
	
}
