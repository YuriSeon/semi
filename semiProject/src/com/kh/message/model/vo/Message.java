package com.kh.message.model.vo;

import java.util.Date;

public class Message { //메시지,쪽지 용
	private int msgNo; //메시지번호
	private String userWriter; //유저번호인데 insert할때 유저번호 select할 때유저 이름도 담아야할거 같아서 String
	private String msgContent; //메시지 내용
	private Date msgSendDate; //메시지 작성일
	private String acceptUser; //메시지받는 유저 번호인데 두번째와 동일 
	public Message() {
		super();
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