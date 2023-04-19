package com.kh.admin.userManage.model.vo;

public class UserCondition extends User{
//	USERNO	NUMBER
//	BLOCK_C	NUMBER
//	DM_BLOCK_C	NUMBER
//	FALSE_BLOCK_C	NUMBER
//	YELLOW_CARD	NUMBER
//	VIDEO_FILTERING	NUMBER
//	REPLY_FILTERING	NUMBER
	
	private int userNo;
	private int blockC;
	private int dmBlockC;
	private int falseBlockC;
	private int yellowCard;
	private int videoFiltering;
	private int replyFiltering;
	
	
	public UserCondition() {
		super();
	}
	
	
	public UserCondition(int userNo, int blockC, int dmBlockC, int falseBlockC) {
		super();
		this.userNo = userNo;
		this.blockC = blockC;
		this.dmBlockC = dmBlockC;
		this.falseBlockC = falseBlockC;
	}



	public UserCondition(int userNo, int blockC, int dmBlockC, int falseBlockC, int yellowCard, int videoFiltering,
			int replyFiltering) {
		super();
		this.userNo = userNo;
		this.blockC = blockC;
		this.dmBlockC = dmBlockC;
		this.falseBlockC = falseBlockC;
		this.yellowCard = yellowCard;
		this.videoFiltering = videoFiltering;
		this.replyFiltering = replyFiltering;
	}
	
	
	public int getUserNo() {
		return userNo;
	}
	
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	public int getBlockC() {
		return blockC;
	}
	
	public void setBlockC(int blockC) {
		this.blockC = blockC;
	}
	
	public int getDmBlockC() {
		return dmBlockC;
	}
	
	public void setDmBlockC(int dmBlockC) {
		this.dmBlockC = dmBlockC;
	}
	
	public int getFalseBlockC() {
		return falseBlockC;
	}
	
	public void setFalseBlockC(int falseBlockC) {
		this.falseBlockC = falseBlockC;
	}
	
	public int getYellowCard() {
		return yellowCard;
	}
	
	public void setYellowCard(int yellowCard) {
		this.yellowCard = yellowCard;
	}
	
	public int getVideoFiltering() {
		return videoFiltering;
	}
	
	public void setVideoFiltering(int videoFiltering) {
		this.videoFiltering = videoFiltering;
	}
	
	public int getReplyFiltering() {
		return replyFiltering;
	}
	
	public void setReplyFiltering(int replyFiltering) {
		this.replyFiltering = replyFiltering;
	}
	
	
	@Override
	public String toString() {
		return "UserCondition [userNo=" + userNo + ", blockC=" + blockC + ", dmBlockC=" + dmBlockC + ", falseBlockC="
				+ falseBlockC + ", yellowCard=" + yellowCard + ", videoFiltering=" + videoFiltering
				+ ", replyFiltering=" + replyFiltering + "]";
	}
	
	

}
