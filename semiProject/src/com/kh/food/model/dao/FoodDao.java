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
import com.kh.food.model.vo.FoodCategory;

public class FoodDao {
	Properties prop = new Properties();

	public FoodDao() {
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
			while (rset.next()) {
				Board b = new Board(rset.getInt("BOARD_NO"), rset.getString("BOARD_TITLE"), rset.getString("FOOD_NAME"), // F_CATEGORY
																															// TABLE
						rset.getInt("GOOD"), rset.getDate("CREATE_DATE"), rset.getString("USERID") // BMEMBER TABLE
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

	public String pointCheck(int point) {

		String name = "";
		if (point > 9) {
			name = "자칭 요리사";
		} else if (point > 6) {
			name = "맛잘알";
		} else if (point > 3) {
			name = "소소한 입맛";
		} else if (point > 0) {
			name = "시민";
		} else {
			name = "먹이 사절";
		}
		return name;
	}

	public Board selectDetail(Connection conn, int bno) {
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
			if (rset.next()) {
				b = new Board(rset.getString("BOARD_TITLE"), rset.getString("BOARD_CONTENT"),
						rset.getString("FOOD_NAME"), rset.getInt("GOOD"), rset.getInt("BAD"), rset.getInt("REPORT"),
						rset.getDate("CREATE_DATE"), rset.getString("USERID"), rset.getString("ADDRESS"),
						rset.getInt("USERNO"));
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

	public int foodRankInsert(Connection conn, Board b, FoodCategory fc) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("BasicfoodRankInsert");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setInt(4, fc.getFoodCategory());
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

	public int UpdateBtn(Connection conn, String str, String bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			switch (str) {
			case "/goodbtn":
				sql = prop.getProperty("UpdateGood"); // 트리거 사용해서 board 업데이트 시 bmember point 추가
				break;
			case "/badbtn":
				sql = prop.getProperty("UpdateBad"); // 트리거 사용해서 board 업데이트 시 bmember point 감소
				break;
			case "/reportbtn":
				sql = prop.getProperty("UpdateReportB"); // 트리거 사용해서 board 업데이트 시 관리자 block_c 추가
				break;
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bno);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int deleteFoodRank(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteFoodRank");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}

		return result;
	}

	/***
	 * 
	 * @param conn
	 * @param b
	 * @return FoodCategory [Object] 2 on
	 */
	public FoodCategory UpdateFoodRankF(Connection conn, Board b) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("SelectNewFood");
		ResultSet rset = null;
		FoodCategory fc = null;
		try {
			// 1. 게시물 수정시 db에 없는 메뉴로 수정한 경우
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getFoodName());
			rset = pstmt.executeQuery();
			if (rset.next()) {
				// 이미 있는 메뉴라면
				fc = new FoodCategory();
				fc.setFoodCategory(rset.getInt(1));
				fc.setFoodName(rset.getString(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return fc;
	}

	/***
	 * 
	 * @param conn
	 * @param b
	 * @return int (UPDATE FOOD_BOARD SET FOOD_CATEGORY = SEQ_FCNO.CURRVAL, ADDRESS
	 *         = ? WHERE BOARD_NO = ?)
	 */
	public int UpdateFoodRankFB(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("NewUpdateFoodRank2");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getAbbress());
			pstmt.setInt(2, b.getBoardNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	/***
	 * 
	 * @param conn
	 * @param b
	 * @return int UPDATE BOARD SET BOARD_TITLE = ?, BOARD_CONTENT = ? WHERE
	 *         BOARD_NO = ?
	 */
	public int UpdateFoodRankB(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("NewUpdateFoodRank3");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getBoardTitle());
			pstmt.setString(2, b.getBoardContent());
			pstmt.setInt(3, b.getBoardNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public FoodCategory selectFoodCategory(Connection conn, String foodName) {
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("SelectNewFood");
		FoodCategory fc = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, foodName);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				fc = new FoodCategory();
				fc.setFoodCategory(rset.getInt("FOOD_CATEGORY"));
				fc.setFoodName(rset.getString("FOOD_NAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}

		return fc;
	}

	/***
	 * 
	 * @param conn
	 * @param food_name
	 * @return int (INSERT INTO F_CATEGORY VALUES (SEQ_FCNO.NEXTVAL, "FOOD_NAME")
	 */
	public int InsertNewFoodCate(Connection conn, String food_name) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("NewUpdateFoodRank1");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, food_name);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	/***
	 * 
	 * @param conn
	 * @param b
	 * @param fc
	 * @return
	 * @apiNote 이건말이죠..업데이트를 위한겁니다.
	 */
	public int UpdateFoodRankFB(Connection conn, Board b, FoodCategory fc) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("UpdateFoodRank2");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fc.getFoodCategory());
			pstmt.setString(2, b.getAbbress());
			pstmt.setInt(3, b.getBoardNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int insertBtncheck(Connection conn, String bno, int userno, String str) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBtncheck");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bno));
			pstmt.setInt(2, userno);
			if(str.equals("/goodbtn")) {
				str = "g";
			}else if(str.equals("/badbtn")) {
				str = "b";
			}else if(str.equals("/reportbtn")) {
				str = "r";
			}
			pstmt.setString(3, str);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// 복합키에 걸릴경우
			return -1;
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public ArrayList<Board> locationFood(Connection conn, String dong) {
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("locationFood");
		ArrayList<Board> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dong);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Board b = new Board();
				b.setAbbress(rset.getString("ADDRESS"));
				b.setFoodName(rset.getString("FOOD_NAME"));
				b.setBoardNo(rset.getInt("BOARD_NO"));
				b.setGood(rset.getInt("GOOD"));
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
				
		return list;
	}

}
