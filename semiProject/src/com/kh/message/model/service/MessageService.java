package com.kh.message.model.service;

import java.sql.Connection;

import com.kh.common.model.vo.JDBCTemplate;
import com.kh.message.model.dao.MessageDao;
import com.kh.message.model.vo.Message;
import com.kh.message.model.vo.MessageBlock;

public class MessageService {

	//유저 닉네임으로 유저 번호 찾기(메시지 보내기 위해)
	public int selectUserNo(String acceptNick) {
		Connection conn = JDBCTemplate.getConnection();
		
		
		int acceptUserNo = new MessageDao().selectUserNo(conn,acceptNick);
		
		JDBCTemplate.close(conn);
		
		return acceptUserNo;
		
	}
	
	//메시지(쪽지) 보내기(insert)
	public int insertMessage(Message msg) {
		Connection conn = JDBCTemplate.getConnection();
		
		
		
		int result = new MessageDao().insertMessage(conn,msg);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result;
	}

	//메시지 차단 등록
	public int insertBlock(MessageBlock mb) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MessageDao().inserBlock(conn,mb);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
				

		return result;
	}

	//메시지 차단 당한경우
	public String checkBlock(Message msg) {
		Connection conn = JDBCTemplate.getConnection();
		
		String block = new MessageDao().checkBlock(conn,msg);
		
		JDBCTemplate.close(conn);
		
		return block;
	}
	
}
