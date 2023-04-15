package com.kh.board.model.vo;

import java.sql.Date;

public class Board {
	
//	BOARD_NO	NUMBER
//	USERNO	NUMBER		
	// 이거는 원래 no인데 회원번호 조회해온거 필요 없을거같아서 회원이름으로 바꿀게요
//	BOARD_TYPE	NUMBER
//	BOARD_TITLE	VARCHAR2(60 BYTE)
//	BOARD_CONTENT	VARCHAR2(4000 BYTE)
//	CREATE_DATE	DATE
//	MODIFY_DATE	DATE
//	RECOMMEND	NUMBER
//	STATUS	VARCHAR2(1 BYTE)
//	COUNT	NUMBER
	
	private int boardNo;
	private String boardWriter;
	private int boardType;
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date ModifyDate;
	private int recommend;
	private String status;
	private int count;
	
	
	public Board() {
		super();
	}
	
	public Board(int boardNo, String boardWriter, int boardType, String boardTitle, Date createDate) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.createDate = createDate;
	}



	public Board(int boardNo, String boardWriter, int boardType, String boardTitle, String boardContent, Date createDate,
			Date modifyDate, int recommend, String status, int count) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		ModifyDate = modifyDate;
		this.recommend = recommend;
		this.status = status;
		this.count = count;
	}


	public int getBoardNo() {
		return boardNo;
	}


	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}


	public String getBoardWriter() {
		return boardWriter;
	}


	public void setUserNo(String boardWriter) {
		this.boardWriter = boardWriter;
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
		return recommend;
	}


	public void setReCommend(int recommend) {
		this.recommend = recommend;
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
		return "Board [boardNo=" + boardNo + ", boardWriter=" + boardWriter + ", boardType=" + boardType + ", boardTitle="
				+ boardTitle + ", boardContent=" + boardContent + ", createDate=" + createDate + ", ModifyDate="
				+ ModifyDate + ", recommend=" + recommend + ", status=" + status + ", count=" + count + "]";
	}
	
	
	

}
