package com.kh.message.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.board.model.dao.BamDao;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.message.model.vo.Message;
import com.kh.message.model.vo.MessageBlock;

public class MessageDao {
	private Properties prop = new Properties();

	
	public MessageDao() {
		String filePath = BamDao.class.getResource("/sql/message/message-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//메시지 보내기위해 닉네임으로 유저번호 찾기
	public int selectUserNo(Connection conn, String acceptNick) {
		int acceptUserNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectUserNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, acceptNick);
			
			rset=pstmt.executeQuery();
			
			if(rset.next()) {
				acceptUserNo = rset.getInt("USERNO");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return acceptUserNo;
	}
	
	//메시지 보내기
	public int insertMessage(Connection conn, Message msg) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertMessage");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(msg.getUserWriter()));
			pstmt.setString(2,msg.getMsgContent());
			pstmt.setString(3, msg.getAcceptUser());
			
			result= pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//메시지 차단 등록
	public int inserBlock(Connection conn,MessageBlock mb) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertBlock");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mb.getUserNo());
			pstmt.setString(2, mb.getBlockUser());
			pstmt.setString(3, mb.getBlockContent());
			
			result = pstmt.executeUpdate();
			System.out.println(result);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//메시지 차단 확인
	public String checkBlock(Connection conn, Message msg) {
		String block = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("checkBlock");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, msg.getUserWriter());
			pstmt.setString(2, msg.getAcceptUser());
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				block=rset.getString("USERNO");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return block;
	}


}
