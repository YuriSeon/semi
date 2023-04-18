package com.kh.bMember.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.JDBCTemplate;

public class BMemberDao {
	
	private Properties prop = new Properties();
	
	public BMemberDao() {
		String filePath = BMemberDao.class.getResource("/sql/member/member-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (InvalidPropertiesFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public BMember loginMember(Connection conn, String userId, String userPwd) {
		
		BMember m = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("loginMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				m = new BMember(rset.getInt("USERNO")
								,rset.getString("USERID")
								,rset.getString("USERPWD")
								,rset.getString("USERNAME")
								,rset.getString("PHONE")
								,rset.getString("ADDRESS")
								,rset.getString("EMAIL")
								,rset.getString("SSN")
								,rset.getString("STATUS")
								,rset.getDate("CREATE_DATE")
								,rset.getDate("MODIFY_DATE")
								,rset.getString("USER_NICK")
								,rset.getString("SCHOOL_NO")
								,rset.getString("POWER")
								,rset.getString("SCHOOL_ST")
								,rset.getInt("POINT"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return m;
	}
	
	

}
