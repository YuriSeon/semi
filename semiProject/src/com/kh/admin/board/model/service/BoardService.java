package com.kh.admin.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.admin.board.model.dao.BoardDao;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class BoardService {
	
	public int boardListCount(int bType) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().boardListCount(conn, bType);
		
		JDBCTemplate.close(conn);
		
		return result;
		
	}
	
	// board main 페이지에 들어가면 가장 먼저 나올 공지사항 전체 조회
	public ArrayList<Board> boardSelectList(PageInfo pi, int bType) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().boardSelectList(conn, pi, bType);
		
		JDBCTemplate.close(conn);
		
		return list;
	
	}

	

}
