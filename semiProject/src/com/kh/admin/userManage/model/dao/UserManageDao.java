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
import java.util.Collections;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.admin.userManage.model.vo.BlackList;
import com.kh.admin.userManage.model.vo.User;
import com.kh.admin.userManage.model.vo.UserCondition;
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
		
		int startRow = (pi.getCurrentPage()-1) *pi.getBoardLimit() +1;
		
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
		
		int startRow = (pi.getCurrentPage()-1) *pi.getBoardLimit() +1;
		
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
	
	public ArrayList<User> selectUserList(Connection conn, PageInfo pi, String select) {
		
		ArrayList<User> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1)*pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() +1;
		
		String sql = null;
		
		switch(select) {
		case "recently" : sql = prop.getProperty("selectUserList"); break;
		
		case "foodRank" : sql = prop.getProperty("selectSortFR"); break;
		
		case "total" : sql = prop.getProperty("selectSortFR"); break;
		}
		
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


	public ArrayList<BMember> checkList(Connection conn, PageInfo pi, int option) {
		
		ArrayList<BMember> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1)*pi.getBoardLimit() +1;
		
		int endRow = startRow + pi.getBoardLimit() -1;
		
		String sql = null;
		switch(option) {
		
		case 1 : sql = prop.getProperty("checkListRecent"); break;
		
		case 2 : sql = prop.getProperty("checkListBlock"); break;
		
		case 3 : sql = prop.getProperty("checkListFiltering"); 
		
		}
		try {
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setInt(1,startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				list.add(new BMember(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getDate("CREATE_DATE")
										, rset.getDate("MODIFY_DATE")
										, rset.getInt("POINT")
										, rset.getInt("BLOCK")
										, rset.getInt("FILTERING")));
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




	public int ckCount(Connection conn, int select, String search) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset= null;
		
		String sql = null;

		switch(select) {
		
		case 1 : sql = prop.getProperty("ckCountId"); break;
			
		case 2 : sql = prop.getProperty("ckCountB"); break;
			
		case 3 : sql = prop.getProperty("ckCountF");
		
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, search);
			
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

	public ArrayList<BMember> checkSelectList(Connection conn, PageInfo pi, int select, String search) {
		
		ArrayList<BMember> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1) *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() +1;
		
		String sql = null;
		
		switch(select) {
		
		case 1 : sql = prop.getProperty("checkSelectId"); break;
		
		case 2 : sql = prop.getProperty("checkSelectB"); break;
		
		case 3 : sql = prop.getProperty("checkSelectF"); 
		
		}
		
		try {
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setInt(1,startRow);
			
			pstmt.setInt(2, endRow);
			
			pstmt.setString(3, search);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				list.add(new BMember(rset.getInt("USERNO")
						, rset.getString("USERID")
						, rset.getString("USERNAME")
						, rset.getDate("CREATE_DATE")
						, rset.getDate("MODIFY_DATE")
						, rset.getInt("POINT")
						, rset.getInt("BLOCK")
						, rset.getInt("FILTERING")));
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

	public int importantCount(Connection conn) {
		
		int result = 0;
		
		ResultSet rset = null;
		
		Statement stmt = null;
		
		String sql = prop.getProperty("importantCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				result = rset.getInt("COUNT");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return result;		
		
	}

	public ArrayList<User> importantList(Connection conn, PageInfo pi) {
		
		ArrayList<User> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage()-1) *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() +1;
		
		String sql = prop.getProperty("importantList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				BMember b = new BMember();
				b.setUserNo(rset.getInt("USERNO"));
				b.setUserId(rset.getString("USERID"));
				b.setUserName(rset.getString("USERNAME"));
				list.add(b);
				
				list.add(new UserCondition(rset.getInt("USERNO")
											, rset.getInt("BLOCK_C")
											, rset.getInt("DM_BLOCK_C")
											, rset.getInt("FALSE_BLOCK_C")
											, rset.getInt("YELLOW_CARD")
											, rset.getInt("BOARD_FILTERING")
											, rset.getInt("REPLY_FILTERING")
											, rset.getInt("TOTAL_B")
											, rset.getInt("TOTAL_F")));
				
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


	public int yellowCard(Connection conn, int userNo) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("yellowCard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}


	public User UserCount(Connection conn, String[] sArr) {
		
		User u = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("listCount");
		
		int[] iArr = new int[4];
		
		try {
			for(int i=0; i<sArr.length; i++) {
				
				if(i==1) {
					sql = prop.getProperty("recentUserCount");
				}
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, sArr[i]);
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					iArr[i] = rset.getInt("COUNT");
				}
			}
			
			u = new User(iArr[0], iArr[1], iArr[2], iArr[3]);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return u;
	}


	public int[] checkCount(Connection conn) {
		// 최근 신고 당한 회원, 경고수마다 회원수, 체크가 필요한 회원 수
		int[] result = new int[6];
		
		Statement stmt = null;
		
		ResultSet rset = null;
		
		String sql = null;
		
		try {
			for(int i=0; i<result.length; i++) {
				if(!(i==0 || i==5)) {
					result [i] = yellowCount(conn, i);
					continue;
				}
				switch(i) {
				case 0 : sql = prop.getProperty("checkCount"); break;
				case 5 : sql = prop.getProperty("importantCount");
				}
				stmt = conn.createStatement();
				
				rset = stmt.executeQuery(sql);
				
				if(rset.next()) {
					result[i]= rset.getInt("COUNT");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return result;
	}
	
	public int yellowCount(Connection conn, int i) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("yellowCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, i);
			
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


	public ArrayList<User> detailInfo(Connection conn, int userNo) {
		
		ArrayList<User> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("detailInfo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				list.add(new BMember(rset.getInt("USERNO")
										, rset.getString("USERID")
										, rset.getString("USERNAME")
										, rset.getString("PHONE")
										, rset.getString("ADDRESS")
										, rset.getString("EMAIL")
										, rset.getString("SSN")
										, rset.getDate("CREATE_DATE")
										, rset.getString("USER_NICK")
										, rset.getString("SNAME")
										, rset.getString("SCHOOL_ST")
										, rset.getInt("POINT")));
				
				list.add(new UserManage(rset.getInt("USERNO")
						, rset.getInt("REPLY_COUNT")
						, rset.getInt("BOARD_COUNT")
						, rset.getString("FOODBOARD_STATUS")));
				
				list.add(new UserCondition(rset.getInt("USERNO")
											, rset.getInt("BLOCK_C")
											, rset.getInt("DM_BLOCK_C")
											, rset.getInt("FALSE_BLOCK_C")
											, rset.getInt("YELLOW_CARD")
											, rset.getInt("BOARD_FILTERING")
											, rset.getInt("REPLY_FILTERING")));
				
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


	public ArrayList<BMember> mainSearchUser(Connection conn, String search) {
		
		ArrayList<BMember> list = new ArrayList<>();

		ResultSet rset = null;

		PreparedStatement pstmt = null;

		String sql = prop.getProperty("mainSearchUser");

		try {
			pstmt = conn.prepareStatement(sql);
			
			for(int i =0; i<5; i++) {
				pstmt.setString(i+1, search);
			}
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				BMember b = new BMember();
				
				b.setUserNo(rset.getInt("USERNO"));
				b.setUserId(rset.getString("USERID"));
				b.setUserName(rset.getString("USERNAME"));
				b.setEmail(rset.getString("EMAIL"));
				b.setSchoolNo(rset.getString("SNAME"));
				b.setUserNick(rset.getString("USER_NICK"));
				
				list.add(b);
			}
			System.out.println(list);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;	
	}


	public int updateUC(Connection conn, UserCondition uc) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateUC");
		
		try {
			pstmt = conn.prepareStatement(sql);
			 
			pstmt.setInt(1, uc.getBlockC());
			
			pstmt.setInt(2, uc.getDmBlockC());
			
			pstmt.setInt(3, uc.getFalseBlockC());
			
			pstmt.setInt(4, uc.getYellowCard());
			
			pstmt.setInt(5, uc.getBoardFiltering());
			
			pstmt.setInt(6, uc.getReplyFiltering());
			
			pstmt.setInt(7, uc.getUserNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}


	public int updateM(Connection conn, BMember b) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateM");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, b.getPoint());
			
			pstmt.setInt(2, b.getUserNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			JDBCTemplate.close(pstmt);
		}
		
		return result;
		
	}


	public int updateUM(Connection conn, UserManage um) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateUM");	
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, um.getFoodBStatus()); // 맛집 게시물 작성 상태값
			
			pstmt.setInt(2, um.getUserNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}


	public int deleteUser(Connection conn, int userNo) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteUser");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
}
