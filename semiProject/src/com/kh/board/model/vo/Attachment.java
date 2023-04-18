package com.kh.board.model.vo;

import java.util.Date;

public class Attachment {
//	  FILE_NO NUMBER PRIMARY KEY
//	  BOARD_NO NUMBER NOT NULL
//	  ORIGIN_NAME VARCHAR2(255) NOT NULL
//	  CHANGE_NAME VARCHAR2(255) NOT NULL
//	  FILE_PATH VARCHAR2(1000)
//	  UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL
//	  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N'))
	private int fileNo;	//파일번호
	private int boardNo; //게시판번호
	private String originName; //파일  원본명
	private String changeName; //파일 수정명
	private String filePath; //파일 저장 경로
	private Date uploadDate; // 업로드일
	private String status; //삭제여부(Y , N삭제)
	public Attachment() {
		super();
	}
	
	//대나무숲 첨부파일 용
	public Attachment(int fileNo, String originName, String changeName, String filePath, Date uploadDate) {
		super();
		this.fileNo = fileNo;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
	}

	public Attachment(int fileNo, int boardNo, String originName, String changeName, String filePath, Date uploadDate,
			String status) {
		super();
		this.fileNo = fileNo;
		this.boardNo = boardNo;
		this.originName = originName;
		this.changeName = changeName;
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
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public String getChangeName() {
		return changeName;
	}
	public void setChangeName(String changeName) {
		this.changeName = changeName;
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
		return "Attachment [fileNo=" + fileNo + ", boardNo=" + boardNo + ", originName=" + originName + ", changeName="
				+ changeName + ", filePath=" + filePath + ", uploadDate=" + uploadDate + ", status=" + status + "]";
	}
	
	
}
