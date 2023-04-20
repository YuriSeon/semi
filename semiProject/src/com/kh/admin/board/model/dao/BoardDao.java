package com.kh.admin.board.model.dao;



import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class BoardDao {
	
	private Properties prop = new Properties();

	public BoardDao() {
		
		String filePath = BoardDao.class.getResource("/sql/admin/board-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public int boardListCount(Connection conn, int bType) {
		
		int result = 0;
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("boardListCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bType);
			
			rset = pstmt.executeQuery(sql);
			
			if(rset.next()) {
				result = rset.getInt("COUNT");
				System.out.println(result);
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
	// board main 페이지에 들어가면 나올 게시물 타입별 전체 조회
	public ArrayList<Board> boardSelectList(Connection conn, PageInfo pi, int bType) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage() -1) *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() -1;
	
		String sql = prop.getProperty("boardSelectList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bType);
			
			pstmt.setInt(2, startRow);
			
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Board b = new Board(rset.getInt("BOARD_NO")
						, rset.getString("USERNAME")
						, rset.getString("CATEGORY_TYPE")
						, rset.getString("BOARD_TITLE")
						, rset.getDate("CREATE_DATE")
						, rset.getDate("MODIFY_DATE")
						, rset.getInt("GOOD")
						, rset.getInt("COUNT"));
				list.add(b);
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

	public int insertNotice(Connection conn, Board b) {
		
		int result = 0;
		
		int no = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertNotice");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(b.getBoardWriter()));
			
			switch(b.getBoardType()) {
			case "video" : no = 1; break;
			case "bam" : no = 2; break;
			case "food" : no = 3; 
			
			}
			pstmt.setInt(2, no);
			
			pstmt.setString(3, b.getBoardTitle());
			
			pstmt.setString(4, b.getBoardContent());
			
			pstmt.setInt(5, b.getTypeNo());
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
		
	}

	public Board selectBoard(Connection conn, int bno) {
		
		Board b = null;
		
		int result =0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				b= new Board();
				
				b.setBoardNo(rset.getInt("BOARD_NO"));
				
				b.setBoardTitle(rset.getString("BOARD_TITLE"));
				
				b.setBoardContent(rset.getString("BOARD_CONTENT"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return b;
	}
	
	
	public int updateBoard(Connection conn, Board b) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("updateBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, b.getBoardTitle());
			
			pstmt.setString(2, b.getBoardContent());
			
			pstmt.setInt(3, b.getBoardNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int deleteBoard(Connection conn, int bno) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
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
