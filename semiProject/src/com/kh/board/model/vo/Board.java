package com.kh.board.model.vo;

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
	private String boardWriter; // 이거는 원래 no인데 회원번호 조회해온거 필요 없을거같아서 작성자로 바꿀게요
	private String boardType; // 이것도 위에랑 마찬가지로 게시글타입을 번호로 보여줄일이 없을거같아서 String으로 타입 바꿀게요
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date ModifyDate;
	private int good;
	private int bad;
	private int report;
	private String status;
	private int count;
	
	// 맛집 포인트에 따른 등급 부여를 위한 것임 신경쓸 필요없음
	private String pointName; 
	private String foodName;
	private String abbress;
	

	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	public String getAbbress() {
		return abbress;
	}
	public void setAbbress(String abbress) {
		this.abbress = abbress;
	}
	public Board() {
		super();
	}
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, String boardContent,
			Date createDate, Date modifyDate, int good, int bad, int report, String status, int count) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		this.ModifyDate = modifyDate;
		this.good = good;
		this.bad = bad;
		this.report = report;
		this.status = status;
		this.count = count;
	}
	
	
	
	// 맛집 게시판에 뿌릴 내용
	public Board(int boardNo, String boardTitle, String boardContent, int good, Date createDate, String boardWriter) {
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.good = good;
		this.createDate = createDate;
		this.boardWriter = boardWriter;
	}
	// 맛집 게시판 디테일 뷰 내용
	public Board(String boardTitle, String boardContent, String foodName, int good, int bad,int report, Date createDate,String boardWriter
			,String abbress) {
		super();
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.foodName = foodName;
		this.good = good;
		this.bad = bad;
		this.report = report;
		this.createDate = createDate;
		this.boardWriter = boardWriter;
		this.abbress = abbress;
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
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
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
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getBad() {
		return bad;
	}
	public void setBad(int bad) {
		this.bad = bad;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
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
	
	public String getPointName() {
		return pointName;
	}
	public void setPointName(String pointName) {
		this.pointName = pointName;
	}
	
}
