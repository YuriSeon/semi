package com.kh.message.model.vo;

import java.util.Date;

public class MessageBlock {
	
	private String userNo; //로그인한 회원번호
	private String blockUser; //차단당한 회원번호
	private String blockContent; //차단관련 메모
	private Date createDate; //차단 날짜
	public MessageBlock() {
		super();
	}
	
	public MessageBlock(String userNo, String blockUser, String blockContent) {
		super();
		this.userNo = userNo;
		this.blockUser = blockUser;
		this.blockContent = blockContent;
	}

	public MessageBlock(String userNo, String blockUser, String blockContent, Date createDate) {
		super();
		this.userNo = userNo;
		this.blockUser = blockUser;
		this.blockContent = blockContent;
		this.createDate = createDate;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getBlockUser() {
		return blockUser;
	}
	public void setBlockUser(String blockUser) {
		this.blockUser = blockUser;
	}
	public String getBlockContent() {
		return blockContent;
	}
	public void setBlockContent(String blockContent) {
		this.blockContent = blockContent;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "MessageBlock [userNo=" + userNo + ", blockUser=" + blockUser + ", blockContent=" + blockContent
				+ ", createDate=" + createDate + "]";
	}
	
	

}
