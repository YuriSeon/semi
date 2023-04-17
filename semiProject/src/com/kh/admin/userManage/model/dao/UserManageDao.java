package com.kh.admin.userManage.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.admin.userManage.model.vo.BlackList;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class UserManageDao {

	Properties prop = new Properties();
	
	public UserManageDao() {
		
		
		String filePath = UserManageDao.class.getResource("/admin/userManage-mapper.xml").getPath();
		
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
	
	
	public int listCount(Connection conn, String status) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset= null;
		
		String sql = prop.getProperty("listCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, status);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				result = rset.getInt("COUNT");
			} 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			
			JDBCTemplate.close(pstmt);
		}
		
		return result;
		
	}


	public ArrayList<BlackList> selectAllBlackList(Connection conn, PageInfo pi) {
		
		ArrayList<BlackList> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		int startRow = (pi.getCurrentPage() -1) *pi.getBoardLimit() +1;
		
		int endRow = startRow + pi.getBoardLimit() -1;
		
		String sql = prop.getProperty("selectAllList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				list.add(new BlackList(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getString("PHONE")
										, rset.getString("EMAIL")
										, rset.getString("SSN")
										, rset.getInt("BLOCK_C")
										, rset.getInt("DM_BLOCK_C")
										, rset.getInt("FALSE_BLOCK_C")
										, rset.getInt("FILTERING")
										,rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
		
	}

	public ArrayList<BlackList> selectList(Connection conn, PageInfo pi, String input, String option) {
		
		ArrayList<BlackList> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1)/pi.getBoardLimit() *pi.getBoardLimit() +1;
		
		int endRow = startRow + pi.getBoardLimit() -1;
		
		String sql = null;
		
		switch(option) {
		case "USERID" : sql = prop.getProperty("selectListID");  break;
		case "USERNAME" : sql = prop.getProperty("selectListNAME"); break;
		case "STATUS" : sql = prop.getProperty("selectListSTATUS"); break;
		}
		
		try {
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setInt(1,startRow);
			
			pstmt.setInt(2, endRow);
			
			pstmt.setString(3, input);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				list.add(new BlackList(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getString("PHONE")
										, rset.getString("EMAIL")
										, rset.getString("SSN")
										, rset.getInt("BLOCK_C")
										, rset.getInt("DM_BLOCK_C")
										, rset.getInt("FALSE_BLOCK_C")
										, rset.getInt("FILTERING")
										,rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

}
