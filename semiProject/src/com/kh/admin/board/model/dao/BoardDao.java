package com.kh.admin.board.model.dao;



import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
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
	
	public int boardCount(Connection conn, int typeNo) {
		
		int result = 0;

		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("boardCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, typeNo);
			
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
	// board main 페이지에 들어가면 나올 게시물 타입별 전체 조회
	public ArrayList<Board> boardList(Connection conn, PageInfo pi, int typeNo) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage() -1) *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() -1;
	
		String sql = prop.getProperty("boardList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, typeNo);
			
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
						, rset.getInt("COUNT")
						, rset.getInt("TYPE_NO"));
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
	
	public int boardSelectCount(Connection conn, String searchContent, int category) {
		
		int result = 0;
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("boardSelectCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchContent);
			
			pstmt.setString(2, searchContent);
			
			pstmt.setInt(3, category);
			
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

	public ArrayList<Board> boardselectList(Connection conn, PageInfo pi, Board b) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		int startRow = (pi.getCurrentPage() -1) *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() -1;
	
		String sql = prop.getProperty("boardselectList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, b.getBoardContent());
			
			pstmt.setString(2, b.getBoardContent());
			
			pstmt.setString(3, b.getBoardType());
			
			pstmt.setInt(4, startRow);
			
			pstmt.setInt(5, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Board board = new Board(rset.getInt("BOARD_NO")
										, rset.getString("USERNAME")
										, rset.getString("CATEGORY_TYPE")
										, rset.getString("BOARD_TITLE")
										, rset.getDate("CREATE_DATE")
										, rset.getDate("MODIFY_DATE")
										, rset.getInt("GOOD")
										, rset.getInt("COUNT")
										, rset.getInt("TYPE_NO"));
				list.add(board);
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

	public Board detailBoard(Connection conn, int bno, String status) {
		
		Board b = null;
		
		int result =0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("detailBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, status);
			
			pstmt.setInt(2, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				b= new Board(rset.getInt("BOARD_NO")
						, rset.getString("USERID")
						, rset.getString("CATEGORY_TYPE")
						, rset.getString("BOARD_TITLE")
						, rset.getString("BOARD_CONTENT")
						, rset.getDate("CREATE_DATE")
						, rset.getInt("GOOD")
						, rset.getInt("BAD")
						, rset.getInt("REPORT")
						, rset.getInt("COUNT"));
				
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

	public int blurListCount(Connection conn) {
		
		int result = 0;

		ResultSet rset = null;
		
		Statement stmt = null;
		
		String sql = prop.getProperty("blurListCount");
		
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

	public ArrayList<Board> blurList(Connection conn, PageInfo pi) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		int result =0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		int startRow = (pi.getCurrentPage() -1) *pi.getBoardLimit() +1;
		
		int endRow = startRow +pi.getBoardLimit() -1;
		
		String sql = prop.getProperty("blurList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				list.add(new Board(rset.getInt("BOARD_NO")
									, rset.getString("USERID")
									, rset.getString("CATEGORY_TYPE")
									, rset.getString("BOARD_TITLE")
									, rset.getDate("CREATE_DATE")
									, rset.getInt("BAD")
									, rset.getInt("REPORT")
									, rset.getInt("COUNT")));
				
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

	public int[][] totalBoardCount(Connection conn) {
		// 전체 게시글수/ 최근 업로드 수/ 최근 신고 추가된 수/ 블러치리된 수 (게시글 종류에 따라서 하나씩 조회)
		int[][] result = new int[2][4];
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = null;
		
		try {
			for(int i=0; i<result.length; i++) {
				for(int j=0; j<result[i].length; j++) {
					switch(j) {
					case 0 : sql = prop.getProperty("boardTypeCount"); break;
					case 1 : sql = prop.getProperty("recentBoardCount"); break;
					case 2 : sql = prop.getProperty("reportCount"); break;
					case 3 : sql = prop.getProperty("bTypeBlurCount"); break;
					}
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, i+2);
					
					rset = pstmt.executeQuery();
					
					if(rset.next()) {
						result[i][j]= rset.getInt("COUNT");
					}
					
				}
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

	
}
