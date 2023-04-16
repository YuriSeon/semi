package com.kh.admin.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Board;

public class BoardDao {
	
	Properties prop = new Properties();

	public BoardDao() {
		
		
		String filePath = BoardDao.class.getResource("/sql/board/admin-board-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	// board main 페이지에 들어가면 가장 먼저 나올 공지사항 전체 조회
	public ArrayList<Board> noticeSelectList(Connection conn) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		
		Statement stmt = null;
		
		String sql = prop.getProperty("noticeSelectList");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Board());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	

}
