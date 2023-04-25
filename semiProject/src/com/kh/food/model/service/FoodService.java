package com.kh.food.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.food.model.dao.FoodDao;
import com.kh.food.model.vo.FoodBtnCheck;
import com.kh.food.model.vo.FoodCategory;
import com.kh.food.model.vo.FoodTogether;

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

	public int foodRankInsert(Board b, String newFoodName, Attachment att) {
		Connection conn = JDBCTemplate.getConnection();
		int num = 0;
		FoodCategory fc = selectFoodCategory(conn, newFoodName);
		
		// 여긴 음식 카테고리가 새로운 음식인지 기존 음식인지 보고 Board, Food_Board, F_category에 INSERT해주는  곳
		if(fc == null) {
			num = new FoodDao().foodRankInsert(conn, b, newFoodName, att); // 아예 새로운 음식			
		}else {
			num = new FoodDao().foodRankInsert(conn, b, fc, att);
		}
		
		
		// 만약 Board, Food_Board, F_category에 INSERT가 완료되었을때 실행되는 구문
		if(num > 0) {
			// 우선 COMMIT
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

//	public ArrayList<Attachment> selectAttachment(int bno) {
//		Connection conn = JDBCTemplate.getConnection();
//		ArrayList<Attachment> attList = new FoodDao().selectAttachment(conn, bno);
//		
//		JDBCTemplate.close(conn);
//		return attList;
//	}

	public Attachment selectFoodImg(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		Attachment att = new FoodDao().selectAttachmentDetail(conn, bno);
		
		JDBCTemplate.close(conn);
		return att;
	}

	public ArrayList<Attachment> selectLocationFoodImg(ArrayList<Integer> locationBoard_no) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Attachment> list = new FoodDao().selectLocationFoodImg(conn, locationBoard_no);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

	public int foodUpdateImg(int bno, Attachment att) {
		Connection conn = JDBCTemplate.getConnection();
		int result = new FoodDao().foodUpdateImg(conn, bno, att);
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		return result;
	}

	public int deleteFoodImg(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		int result = new FoodDao().deleteFoodImg(conn, bno);
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	/***
	 * 
	 * @return int
	 * @apiNote Board와 Attachment 두개를 INSERT ALL로 저장
	 */
	public int foodToInsert(Board b,FoodTogether ft, Attachment att  ) {
		Connection conn = JDBCTemplate.getConnection();
		int result = new FoodDao().foodToInsert(conn, b, att, ft);
		if(result < 0) {
			JDBCTemplate.rollback(conn);
			return result;
		}
		JDBCTemplate.commit(conn);
		return result;
	}

	public ArrayList<HashMap<String, String>> selectFoodTogether() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<HashMap<String, String>> list = new FoodDao().selectFoodTogether(conn);
		JDBCTemplate.close(conn);
		return list;
	}
}
