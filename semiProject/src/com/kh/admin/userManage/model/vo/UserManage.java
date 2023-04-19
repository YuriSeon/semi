package com.kh.admin.userManage.model.vo;

public class UserManage extends User{
	
//	USERNO	NUMBER
//	REPLY_COUNT	NUMBER
//	BOARD_COUNT	NUMBER
//	VIDEO_COUNT	NUMBER
//	FOODBOARD_STATUS	VARCHAR2(1 BYTE)
	
	private int userNo;
	private int replyCount;
	private int boardCount;
	private int videoCount;
	private String foodBStatus;
	
	public UserManage() {
		super();
	}

	
	public UserManage(int userNo, int replyCount, int boardCount, int videoCount) {
		super();
		this.userNo = userNo;
		this.replyCount = replyCount;
		this.boardCount = boardCount;
		this.videoCount = videoCount;
	}


	public UserManage(int userNo, int replyCount, int boardCount, int videoCount, String foodBStatus) {
		super();
		this.userNo = userNo;
		this.replyCount = replyCount;
		this.boardCount = boardCount;
		this.videoCount = videoCount;
		this.foodBStatus = foodBStatus;
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

	public int getVideoCount() {
		return videoCount;
	}

	public void setVideoCount(int videoCount) {
		this.videoCount = videoCount;
	}

	public String getFoodBStatus() {
		return foodBStatus;
	}

	public void setFoodBStatus(String foodBStatus) {
		this.foodBStatus = foodBStatus;
	}

	
	@Override
	public String toString() {
		return "UserManage [userNo=" + userNo + ", replyCount=" + replyCount + ", boardCount=" + boardCount
				+ ", videoCount=" + videoCount + ", foodBStatus=" + foodBStatus + "]";
	}
	
	

}
