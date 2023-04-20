package com.kh.food.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.food.model.dao.FoodDao;
import com.kh.food.model.vo.FoodCategory;

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
	
	public FoodCategory selectFoodCategory(Connection conn, String foodName) {
		FoodCategory fc = new FoodDao().selectFoodCategory(conn, foodName);
		return fc;
		
	}

	public int foodRankInsert(Board b, String newFoodName) {
		Connection conn = JDBCTemplate.getConnection();
		int num = 0;
		FoodCategory fc = selectFoodCategory(conn, newFoodName);
		if(fc == null) {
			num = new FoodDao().foodRankInsert(conn, b, newFoodName); // 아예 새로운 음식			
		}else {
			num = new FoodDao().foodRankInsert(conn, b, fc);
		}
		
		if(num > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		return num;
	}

	public int UpdateBtn(String str, String bno, int userno) { // 중복 체크를 위한 userno
		Connection conn = JDBCTemplate.getConnection();
		int result = 0;
		int result2 = 0;
		int insertBtnCheck = new FoodDao().insertBtncheck(conn, bno, userno, str); // 버튼 누르면 일단 저장 > 만약 이미 있다면 -1을반환
		// 버튼 중복 체크. 금요일날 오전에 할일
//		if(insertBtnCheck > 0) {
			JDBCTemplate.commit(conn);
			
			result = new FoodDao().UpdateBtn(conn, str, bno);			
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
			if(result > 0) {
				JDBCTemplate.commit(conn);
			}else {
				JDBCTemplate.rollback(conn);
			}
//		} else {
			
//		}
		
		JDBCTemplate.close(conn);
		return result2;
	}

	public int deleteFoodRank(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		int result = new FoodDao().deleteFoodRank(conn, bno);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int UpdateFoodBoard(Board b) {
		Connection conn = JDBCTemplate.getConnection();
		int result1 = 0, result2 = 0, result3 = 0, result4 = 0;
		FoodCategory fc = new FoodDao().UpdateFoodRankF(conn, b); // select를 사용해서 진짜 새로운 음식 인지 확인
		
		if(fc == null) {
			result1 = new FoodDao().InsertNewFoodCate(conn, b.getFoodName()); // 새로운 음식이라면 추가
		}else {
			result4 = new FoodDao().UpdateFoodRankFB(conn, b, fc);
		}
		
		if(result1 > 0) {
			result2 = new FoodDao().UpdateFoodRankFB(conn, b); // food_board에 주소를 해당하는 board_no에서 수정한다.
		}
		if(result2 > 0 || result4 > 0) {				
			result3 = new FoodDao().UpdateFoodRankB(conn, b); // board에 제목 내용을 board_no에 맞게 수정한다.
		}
		if (result3 > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result3;
	}

}
