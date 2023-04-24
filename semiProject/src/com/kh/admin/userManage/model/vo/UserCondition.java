package com.kh.admin.userManage.model.vo;

public class UserCondition extends User{
//	USERNO	NUMBER
//	BLOCK_C	NUMBER
//	DM_BLOCK_C	NUMBER
//	FALSE_BLOCK_C	NUMBER
//	YELLOW_CARD	NUMBER
//	BOARD_FILTERING	NUMBER
//	REPLY_FILTERING	NUMBER
	
	private int userNo;
	private int blockC;
	private int dmBlockC;
	private int falseBlockC;
	private int yellowCard;
	private int boardFiltering;
	private int replyFiltering;
	
	//total 담을 필드 추가 
	private int totalB; // 차단 횟수 합계
	private int totalF; // 필터링 횟수 합계
	
	
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



	public UserCondition(int userNo, int blockC, int dmBlockC, int falseBlockC, int yellowCard, int boardFiltering,
			int replyFiltering) {
		super();
		this.userNo = userNo;
		this.blockC = blockC;
		this.dmBlockC = dmBlockC;
		this.falseBlockC = falseBlockC;
		this.yellowCard = yellowCard;
		this.boardFiltering = boardFiltering;
		this.replyFiltering = replyFiltering;
	}
	
	


	// 체크리스트 담아갈 생성자
	public UserCondition(int userNo, int blockC, int dmBlockC, int falseBlockC, int yellowCard, int boardFiltering,
			int replyFiltering, int totalB, int totalF) {
		super();
		this.userNo = userNo;
		this.blockC = blockC;
		this.dmBlockC = dmBlockC;
		this.falseBlockC = falseBlockC;
		this.yellowCard = yellowCard;
		this.boardFiltering = boardFiltering;
		this.replyFiltering = replyFiltering;
		this.totalB = totalB;
		this.totalF = totalF;
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
	
	public int getBoardFiltering() {
		return boardFiltering;
	}
	
	public void setBoardFiltering(int boardFiltering) {
		this.boardFiltering = boardFiltering;
	}
	
	public int getReplyFiltering() {
		return replyFiltering;
	}
	
	public void setReplyFiltering(int replyFiltering) {
		this.replyFiltering = replyFiltering;
	}
	
	
	public int getTotalB() {
		return totalB;
	}


	public void setTotalB(int totalB) {
		this.totalB = totalB;
	}


	public int getTotalF() {
		return totalF;
	}


	public void setTotalF(int totalF) {
		this.totalF = totalF;
	}


	@Override
	public String toString() {
		return "UserCondition [userNo=" + userNo + ", blockC=" + blockC + ", dmBlockC=" + dmBlockC + ", falseBlockC="
				+ falseBlockC + ", yellowCard=" + yellowCard + ", boardFiltering=" + boardFiltering
				+ ", replyFiltering=" + replyFiltering + "]";
	}
	
	

}
