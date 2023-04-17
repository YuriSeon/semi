package com.kh.admin.userManage.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.admin.userManage.model.dao.UserManageDao;
import com.kh.admin.userManage.model.vo.BlackList;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class UserManageService {

	public int listCount(String status) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new UserManageDao().listCount(conn, status);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public ArrayList<BlackList> selectAllBlackList(PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<BlackList> list = new UserManageDao().selectAllBlackList(conn, pi);

		JDBCTemplate.close(conn);
		
		return list;
	}

	public ArrayList<BlackList> selectList(String input, String option, PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<BlackList> list = new UserManageDao().selectList(conn, pi, input, option);
		
		JDBCTemplate.close(conn);
		
		return list;
	
	}
	
	
	

}
