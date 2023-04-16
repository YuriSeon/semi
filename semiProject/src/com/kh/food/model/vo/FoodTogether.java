package com.kh.food.model.vo;

public class FoodTogether {

    // BOARD_NO NUMBER NOT NULL,
    // DETAIL_TYPE NUMBER DEFAULT 2 NOT NULL,
    // --  2번이 밥 같이 먹을 사람 게시판이다.
    // END_TIME DATE NOT NULL
	
	private int boardNo;
	private int detailType;
	private String endTime;
	public FoodTogether() {
		super();
	}
	public FoodTogether(int boardNo, int detailType, String endTime) {
		super();
		this.boardNo = boardNo;
		this.detailType = detailType;
		this.endTime = endTime;
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
