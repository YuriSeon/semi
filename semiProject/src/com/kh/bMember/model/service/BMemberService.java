package com.kh.bMember.model.service;

import java.sql.Connection;

import com.kh.bMember.model.dao.BMemberDao;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.JDBCTemplate;

public class BMemberService {

	public BMember loginMember(String userId, String userPwd) {

		Connection conn = JDBCTemplate.getConnection();
		
		BMember m = new BMemberDao().loginMember(conn,userId,userPwd);
		
		JDBCTemplate.close(conn);
		
		return m;
		
	}

	public String idChk(String userName, String email) {
		Connection conn = JDBCTemplate.getConnection();
		
		String userId = new BMemberDao().idChk(conn,userName,email);
		
		JDBCTemplate.close(conn);
		
		return userId;
	}

	public String pwdChk(String userName, String userId) {
		Connection conn = JDBCTemplate.getConnection();
		
		String userPwd = new BMemberDao().pwdChk(conn,userName,userId);
		
		JDBCTemplate.close(conn);
		
		return userPwd;
	}

	public int insertMemer(BMember m) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BMemberDao().insertMember(conn,m);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		return result;
	}

	public int checkId(String checkId) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new BMemberDao().checkId(conn, checkId);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

}
