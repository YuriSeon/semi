package com.kh.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BamDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.BtnCheck;
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
	public int insertBam(Board b, Attachment at,int count) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().insertBam(conn,b);
		if(result>0&&count>0) {//게시글 인서트가 되었고 욕설 필터링이 되었다면
			result = new BamDao().updateBadBoard(conn, b.getBoardWriter());
		}
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
	public int insertNoticeBam(Board b, Attachment at,int count) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().insertNoticeBam(conn,b);
		if(result>0&&count>0) {//게시글 인서트가 되었고 욕설 필터링이 되었다면
			result = new BamDao().updateBadBoard(conn, b.getBoardWriter());
		}
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
	public int updateBam(Board b, Attachment at,int count) {
		Connection conn = JDBCTemplate.getConnection();
		//게시글 수정
		int result = new BamDao().updateBam(conn,b);
		
		if(result>0&&count>0) {//게시글 수정이 되었고 욕설 필터링이 되었다면
			result = new BamDao().updateBadBoard(conn, b.getBoardWriter());
		}
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
		}
		
		JDBCTemplate.close(conn);
		
		
		return result*result2*result3;
	}

	//댓글 작성(인서트)
	public int insertReply(Reply r,int tno,int count) {
		Connection conn = JDBCTemplate.getConnection();
		int result = new BamDao().insertReply(conn,r);
		
		if(result>0&&tno!=1) {//댓글이 작성되었고 공지사항이 아니라면 게시글 댓글수 증가
			result = new BamDao().increaseReplyCount(conn, r.getBoardNo());
		}
		if(result>0&&count>0) {//댓글수가 증가 되었고 욕설 필터링이 되었다면
			result = new BamDao().updateBadReply(conn, r.getReplyWriter());
		}
		
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
	public int reportBam(int boardNo,int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		//중복방지 테이블 조회
		BtnCheck bc = new BamDao().selectBtnCheck(conn,boardNo,userNo);
		
		int result = 0;
		if(bc ==null) {//중복방지 테이블에 추천,신고 아무것도 없을때
			result = new BamDao().reportBam(conn,boardNo); //게시글 신고수 증가
			if(result>0) {
				result = new BamDao().reportInsertBam(conn,boardNo,userNo); //중복방지테이블에 인서트
			}
		}else if(!bc.getBtncheck().contains("신고")) {//중복방지 테이블에 추천만 했을때
			result = new BamDao().reportBam(conn, boardNo); //게시글 신고수 증가
			if(result>0) {
				result = new BamDao().updateReportBtnCheck(conn,boardNo,userNo); //중복방지테이블에 신고업데이트
			}
		}
		
		if(result>0) {//신고가 중복도 아니고 게시글 신고수 업데이트 성공
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//댓글 삭제 메소드
	public int deleteReply(int replyNo,int boardNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BamDao().deleteReply(conn,replyNo);
		
		if(result>0) {
			result = new BamDao().decreaseReplyCount(conn,boardNo);
		}
		
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
	//제목으로 검색결과 게시글 수
	public int searchTitleCount( String keyword) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new BamDao().searchTitleCount(conn,keyword);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

	//검색(제목) 게시글 조회
	public ArrayList<Board> searchTitleList(String keyword,PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BamDao().searchTitleList(conn,keyword,pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//내용으로 검색 게시글 수
	public int searchContentCount(String keyword) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new BamDao().searchContentCount(conn,keyword);
		
		JDBCTemplate.close(conn);
		
		return count;
	}
	//검색(내용) 게시글 조회
	public ArrayList<Board> searchContentList(String keyword,PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BamDao().searchContentList(conn,keyword,pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
	//중복방지 테이블 조회
	public BtnCheck selectBtnCheck(int boardNo, int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		BtnCheck bc = new BamDao().selectBtnCheck(conn,boardNo,userNo);
		
		JDBCTemplate.close(conn);
		
		return bc;
		
	}

	//추천 버튼 눌럿을때
	public int goodBtn(int boardNo, int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		//중복방지 테이블 조회
		BtnCheck bc = new BamDao().selectBtnCheck(conn,boardNo,userNo);
		
		int result = 0;
		
		if(bc ==null) {//추천,신고 둘다 없을때
			result = new BamDao().updateBamGood(conn,boardNo); //게시글 추천수 올림
			if(result>0) {
				result = new BamDao().insertBamGood(conn,boardNo,userNo); //중복방지 테이블에 인서트
			}
			
		}else if(bc.getBtncheck().equals("추천")) {//추천만 했었을때(추천 취소)
			result = new BamDao().cancelBamGood(conn,boardNo); //게시글에 추천수 감소시킴
			if(result>0) {
				result = new BamDao().deleteBtnCheck(conn,boardNo,userNo); //중복방지 테이블에서 삭제
			}
		}else if(bc.getBtncheck().contains("추천")) {//이미 추천과신고 했을때
			result = new BamDao().cancelBamGood(conn,boardNo);//게시글 추천수 감소
			if(result>0) {
				result = new BamDao().deleteGoodBtnCheck(conn,boardNo,userNo); //BTNTYPE에서 추천만 삭제
			}
		}else {//신고만 했었을때
			result = new BamDao().updateBamGood(conn,boardNo); //게시글 추천수 올림
			if(result>0) {
				result = new BamDao().updateGoodBtnCheck(conn,boardNo,userNo); //BTNTYPE에 추천 추가
			}
		}
		
		if(result>0) {//추천 성공
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//댓글 작성자번호 조회
	public Reply selectReply(int replyNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		Reply r = new BamDao().selectReply(conn,replyNo);
		
		JDBCTemplate.close(conn);
		
		return r;
	}

	



	
}
