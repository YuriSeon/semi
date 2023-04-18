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

}
