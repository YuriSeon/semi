package com.kh.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BamDao;
import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class BamService {

	//대나무숲 게시글 총갯수 구하는 메소드
	public int selectListCount() {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new BamDao().selectListCount(conn);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

	//현재 페이지 게시글들 조회
	public ArrayList<Board> selectList(PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BamDao().selectList(conn,pi);
		
		JDBCTemplate.close(conn);
		return list;
	}

	//대나무숲 카테고리 가져오기(일반,질문,연애등등)
	public ArrayList<BamCategory> categoryList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<BamCategory> list = new BamDao().categoryList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
}
