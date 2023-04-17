package com.kh.food.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.food.model.dao.FoodDao;

public class FoodService {

	public ArrayList<Board> selectFoodRanking() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> list = new FoodDao().selectFoodRanking(conn);
		JDBCTemplate.close(conn);
		return list;
	}

	public Board selectDetail(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		Board b = new FoodDao().selectDetail(conn, bno);
		return b;
	}

}
