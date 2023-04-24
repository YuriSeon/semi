package com.kh.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BamDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Reply;
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
			
		}else {//작성실패
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result*result2;
	}
	
	//공지사항 작성(인서트)
	public int insertNoticeBam(Board b, Attachment at) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().insertNoticeBam(conn,b);
		int result2=1;
		if(at!= null) {
			result2 = new BamDao().insertAttachment(conn,at);
		}
		if(result>0 && result2>0) {//작성성공
			JDBCTemplate.commit(conn);
			
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

	//대나무숲 게시글 수정
	public int updateBam(Board b, Attachment at) {
		Connection conn = JDBCTemplate.getConnection();
		//게시글 수정
		int result = new BamDao().updateBam(conn,b);
		
		//대나무숲 카테고리 수정
		int result2 = new BamDao().updateCategory(conn,b);
		
		int result3 = 1;
		if(at != null) {//새로운 첨부파일이 있을 경우
			
			if(at.getFileNo()!=0) {//기존의 첨부파일이 있었을 경우
				
				result3 = new BamDao().updateAttachment(conn,at);
			}else {//기존의 첨부파일이 있었을 경우
				
				result3 = new BamDao().newInsertAttachment(conn,at);
			}
		}
		
		if(result>0&&result2>0&&result3>0) {
			JDBCTemplate.commit(conn);
		
		}else {
			JDBCTemplate.rollback(conn);
			System.out.println("롤백함 ㅠㅠ");
		}
		
		JDBCTemplate.close(conn);
		
		
		return result*result2*result3;
	}

	//댓글 작성(인서트)
	public int insertReply(Reply r) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().insertReply(conn,r);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result;
	}

	//게시글 댓글 리스트 불러오기
	public ArrayList<Reply> selectReplyList(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Reply> rlist = new BamDao().selectReplyList(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return rlist;
	}

	//게시글 신고하기
	public int reportBam(int boardNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().reportBam(conn,boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//댓글 삭제 메소드
	public int deleteReply(int replyNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().deleteReply(conn,replyNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
				
		return result;
	}

	//공지사항 리스트 가져오기
	public ArrayList<Board> selectNoticeList() {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> nlist = new BamDao().selectNoticeList(conn);
		
		JDBCTemplate.close(conn);
		
		return nlist;
	}

	
}
