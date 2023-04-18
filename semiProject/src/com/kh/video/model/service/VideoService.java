package com.kh.video.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.video.model.dao.VideoDao;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.video.model.dao.VideoDao;



public class VideoService {

	public int selectListCount() {
		Connection conn = JDBCTemplate.getConnection();
		
		int listCount = new VideoDao().selectListCount(conn);
		
		JDBCTemplate.close(conn);
		
		return listCount;
	}

	public ArrayList<Board> selectList(PageInfo pi) {

		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> list = new VideoDao().selectList(conn,pi);
		
		JDBCTemplate.close(conn);
		return list;
	}

}
