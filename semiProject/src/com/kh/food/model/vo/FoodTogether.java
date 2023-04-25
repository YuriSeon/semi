package com.kh.food.model.vo;

public class FoodTogether {

    // BOARD_NO NUMBER NOT NULL,
    // DETAIL_TYPE NUMBER DEFAULT 2 NOT NULL,
    // --  2���� �� ���� ���� ��� �Խ����̴�.
    // END_TIME String NOT NULL
	
	private int boardNo;
	private int detailType;
	private String mainAdress;
	private String subAddress;
	private int person;
	private String endTime;
	
	public FoodTogether(int boardNo, int detailType, String mainAdress, String subAddress, int person, String endTime) {
		super();
		this.boardNo = boardNo;
		this.detailType = detailType;
		this.mainAdress = mainAdress;
		this.subAddress = subAddress;
		this.person = person;
		this.endTime = endTime;
	}
	
	
	
	public FoodTogether() {
		super();
	}
	public FoodTogether(int boardNo, int detailType, String endTime) {
		super();
		this.boardNo = boardNo;
		this.detailType = detailType;
		this.endTime = endTime;
	}
	
	
	public String getMainAdress() {
		return mainAdress;
	}
	public void setMainAdress(String mainAdress) {
		this.mainAdress = mainAdress;
	}
	public String getSubAddress() {
		return subAddress;
	}
	public void setSubAddress(String subAddress) {
		this.subAddress = subAddress;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getDetailType() {
		return detailType;
	}
	public void setDetailType(int detailType) {
		this.detailType = detailType;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	
	
}
