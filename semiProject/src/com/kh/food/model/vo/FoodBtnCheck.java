package com.kh.food.model.vo;

public class FoodBtnCheck {
	private int boardNo;
	private int userNo;
	private String btnStyle;
	public FoodBtnCheck() {
		super();
	}
	public FoodBtnCheck(int boardNo, int userNo, String btnStyle) {
		super();
		this.boardNo = boardNo;
		this.userNo = userNo;
		this.btnStyle = btnStyle;
	}
	
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getBtnStyle() {
		return btnStyle;
	}
	public void setBtnStyle(String btnStyle) {
		this.btnStyle = btnStyle;
	}
	
	
}
