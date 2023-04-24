package com.kh.food.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.food.model.dao.FoodDao;
import com.kh.food.model.vo.FoodBtnCheck;
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
		if(str.equals("/goodbtn")) {
			str = "GOOD";
		}else if (str.equals("/badbtn")) {
			str = "BAD";
		}else {
			str = "REPORT";
		}
		FoodBtnCheck fbc = new FoodDao().SelectBtncheck(conn, bno, userno);
		
		if(fbc == null) { // 없다면
			result = new FoodDao().insertBtnCheck(conn, bno, userno, str);
			if(result > 0) { // 추가
				result = new FoodDao().UpdatePlusButton(conn, str, bno); 
			}
		}else if(fbc.getBtnStyle().equals(str)) { // 이미 버튼이 눌렸는데 그게 같은 버튼일 경우
			result = new FoodDao().deleteBtnCheck(conn, bno, userno);
			if(result > 0) { // 삭제
				result = new FoodDao().UpdateMiusButton(conn, str, bno);
			}
		}else {
			// 이미 있는데 다른 버튼 클릭 했을때 이거 해야한다!!!!!!!!!!!!!!!!!!!!!!!!!!!
			/*
			 * 추천 수 비추천 수 감소 했을때 트리거로 포인트 변경 하는 거 만들기
			 * report 취소시 userCondition block_c 감소 트리거 만들기
			 * 
			 * */
			result = new FoodDao().UpdatePlusButton(conn, str, bno);
			if(result > 0) {
				result = new FoodDao().updateBtncheck(conn, str, userno, bno);
				result = new FoodDao().UpdateMiusButton(conn, fbc.getBtnStyle(), bno);
			}
		}
		if(result > 0) {			
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		/*
		 * 1. selectbtnCheck로 btncheck테이블에 자료가 있는지 확인한다.
		 * 2. 없다면 누른 버튼을 board테이블에서  +1 update 해준다. -- 트리거로 인해 포인트 변화
		 * 3. 똑같은 버튼을 눌렀다면 btncheck테이블에서 delete해준다.
		 * 3-1. board테이블에서 -1 update 해준다. -- 트리거 만들어서 포인트 차감
		 * 4. 있는데 다른 버튼을 클릭 했다면
		 * 4-1. board테이블에서 기존에 있는 버튼 -1해준다.
		 * 4-2. board테이블에서 이번에 클릭한 버튼을 +1 해준다. -- 트리거로 인해 포인트 변화
		 */ 
		
		return result;
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

	public ArrayList<Board> locationFood(String dong) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> list = new FoodDao().locationFood(conn, dong);
		JDBCTemplate.close(conn);
		return list;
	}

	public FoodBtnCheck useBtn(int bno, int userNo) {
		Connection conn = JDBCTemplate.getConnection();
		FoodBtnCheck fbc = new FoodDao().selectUserBtn(conn, bno, userNo);
		JDBCTemplate.close(conn);
		return fbc;
	}

}
