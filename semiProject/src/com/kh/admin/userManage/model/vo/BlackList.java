package com.kh.admin.userManage.model.vo;

public class BlackList {
	
//	USERNO	NUMBER
//	USERID	VARCHAR2(20 BYTE)
//	USERNAME	VARCHAR2(50 BYTE)
//	PHONE	VARCHAR2(20 BYTE)
//	EMAIL	VARCHAR2(100 BYTE)
//	SSN	VARCHAR2(30 BYTE)
//	BLOCK_C	NUMBER
//	DM_BLOCK_C	NUMBER
//	FALSE_BLOCK_C	NUMBER
//	FILTERING(VIDEO+REPLY)	NUMBER
//	STATUS	VARCHAR2(5 BYTE)
	
	private int userNo;
	private String userId;
	private String userName;
	private String phone;
	private String email;
	private String ssn;
	private int blockC;
	private int dmBlockC;
	private int falseBlockC;
	private int filtering;
	private String reEnroll;
	
	
	public BlackList() {
		super();
	}

	public BlackList(int userNo, String userId, String userName, String phone, String email, String ssn, int blockC,
			int dmBlockC, int falseBlockC, int filtering, String reEnroll) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.ssn = ssn;
		this.blockC = blockC;
		this.dmBlockC = dmBlockC;
		this.falseBlockC = falseBlockC;
		this.filtering = filtering;
		this.reEnroll = reEnroll;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSsn() {
		return ssn;
	}

	public void setSsn(String ssn) {
		this.ssn = ssn;
	}

	public int getBlockC() {
		return blockC;
	}

	public void setBlockC(int blockC) {
		this.blockC = blockC;
	}

	public int getDmBlockC() {
		return dmBlockC;
	}

	public void setDmBlockC(int dmBlockC) {
		this.dmBlockC = dmBlockC;
	}

	public int getFalseBlockC() {
		return falseBlockC;
	}

	public void setFalseBlockC(int falseBlockC) {
		this.falseBlockC = falseBlockC;
	}

	public int getFiltering() {
		return filtering;
	}

	public void setFiltering(int filtering) {
		this.filtering = filtering;
	}

	public String getReEnroll() {
		return reEnroll;
	}

	public void setReEnroll(String reEnroll) {
		this.reEnroll = reEnroll;
	}

	
	@Override
	public String toString() {
		return "BlackList [userNo=" + userNo + ", userId=" + userId + ", userName=" + userName + ", phone=" + phone
				+ ", email=" + email + ", ssn=" + ssn + ", blockC=" + blockC + ", dmBlockC=" + dmBlockC
				+ ", falseBlockC=" + falseBlockC + ", filtering=" + filtering + ", reEnroll=" + reEnroll + "]";
	}
	
	
}
