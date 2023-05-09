package com.kh.bMember.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.kh.bMember.model.dao.BMemberDao;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.message.model.vo.Message;

public class BMemberService {

	//로그인 메소드
	public BMember loginMember(String userId, String userPwd) {

		Connection conn = JDBCTemplate.getConnection();
		
		System.out.println(userId);
		System.out.println(userPwd);
		BMember m = new BMemberDao().loginMember(conn,userId,userPwd);
		JDBCTemplate.close(conn);
		
		return m;
		
	}

	//아이디 찾아보는 메소드
	public String idChk(String userName, String email) {
		Connection conn = JDBCTemplate.getConnection();
		
		String userId = new BMemberDao().idChk(conn,userName,email);
		
		JDBCTemplate.close(conn);
		
		return userId;
	}

	//비밀번호 챶아보는 메소드
	public String pwdChk(String userName, String userId) {
		Connection conn = JDBCTemplate.getConnection();
		
		String userPwd = new BMemberDao().pwdChk(conn,userName,userId);
		
		JDBCTemplate.close(conn);
		
		return userPwd;
	}

	//회원가입 메소드
	public int insertMemer(BMember m) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BMemberDao().insertMember(conn,m);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		return result;
	}

	//아이디 중복체크 메소드
	public int checkId(String checkId) {
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new BMemberDao().checkId(conn, checkId);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

	//게시글 갯수 메소드
	public int selectListCount(int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int listCount = new BMemberDao().selectListCount(conn,userNo);
		
		JDBCTemplate.close(conn);
		
		return listCount;
	}

	//마이페이지 쪽지 확인 메소드
	public ArrayList<Message> selectList(PageInfo pi, int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Message> list = new BMemberDao().selectList(conn,pi,userNo);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	//회원 탈퇴 메소드
	public int deleteMember(String userId, String userPwd) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BMemberDao().deleteMember(conn,userId,userPwd);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		return result;
	}

	//업데이트 메소드
	public BMember updateMember(BMember m) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BMemberDao().updateMember(conn,m);

		BMember updateMem = null;
		
		if(result>0) {
			JDBCTemplate.commit(conn);
			updateMem = new BMemberDao().selectMember(conn,m.getUserId());
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return updateMem;
	}



	//친구 목록 메소드

	public List<String> friendArr() {
		Connection conn = JDBCTemplate.getConnection();
		
		List<String> list = new BMemberDao().friendArr(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}


	public String searchNick(String userNick) {
		Connection conn = JDBCTemplate.getConnection();
		
		String searchNick = new BMemberDao().searchNick(conn,userNick);
		
		JDBCTemplate.close(conn);
		
		return searchNick;
	}

}
