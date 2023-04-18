package com.kh.food.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;

public class FoodDao {
	Properties prop = new Properties();
	public FoodDao(){
		String filePath = FoodDao.class.getResource("/sql/food/food-mapper.xml").getPath();
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (InvalidPropertiesFormatException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Board> selectFoodRanking(Connection conn) {
		ResultSet rset = null;
		Statement stmt = null;
		String sql = prop.getProperty("selectFoodRanking");
		ArrayList<Board> list = new ArrayList<>();
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while(rset.next()) {
				Board b = new Board(
							rset.getInt("BOARD_NO"),
							rset.getString("BOARD_TITLE"),
							rset.getString("FOOD_NAME"), // F_CATEGORY TABLE
							rset.getInt("GOOD"),
							rset.getDate("CREATE_DATE"),
							rset.getString("USERID") // BMEMBER TABLE
						);
				// 맛 등급
				b.setPointName(pointCheck(rset.getInt("POINT")));
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return list;
	}
	
	private String pointCheck(int point) {
		String name = "";
		if(point > 9) {
			name = "자칭 요리사";
		}else if(point > 6) {
			name = "맛잘알";
		}else if(point > 3) {
			name = "소소한 입맛";
		}else if(point > 0) {
			name = "시민";
		}else {
			name = "먹이 사절";
		}
		return name;
	}

	public Board selectDetail(Connection conn, int bno) {
		System.out.println("bno = " + bno);
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectDetail");
		Board b = null;
		
		// selectDetail
//		SELECT B.BOARD_TITLE, B.BOARD_CONTENT FC.FOOD_NAME, B.GOOD, B.BAD, B.REPORT, B.CREATE_DATE, M.USERID, M.POINT, FB.ADDRESS
//		FROM BOARD B
//		JOIN BMEMBER M USING (USERNO)
//		JOIN CATEGORY C ON (B.BOARD_TYPE = C.CATEGORY_NO)
//		JOIN FOOD_BOARD FB USING (BOARD_NO)	
//		JOIN F_CATEGORY FC ON (FC.FOOD_CATEGORY = fb.food_category)
//		WHERE c.category_no = 3
//		AND FB.DETAIL_TYPE = 1
//		AND B.STATUS = 'Y'
//		AND B.BOARD_NO = ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				b = new Board(
							rset.getString("BOARD_TITLE"),
							rset.getString("BOARD_CONTENT"),
							rset.getString("FOOD_NAME"),
							rset.getInt("GOOD"),
							rset.getInt("BAD"),
							rset.getInt("REPORT"),
							rset.getDate("CREATE_DATE"),
							rset.getString("USERID"),
							rset.getString("ADDRESS"),
							rset.getInt("USERNO")
						);
				b.setPointName(pointCheck(rset.getInt("POINT")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return b;
	}

	public int foodRankInsert(Connection conn, Board b, String newFoodName) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("newfoodRankInsert");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setString(4, b.getAbbress());
			pstmt.setString(5, newFoodName);
			
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int foodRankInsert(Connection conn, Board b, int foodCategoryNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("BasicfoodRankInsert");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setInt(4, foodCategoryNo);			
			pstmt.setString(5, b.getAbbress());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}


	public int UpdateBtn(Connection conn, String str, String bno, int userNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		try{
			switch(str) {
			case "/goodbtn" :
				sql = prop.getProperty("UpdateGood");
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bno);
				break;
			case "/badbtn" :
				sql = prop.getProperty("UpdateBad");
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bno);
				break;
			case "/reportbtn" :
				String[] sqlArr = {"UpdateReport", "UpdateReportB"};
				for(int i = 0; i < 2; i++) {					
					sql = prop.getProperty(sqlArr[i]); // 관리자꺼 업데이트
					pstmt = conn.prepareStatement(sql);
					if(i == 0) {
						pstmt.setInt(1, userNo);
						result = pstmt.executeUpdate();
						if(result < 0) {
							return -1;
						}
					}else {
						pstmt.setString(1, bno);
					}
				}
				break;
			}
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

}
