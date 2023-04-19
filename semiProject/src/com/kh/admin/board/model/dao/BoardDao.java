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

	//조회수 증가 메소드
	public int increaseCount(Connection conn, int boardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("increaseCount");
		
		return 0;
	}
	
	
	

}
