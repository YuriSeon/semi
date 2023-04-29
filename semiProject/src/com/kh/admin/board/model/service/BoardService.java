package com.kh.admin.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.admin.board.model.dao.BoardDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Reply;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class BoardService {
	
	public int boardCount(int typeNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().boardCount(conn, typeNo);
		
		JDBCTemplate.close(conn);
		
		return result;
		
	}
	
	// board main 페이지에 들어가면 가장 먼저 나올 공지사항 전체 조회
	public ArrayList<Board> boardList(PageInfo pi, int typeNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().boardList(conn, pi, typeNo);
		
		JDBCTemplate.close(conn);
		
		return list;
	
	}

	public int insertNotice(Board b) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().insertNotice(conn, b);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int updateBoard(Board b) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().updateBoard(conn, b);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int deleteBoard(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().deleteBoard(conn, bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
		
	}
	

	public int boardSelectCount(String searchContent, int category) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().boardSelectCount(conn, searchContent, category);
		
		JDBCTemplate.close(conn);
		
		return result;
		
	}

	public ArrayList<Board> boardselectList(PageInfo pi, Board b) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().boardselectList(conn, pi, b);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public Board detailBoard(int bno, String status) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new BoardDao().detailBoard(conn, bno, status);
		
		JDBCTemplate.close(conn);
		
		return b;
	}
	
	public int blurListCount() {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().blurListCount(conn);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public ArrayList<Board> blurList(PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().blurList(conn, pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public int[][] totalBoardCount() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int[][] result = new BoardDao().totalBoardCount(conn);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public ArrayList<Board> mainSearchBoard(String search) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().mainSearchBoard(conn, search);
		
		JDBCTemplate.close(conn);
		
		return list;
		
	}

	public Attachment selectAttachment(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Attachment a = new BoardDao().selectAttachment(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return a;
	}

	public ArrayList<Reply> selectReply(int bno) {

		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Reply> list = new BoardDao().selectReply(conn, bno);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public int deleteReply(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = 0;
		
		ArrayList<Reply> list = new BoardDao().selectReply(conn, bno);
		
		if(!list.isEmpty()) {
			result = new BoardDao().deleteReply(conn, bno);
			if(result>0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		} else {
			result = 1; // 리스트가 비어있다면 댓글이 없다는거라서 controller에서 성공여부 판단하기 위해서 값을 1 넣어줌
		}
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int blurActive(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().blurActive(conn, bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public ArrayList<Board> boardTypeList(PageInfo pi, int bType) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().boardTypeList(conn, pi, bType);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public int boardTypeCount(int bType) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().boardTypeCount(conn, bType);
		
		JDBCTemplate.close(conn);
		
		return result;
		
	}

	

}
