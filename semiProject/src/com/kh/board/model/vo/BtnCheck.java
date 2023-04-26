package com.kh.board.model.vo;

public class BtnCheck { //추천,비추천,신고 중복방지를 위함
//	BOARD_NO NUMBER, 게시글 번호
//	USERNO NUMBER, 회원번호
//	BTNTYPE VARCHAR2(20),  추천,비추천,신고
//	CONSTRAINT BTNCHECK_PK PRIMARY KEY (BOARD_NO, USERNO)
	private int boardNo;
	private int userNo;
	private String btncheck;
	public BtnCheck() {
		super();
	}
	public BtnCheck(int boardNo, int userNo, String btncheck) {
		super();
		this.boardNo = boardNo;
		this.userNo = userNo;
		this.btncheck = btncheck;
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
	public String getBtncheck() {
		return btncheck;
	}
	public void setBtncheck(String btncheck) {
		this.btncheck = btncheck;
	}
	@Override
	public String toString() {
		return "BtnCheck [boardNo=" + boardNo + ", userNo=" + userNo + ", btncheck=" + btncheck + "]";
	}
	
	
}
