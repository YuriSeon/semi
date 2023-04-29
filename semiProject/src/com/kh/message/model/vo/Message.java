package com.kh.message.model.vo;

import java.util.Date;

public class Message { 
//	  MSG_NO NUMBER PRIMARY KEY
//    USERNO NUMBER NOT NULL FOREIGN KEY BMEMBER (USER_NO)
//    MSG_CONTENT VARCHAR2(1000) NOT NULL
//    MSG_SEND_DATE DATE DEFAULT SYSDATE
//    ACCEPT_USER_NO NUMBER NOT NULL
	private int msgNo; //메시지번호
	private String userWriter; //유저번호인데 insert할때 유저번호 select할 때유저 이름도 담아야할거 같아서 String
	private String msgContent; //메시지 내용
	private Date msgSendDate; //메시지 작성일
	private String acceptUser; //메시지받는 유저 번호인데 두번째와 동일 
	public Message() {
		super();
	}
	

	//마이페이지 쪽지함 확인용
	public Message(int msgNo, String userWriter, String msgContent, Date msgSendDate) {
		super();
		this.msgNo = msgNo;
		this.userWriter = userWriter;
		this.msgContent = msgContent;
		this.msgSendDate = msgSendDate;
	}


	public Message(int msgNo, String userWriter, String msgContent, Date msgSendDate, String acceptUser) {
		super();
		this.msgNo = msgNo;
		this.userWriter = userWriter;
		this.msgContent = msgContent;
		this.msgSendDate = msgSendDate;
		this.acceptUser = acceptUser;
	}
	public int getMsgNo() {
		return msgNo;
	}
	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}
	public String getUserWriter() {
		return userWriter;
	}
	public void setUserWriter(String userWriter) {
		this.userWriter = userWriter;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public Date getMsgSendDate() {
		return msgSendDate;
	}
	public void setMsgSendDate(Date msgSendDate) {
		this.msgSendDate = msgSendDate;
	}
	public String getAcceptUser() {
		return acceptUser;
	}
	public void setAcceptUser(String acceptUser) {
		this.acceptUser = acceptUser;
	}
	@Override
	public String toString() {
		return "Message [msgNo=" + msgNo + ", userWriter=" + userWriter + ", msgContent=" + msgContent
				+ ", msgSendDate=" + msgSendDate + ", acceptUser=" + acceptUser + "]";
	}
	
	
	
}
