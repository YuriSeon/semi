package com.kh.admin.admin.model.vo;

public class AdminAttend {
	
//	USERNO	NUMBER
//	RUSH_HOUR	DATE
//	OVER_HOUR	DATE
	
	private int userNo;
	private String rushHour;
	private String overHour;
	
	
	public AdminAttend() {
		super();
	}
	
	public AdminAttend(int userNo, String rushHour, String overHour) {
		super();
		this.userNo = userNo;
		this.rushHour = rushHour;
		this.overHour = overHour;
	}
	
	
	public int getUserNo() {
		return userNo;
	}
	
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	public String getRushHour() {
		return rushHour;
	}
	
	public void setRushHour(String rushHour) {
		this.rushHour = rushHour;
	}
	
	public String getOverHour() {
		return overHour;
	}
	
	public void setOverHour(String overHour) {
		this.overHour = overHour;
	}
	
	
	@Override
	public String toString() {
		return "AdminAttend [userNo=" + userNo + ", rushHour=" + rushHour + ", overHour=" + overHour + "]";
	}
	
	
	

}
