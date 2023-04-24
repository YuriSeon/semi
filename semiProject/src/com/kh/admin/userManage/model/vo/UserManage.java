package com.kh.admin.userManage.model.vo;

public class UserManage extends User{
	
//	USERNO	NUMBER
//	REPLY_COUNT	NUMBER
//	BOARD_COUNT	NUMBER
//	FOODBOARD_STATUS	VARCHAR2(1 BYTE)
//	CK	VARCHAR2(5 BYTE)
	
	private int userNo;
	private int replyCount;
	private int boardCount;
	private String foodBStatus;
	private String ck;
	
	public UserManage() {
		super();
	}
	
	
	
	public UserManage(int userNo, int replyCount, int boardCount, String foodBStatus) {
		super();
		this.userNo = userNo;
		this.replyCount = replyCount;
		this.boardCount = boardCount;
		this.foodBStatus = foodBStatus;
	}



	public UserManage(int userNo, int replyCount, int boardCount, String foodBStatus, String ck) {
		super();
		this.userNo = userNo;
		this.replyCount = replyCount;
		this.boardCount = boardCount;
		this.foodBStatus = foodBStatus;
		this.ck = ck;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public String getFoodBStatus() {
		return foodBStatus;
	}

	public void setFoodBStatus(String foodBStatus) {
		this.foodBStatus = foodBStatus;
	}

	public String getCk() {
		return ck;
	}

	public void setCk(String ck) {
		this.ck = ck;
	}

	@Override
	public String toString() {
		return "UserManage [userNo=" + userNo + ", replyCount=" + replyCount + ", boardCount=" + boardCount
				+ ", foodBStatus=" + foodBStatus + ", ck=" + ck + "]";
	}
	
	

}
