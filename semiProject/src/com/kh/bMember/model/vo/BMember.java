package com.kh.bMember.model.vo;

import java.sql.Date;


public class BMember {


	private int userNo;//		      USERNO NUMBER PRIMARY KEY,
	private String userId;//		      USERID VARCHAR2(20) NOT NULL UNIQUE,
	private String userPwd;//		      USERPWD VARCHAR2(100) NOT NULL,
	private String userName;//		      USERNAME VARCHAR2(50) NOT NULL,
	private String phone;//		      PHONE VARCHAR2(20),
	private String address;//		      ADDRESS VARCHAR2(1000),
	private String email;//		      EMAIL VARCHAR2(100),
	private String ssn;//		      SSN VARCHAR2(30) NOT NULL,
	private String status;//		      STATUS VARCHAR2(5) DEFAULT 'Y' NOT NULL,
	private Date createDate;//		      CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
	private Date modifyDate;//		      MODIFY_DATE DATE DEFAULT SYSDATE NOT NULL,
	private String userNick;//		      USER_NICK VARCHAR2(100) NOT NULL,
	private String schoolNo;//		      SCHOOL_NO NUMBER,
	private String power;//		      POWER VARCHAR2(20) DEFAULT 'N' NOT NULL,
	private String school_st;//		      SCHOOL_ST VARCHAR2(5) DEFAULT 'N',
	private int point;//		      POINT NUMBER NOT NULL,
	
	public BMember() {
		super();
	}
	
	public BMember(String userId, String userPwd, String userName, String phone, String address, String email,
			String ssn, String userNick, String schoolNo, String school_st) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.ssn = ssn;
		this.userNick = userNick;
		this.schoolNo = schoolNo;
		this.school_st ="N"; //학교 인증여부 기본값
	}
	

	 // 관리자 페이지에서 조회할때 필요해서 생성자 만들었습니다
	public BMember(int userNo, String userId, String userName, String phone, String email, String schoolNo) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.schoolNo = schoolNo;
	}


	public BMember(int userNo, String userId, String userPwd, String userName, String phone, String address,
			String email, String ssn, String status, Date createDate, Date modifyDate, String userNick, String schoolNo,
			String power, String school_st, int point) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.ssn = ssn;
		this.status = status;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.userNick = userNick;
		this.schoolNo = schoolNo;
		this.power = power;
		this.school_st = school_st;
		this.point = point;
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

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getUserNick() {
		return userNick;
	}

	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}

	public String getSchoolNo() {
		return schoolNo;
	}

	public void setSchoolNo(String schoolNo) {
		this.schoolNo = schoolNo;
	}

	public String getPower() {
		return power;
	}

	public void setPower(String power) {
		this.power = power;
	}

	public String getSchool_st() {
		return school_st;
	}

	public void setSchool_st(String school_st) {
		this.school_st = school_st;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	@Override
	public String toString() {
		return "Member [userNo=" + userNo + ", userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName
				+ ", phone=" + phone + ", address=" + address + ", email=" + email + ", ssn=" + ssn + ", status="
				+ status + ", createDate=" + createDate + ", modifyDate=" + modifyDate + ", userNick=" + userNick
				+ ", schoolNo=" + schoolNo + ", power=" + power + ", school_st=" + school_st + ", point=" + point
				+ "]";
	}
	
}
