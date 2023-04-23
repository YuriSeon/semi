package com.kh.admin.userManage.model.vo;

public class User {
	
	private int totalUser; // 현재 총 회원 수
	private int recentEnroll; // 최근 가입자 수
	private int withdraw; // 탈퇴 회원 수
	private int kickOut; // 강퇴 회원 수 
	
	
	public User() {
		super();
	}

	public User(int totalUser, int recentEnroll, int withdraw, int kickOut) {
		super();
		this.totalUser = totalUser;
		this.recentEnroll = recentEnroll;
		this.withdraw = withdraw;
		this.kickOut = kickOut;
	}

	
	public int getTotalUser() {
		return totalUser;
	}

	public void setTotalUser(int totalUser) {
		this.totalUser = totalUser;
	}

	public int getRecentEnroll() {
		return recentEnroll;
	}

	public void setRecentEnroll(int recentEnroll) {
		this.recentEnroll = recentEnroll;
	}

	public int getWithdraw() {
		return withdraw;
	}

	public void setWithdraw(int withdraw) {
		this.withdraw = withdraw;
	}

	public int getKickOut() {
		return kickOut;
	}

	public void setKickOut(int kickOut) {
		this.kickOut = kickOut;
	}

	@Override
	public String toString() {
		return "User [totalUser=" + totalUser + ", recentEnroll=" + recentEnroll + ", withdraw=" + withdraw
				+ ", kickOut=" + kickOut + "]";
	}
	
	
}
