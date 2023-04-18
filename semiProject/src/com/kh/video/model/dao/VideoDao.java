package com.kh.video.model.dao;

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

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.video.model.vo.Video;



public class VideoDao {
	
	private Properties prop = new Properties();
	
	public VideoDao() {
		
		String filePath = VideoDao.class.getResource("/sql/video/video-mapper.xml").getPath();
	
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
	//총 게시글 개수 구하는 메소드
	public int selectListCount(Connection conn) {
		
		int listCount = 0;
		ResultSet rset =null;
		Statement stmt = null;
		
		String sql = prop.getProperty("selectListCount");
		
		try {
			stmt=conn.createStatement();
			
			rset =stmt.executeQuery(sql);
			
			if(rset.next()) {
				listCount = rset.getInt("COUNT");
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return listCount;
	}
	
	//게시글 리스트 조회
	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {

		ArrayList<Board> list = new ArrayList<>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			pstmt= conn.prepareStatement(sql);
		
			int startRow =(pi.getCurrentPage()-1) * pi.getBoardLimit()+1;
			int endRow =(startRow + pi.getBoardLimit()) -1;
			
			pstmt.setInt(1,startRow);
			pstmt.setInt(2,endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO")   
						  ,rset.getString("BOARD_WRITER")
						  ,rset.getString("BOARD_TYPE")
						  ,rset.getString("BOARD_TITLE")
						  ,rset.getDate("CREATE_DATE")
						  ,rset.getInt("COUNT")));
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
	
	//게시글 내용 
	public int insertPhotoBoard(Connection conn, Board b) {
		
		return 0;
	}
	//비디오 리스트 
	public int insertVideoList(Connection conn, ArrayList<Video> list) {

		return 0;
	}
}