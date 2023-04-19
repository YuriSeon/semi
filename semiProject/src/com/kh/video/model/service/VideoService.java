package com.kh.video.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.video.model.dao.VideoDao;
import com.kh.video.model.vo.Video;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;
import com.kh.video.model.dao.VideoDao;



public class VideoService {

	//총 게시글 개수 메소드
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



	public int insertPhotoVideo(Board b, ArrayList<Video> list) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result1 = new VideoDao().insertPhotoBoard(conn,b);
		
		int result2 = new VideoDao().insertVideoList(conn,list);
		
		return 0;
	}
}