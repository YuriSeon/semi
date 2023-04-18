package com.kh.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BamDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
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

	//대나무숲 게시글 인서트(작성)
	public int insertBam(Board b, Attachment at) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().insertBam(conn,b);
		int result2=1;
		if(at!= null) {
			result2 = new BamDao().insertAttachment(conn,at);
		}
		if(result>0 && result2>0) {//작성성공
			JDBCTemplate.commit(conn);
			System.out.println("사진작성성공");
		}else {//작성실패
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result*result2;
	}
	
	//조회수 증가 메소드
	public int increaseCount(int boardNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().increaseCount(conn,boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//게시글 조회 메소드
	public Board selectBam(int boardNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new BamDao().selectBam(conn,boardNo);
		
		JDBCTemplate.close(conn);
		
		return b;
	}

	//첨부파일 조회 메소드
	public Attachment selectAttachment(int boardNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		Attachment at = new BamDao().selectAttachment(conn,boardNo);
		
		JDBCTemplate.close(conn);
		
		return at;
	}

	//게시글 삭제 메소드
	public int deleteBam(int boardNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().deleteBam(conn,boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		
		return result;
	}
	
}
