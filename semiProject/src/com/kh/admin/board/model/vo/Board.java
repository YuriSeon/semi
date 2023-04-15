package com.kh.admin.board.model.vo;

import java.sql.Date;

public class Board {
	
//	BOARD_NO	NUMBER
//	USERNO	NUMBER
//	BOARD_TYPE	NUMBER
//	BOARD_TITLE	VARCHAR2(60 BYTE)
//	BOARD_CONTENT	VARCHAR2(4000 BYTE)
//	CREATE_DATE	DATE
//	MODIFY_DATE	DATE
//	RECOMMEND	NUMBER
//	STATUS	VARCHAR2(1 BYTE)
//	COUNT	NUMBER
	
	private int boardNo;
	private int userNo;
	private int boardType;
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date ModifyDate;
	private int reCommend;
	private String status;
	private int count;
	
	
	public Board() {
		super();
	}


	public Board(int boardNo, int userNo, int boardType, String boardTitle, String boardContent, Date createDate,
			Date modifyDate, int reCommend, String status, int count) {
		super();
		this.boardNo = boardNo;
		this.userNo = userNo;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		ModifyDate = modifyDate;
		this.reCommend = reCommend;
		this.status = status;
		this.count = count;
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


	public int getBoardType() {
		return boardType;
	}


	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}


	public String getBoardTitle() {
		return boardTitle;
	}


	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}


	public String getBoardContent() {
		return boardContent;
	}


	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public Date getModifyDate() {
		return ModifyDate;
	}


	public void setModifyDate(Date modifyDate) {
		ModifyDate = modifyDate;
	}


	public int getReCommend() {
		return reCommend;
	}


	public void setReCommend(int reCommend) {
		this.reCommend = reCommend;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
	}


	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", userNo=" + userNo + ", boardType=" + boardType + ", boardTitle="
				+ boardTitle + ", boardContent=" + boardContent + ", createDate=" + createDate + ", ModifyDate="
				+ ModifyDate + ", reCommend=" + reCommend + ", status=" + status + ", count=" + count + "]";
	}
	
	
	

}
