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
	private int un;

	// 공지사항 관리 위해서 필드 하나 추가 
	private int typeNo;
	
	// 대나무숲 사진여부를 위해서 만듬
	private String fileNo; //파일번호지만 null값을 받아야해서 String으로함
	private int replyCount;

	public int getUn() {
		return un;
	}
	public void setUn(int un) {
		this.un = un;
	}
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
	
	//대나무숲 공지사항 가져오기
	public Board(int boardNo, String boardWriter, String boardTitle, String boardContent, Date createDate, int good,
			String fileNo,int count,int typeNo ) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		this.good = good;
		this.fileNo = fileNo;
		this.count = count;
		this.typeNo=typeNo;
	}
	
	//대나무숲 페이지 만들때 게시글 
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, String boardContent,
			Date createDate, int good,String fileNo, int count,int replyCount) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		this.good = good;
		this.fileNo= fileNo;
		this.count = count;
		this.replyCount=replyCount;
	}
	
	
	public Board(int boardNo, String boardWriter, String boardTitle, String boardContent, Date createDate, int good,
			int count) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		this.good = good;
		this.count = count;
	}
	//대나무숲 게시글 디테일
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, String boardContent,
			Date createDate, Date modifyDate, int good, int count,int typeNo) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		ModifyDate = modifyDate;
		this.good = good;
		this.count = count;
		this.typeNo=typeNo;
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
			,String abbress, int un) {
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
		this.un = un;
	}
	//영상 페이징바
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, Date createDate, int count) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.createDate = createDate;
		this.count = count;
	}


	// 관리자 페이지에 게시물조회에 사용할 생성자
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, Date createDate, Date modifyDate,
			int good, int count, int typeNo) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.createDate = createDate;
		ModifyDate = modifyDate;
		this.good = good;
		this.count = count;
		this.typeNo = typeNo;
	}
	
	// 공지사항 insert 생성자
	public Board(String boardWriter, String boardType, String boardTitle, String boardContent,
			int typeNo) {
		super();
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.typeNo = typeNo;
	}
	
	// 관리자 페이지 게시물 상세보기에 사용
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, String boardContent,
			Date createDate, int good, int bad, int report, int count) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.createDate = createDate;
		this.good = good;
		this.bad = bad;
		this.report = report;
		this.count = count;
	}
	
	// blur처리된 게시판 조회시 사용
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, Date createDate, int bad,
			int report, int count) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.createDate = createDate;
		this.bad = bad;
		this.report = report;
		this.count = count;
	}
	
	
	
	public Board(int boardNo, String boardWriter, String boardType, String boardTitle, String status) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.boardType = boardType;
		this.boardTitle = boardTitle;
		this.status = status;
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
	
	public int getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}

	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	
	
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardWriter=" + boardWriter + ", boardType=" + boardType
				+ ", boardTitle=" + boardTitle + ", boardContent=" + boardContent + ", createDate=" + createDate
				+ ", ModifyDate=" + ModifyDate + ", good=" + good + ", bad=" + bad + ", report=" + report + ", status="
				+ status + ", count=" + count + ", pointName=" + pointName + ", foodName=" + foodName + ", abbress="
				+ abbress + ", un=" + un + ", typeNo=" + typeNo + ", fileNo=" + fileNo + ", replyCount=" + replyCount
				+ "]";
	}
}
