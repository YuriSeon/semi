package com.kh.admin.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.admin.board.model.dao.BoardDao;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;

public class BoardService {
	
	// board main 페이지에 들어가면 가장 먼저 나올 공지사항 전체 조회
	public ArrayList<Board> noticeSelectList() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().noticeSelectList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	
	}
	

}
