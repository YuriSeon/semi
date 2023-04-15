package com.kh.board.model.vo;

import java.util.Date;

public class Attachment {
//	  FILE_NO NUMBER PRIMARY KEY
//	  BOARD_NO NUMBER NOT NULL
//	  FILE_NAME VARCHAR2(255) NOT NULL
//	  FILE_PATH VARCHAR2(1000)
//	  UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL
//	  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N'))
	private int fileNo;	//파일번호
	private int boardNo; //게시판번호
	private String fileName; //파일 이름
	private String filePath; //파일 저장 경로
	private Date uploadDate; // 업로드일
	private String status; //삭제여부(Y , N삭제)
	public Attachment() {
		super();
	}
	public Attachment(int fileNo, int boardNo, String fileName, String filePath, Date uploadDate, String status) {
		super();
		this.fileNo = fileNo;
		this.boardNo = boardNo;
		this.fileName = fileName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.status = status;
	}
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Attachment [fileNo=" + fileNo + ", boardNo=" + boardNo + ", fileName=" + fileName + ", filePath="
				+ filePath + ", uploadDate=" + uploadDate + ", status=" + status + "]";
	}
	
	
}
