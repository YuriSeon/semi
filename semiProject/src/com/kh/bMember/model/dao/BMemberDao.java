package com.kh.bMember.model.dao;

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
import java.util.List;
import java.util.Properties;

import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.message.model.vo.Message;

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

	//로그인 메소드
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

	//아이디 확인 메소드
	public String idChk(Connection conn, String userName, String email) {
		String userId = null;
		ResultSet  rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("idChk");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, email);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				userId = rset.getString("USERID");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return userId;
	}

	//비밀번호 확인 메소드
	public String pwdChk(Connection conn, String userName, String userId) {
		String userPwd = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("pwdChk");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				userPwd = rset.getString("USERPWD");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}

		return userPwd;
	}

	//회원가입 메소드
	public int insertMember(Connection conn, BMember m) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getUserId());
			pstmt.setString(2, m.getUserPwd());
			pstmt.setString(3, m.getUserName());
			pstmt.setString(4, m.getPhone());
			pstmt.setString(5, m.getAddress());
			pstmt.setString(6, m.getEmail());
			pstmt.setString(7, m.getSsn());
			pstmt.setString(8, m.getUserNick());
			pstmt.setString(9, m.getSchoolNo());
			if(Integer.parseInt(m.getSchoolNo())>0) {
				pstmt.setString(10, "Y");
			}else {
				pstmt.setString(10, m.getSchool_st());
			}
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//아이디 중복체크 메소드
	public int checkId(Connection conn, String checkId) {

		int count = 0;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql =prop.getProperty("checkId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, checkId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				count = rset.getInt("COUNT");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return count;
	}

	//메세지 개수 구하는 메소드
	public int selectListCount(Connection conn, int userNo) {
		int listCount = 0;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt("COUNT");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
			JDBCTemplate.close(pstmt);
		}
		
		return listCount;
	}

	//메세지 확인 메소드
	public ArrayList<Message> selectList(Connection conn, PageInfo pi, int userNo) {
		ArrayList<Message> list = new ArrayList<>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow = (pi.getCurrentPage() -1)*pi.getBoardLimit()+1;
			int endRow = (startRow + pi.getBoardLimit())-1;
			
			pstmt.setInt(1, userNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Message(rset.getInt("MSG_NO")
									,rset.getString("USER_NICK")
									,rset.getString("MSG_CONTENT")
									,rset.getDate("MSG_SEND_DATE")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	//회원 탈퇴 메소드
	public int deleteMember(Connection conn, String userId, String userPwd) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	//회원정보 업데이트
	public int updateMember(Connection conn, BMember m) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getUserName());
			pstmt.setString(2, m.getPhone());
			pstmt.setString(3, m.getAddress());
			pstmt.setString(4, m.getEmail());
			pstmt.setString(5, m.getSsn());
			pstmt.setString(6, m.getUserNick());
			pstmt.setString(7, m.getSchoolNo());
			
			if(Integer.parseInt(m.getSchoolNo())>0) {
				pstmt.setString(8, "Y");
			}else {
				pstmt.setString(8, m.getSchool_st());
			}
			pstmt.setString(9, m.getUserId());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
		
	}

	//회원아이디로 조회 메소드
	public BMember selectMember(Connection conn, String userId) {

		BMember m = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
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

	public List<String> friendArr(Connection conn) {
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("friendArr");
		List<String> list = new ArrayList<>();
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				String userNick = rset.getString("USER_NICK");
				list.add(userNick);
			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	public String searchNick(Connection conn, String userNick) {
		String searchNick = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("searchNick");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userNick);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				searchNick = rset.getString("USER_NICK");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return searchNick;
	}

	
	

}
