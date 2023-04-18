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

	public int foodRankInsert(Board b, String foodCategoryNo, String newFoodName) {
		Connection conn = JDBCTemplate.getConnection();
		int num = 0;
		if(foodCategoryNo.equals("0")) {
			num = new FoodDao().foodRankInsert(conn, b, newFoodName);
		}else {
			num = new FoodDao().foodRankInsert(conn, b, Integer.parseInt(foodCategoryNo));
		}
		
		if(num > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		return num;
	}

	public int UpdateBtn(String str, String bno) {
		Connection conn = JDBCTemplate.getConnection();
		int userNo = selectDetail(Integer.parseInt(bno)).getUn();
		int result = new FoodDao().UpdateBtn(conn, str, bno, userNo);
		int result2 = 0;
		switch(str){
		case "/goodbtn":
			result2 = selectDetail(Integer.parseInt(bno)).getGood(); // 현재 추천수
			break;
		case "/badbtn":
			result2 = selectDetail(Integer.parseInt(bno)).getBad(); // 현재 비추천수
			break;
		case "/reportbtn":
			result2 = selectDetail(Integer.parseInt(bno)).getReport(); // 현재 신고수
			break;
		}
		if(result == -1) {
			System.out.println("User_Condition update error");
		}
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		return result2;
	}

}
