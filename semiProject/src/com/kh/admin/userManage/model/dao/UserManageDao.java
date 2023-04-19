package com.kh.admin.userManage.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.admin.userManage.model.vo.BlackList;
import com.kh.admin.userManage.model.vo.UserManage;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.food.model.dao.FoodDao;

public class UserManageDao {

	Properties prop = new Properties();
	
	public UserManageDao() {
		
		
		String filePath = UserManageDao.class.getResource("/sql/admin/userManage-mapper.xml").getPath();
		
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
		
		case "id" : sql = prop.getProperty("selectListID"); break;
		
		case "name" : sql = prop.getProperty("selectListNAME"); break;
		
		case "status" : sql = prop.getProperty("selectListSTATUS"); 
		
						input= input.toUpperCase(); break;
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
	
	public ArrayList<Object> selectUserList(Connection conn, PageInfo pi) {
		
		ArrayList<Object> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1)/pi.getBoardLimit() *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() +1;
		
		String sql = prop.getProperty("selectUserList");
		
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				BMember b = new BMember(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getString("PHONE")
										, rset.getString("EMAIL")
										, rset.getString("SNAME"));
				
				//foodRank 구하는 메소드 이미 있어서 사용
				String foodRank = new FoodDao().pointCheck(rset.getInt("POINT"));
				
				UserManage um = new UserManage(rset.getInt("USERNO")
												, rset.getInt("REPLY_COUNT")
												, rset.getInt("BOARD_COUNT")
												, rset.getInt("VIDEO_COUNT")
												, foodRank);
				
				list.add(b);
				System.out.println(b);
				list.add(um);
				System.out.println(um);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		System.out.println(list);
		return list;
	}


	public ArrayList<Object> selectSortFR(Connection conn, PageInfo pi) {
		
		ArrayList<Object> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1)/pi.getBoardLimit() *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() +1;
		
		String sql = prop.getProperty("selectSortFR");
		
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				BMember b = new BMember(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getString("PHONE")
										, rset.getString("EMAIL")
										, rset.getString("SNAME"));
				
				//foodRank 구하는 메소드 이미 있어서 사용
				String foodRank = new FoodDao().pointCheck(rset.getInt("POINT"));
				
				UserManage um = new UserManage(rset.getInt("USERNO")
												, rset.getInt("REPLY_COUNT")
												, rset.getInt("BOARD_COUNT")
												, rset.getInt("VIDEO_COUNT")
												, foodRank);
				
				list.add(b);
				list.add(um);
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
	
	public ArrayList<Object> selectSortAct(Connection conn, PageInfo pi) {
		
		ArrayList<Object> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1)/pi.getBoardLimit() *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() +1;
		
		String sql = prop.getProperty("selectSortFR");
		
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				BMember b = new BMember(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getString("PHONE")
										, rset.getString("EMAIL")
										, rset.getString("SNAME"));
				
				//foodRank 구하는 메소드 이미 있어서 사용
				String foodRank = new FoodDao().pointCheck(rset.getInt("POINT"));
				
				UserManage um = new UserManage(rset.getInt("USERNO")
												, rset.getInt("REPLY_COUNT")
												, rset.getInt("BOARD_COUNT")
												, rset.getInt("VIDEO_COUNT")
												, foodRank);
				
				list.add(b);
				list.add(um);
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
