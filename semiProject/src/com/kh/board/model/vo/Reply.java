package com.kh.board.model.vo;

import java.util.Date;

public class Reply {
//	  REPLY_NO NUMBER PRIMARY KEY
//	  BOARD_NO NUMBER NOT NULL
//	  REPLY_CONTENT VARCHAR2(400) NOT NULL
//	  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL
//	  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N'))
	private int replyNo;
	private int boardNo;
	private String replyContent;
	private Date createDate;
	private String status;
	public Reply() {
		super();
	}
	public Reply(int replyNo, int boardNo, String replyContent, Date createDate, String status) {
		super();
		this.replyNo = replyNo;
		this.boardNo = boardNo;
		this.replyContent = replyContent;
		this.createDate = createDate;
		this.status = status;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Reply [replyNo=" + replyNo + ", boardNo=" + boardNo + ", replyContent=" + replyContent + ", createDate="
				+ createDate + ", status=" + status + "]";
	}
	
	
}
