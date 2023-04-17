package com.kh.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class BamDao {
	Properties prop = new Properties();
	
	public BamDao() {
		String filePath = BamDao.class.getResource("/sql/bam/bam-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//대나무숲 게시글 총 갯수 세는 메소드
	public int selectListCount(Connection conn) {
		int count = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListCount");
		
		try {
			stmt = conn.createStatement();
			
			rset=stmt.executeQuery(sql);
			
			if(rset.next()) {
				count = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}

		return count;
	}

	//현재 페이지 게시글들 조회
	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			//현재페이지 조회해야할 게시글 번호 변수
			//현재 페이지에서 가장 낮은 게시글번호
			int startRow = (pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			//현재 페이지에서 가장 높은 게시글 번호
			int endRow = (startRow+pi.getBoardLimit()) - 1;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO")
								,rset.getString("USERNO")
								,rset.getString("BAM_CATEGORY_NAME")
								,rset.getString("BOARD_TITLE")
								,rset.getString("BOARD_CONTENT")
								,rset.getDate("CREATE_DATE")
								,rset.getInt("GOOD")
								,rset.getInt("COUNT")));
			}
			for(Board b : list) {
				System.out.println(b.getBoardNo());
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
	
}
