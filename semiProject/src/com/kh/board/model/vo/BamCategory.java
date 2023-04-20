package com.kh.board.model.vo;

public class BamCategory {
//	BOARD_NO NUMBER PRIMARY KEY,
//  BAM_CATEGORY_NO NUMBER NOT NULL 
	private int boardNo; //게시글번호
	private int bamCategoryNo; //대나무숲 카테고리 번호 1.일반,2.질문,3.연애
	private String bamCategoryName; //카테고리 이름 담을 변수
	public BamCategory() {
		super();
	}
	
	public BamCategory(int bamCategoryNo, String bamCategoryName) {
		super();
		this.bamCategoryNo = bamCategoryNo;
		this.bamCategoryName = bamCategoryName;
	}

	public BamCategory(int boardNo, int bamCategoryNo, String bamCategoryName) {
		super();
		this.boardNo = boardNo;
		this.bamCategoryNo = bamCategoryNo;
		this.bamCategoryName = bamCategoryName;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getBamCategoryNo() {
		return bamCategoryNo;
	}

	public void setBamCategoryNo(int bamCategoryNo) {
		this.bamCategoryNo = bamCategoryNo;
	}

	public String getBamCategoryName() {
		return bamCategoryName;
	}

	public void setBamCategoryName(String bamCategoryName) {
		this.bamCategoryName = bamCategoryName;
	}

	@Override
	public String toString() {
		return "BamCategory [boardNo=" + boardNo + ", bamCategoryNo=" + bamCategoryNo + ", bamCategoryName="
				+ bamCategoryName + "]";
	}
	
	
}
