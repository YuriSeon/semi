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
import java.util.HashMap;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.food.model.vo.FoodBtnCheck;
import com.kh.food.model.vo.FoodCategory;
import com.kh.food.model.vo.FoodTogether;

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

	public int foodRankInsert(Connection conn, Board b, String newFoodName, Attachment att) {
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
				pstmt.setString(6, att.getOriginName());
				pstmt.setString(7, att.getChangeName());
				pstmt.setString(8, att.getFilePath());
				result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int foodRankInsert(Connection conn, Board b, FoodCategory fc, Attachment att) {
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
			pstmt.setString(6, att.getOriginName());
			pstmt.setString(7, att.getChangeName());
			pstmt.setString(8, att.getFilePath());

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

	public FoodBtnCheck SelectBtncheck(Connection conn, String bno, int userno) {
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectBtncheck");
		FoodBtnCheck fbc = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bno));
			pstmt.setInt(2, userno);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				fbc = new FoodBtnCheck();
				fbc.setBoardNo(rset.getInt("BOARD_NO"));
				fbc.setUserNo(rset.getInt("USERNO"));
				fbc.setBtnStyle(rset.getString("BTNTYPE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
			JDBCTemplate.close(rset);
		}
		return fbc;
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

	public int insertBtnCheck(Connection conn, String bno, int userno, String str) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBtnCheck");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bno));
			pstmt.setInt(2, userno);
			pstmt.setString(3, str);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int UpdatePlusButton(Connection conn, String str, String bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updatePlusButton" + str);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bno));
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int deleteBtnCheck(Connection conn, String bno, int userno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBtnCheck");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bno);
			pstmt.setInt(2, userno);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int UpdateMiusButton(Connection conn, String str, String bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateMiusButton" + str);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bno));
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
//
//	public int changeBtnCheck(Connection conn, String bno, int userno, String str) {
//		int result = 0;
//		PreparedStatement pstmt = null;
//		String sql = prop.getProperty("changeBtnCheck");
//		
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, str);
//			pstmt.setString(2, bno);
//			pstmt.setInt(3, userno);
//			result = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			JDBCTemplate.close(pstmt);
//		}
//		return result;
//	}

	public int updateBtncheck(Connection conn, String str, int userno, String bno) {
		// TODO Auto-generated method stub
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateBtnCheck");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, str);
			pstmt.setString(2, bno);
			pstmt.setInt(3, userno);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public FoodBtnCheck selectUserBtn(Connection conn, int bno, int userNo) {
		ResultSet rset = null;
		String sql = prop.getProperty("selectUserBtn");
		PreparedStatement pstmt = null;
		FoodBtnCheck fbc = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setInt(2, userNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				fbc = new FoodBtnCheck();
				fbc.setBoardNo(rset.getInt("BOARD_NO"));
				fbc.setUserNo(rset.getInt("USERNO"));
				fbc.setBtnStyle(rset.getString("BTNTYPE"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
			
		}
		
		return fbc;
	}

	public int FoodRankInsertImg(Connection conn, Attachment att) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("FoodRankInsertImg");
		try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, att.getOriginName());
					pstmt.setString(2, att.getChangeName());
					pstmt.setString(3, att.getFilePath());
					result = pstmt.executeUpdate();					
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

//	public ArrayList<Attachment> selectAttachment(Connection conn, int bno) {
//		ResultSet rset = null;
//		String sql = prop.getProperty("selectAttachment");
//		PreparedStatement pstmt = null;
//		ArrayList<Attachment> attList = null;
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, bno);
//			rset = pstmt.executeQuery();
//			while(rset.next()) {
//				attList = new ArrayList<>();
//				Attachment att = new Attachment();
//				att.setChangeName(rset.getString("CHANGE_NAME"));
//				att.setFilePath("FILE_PATH");
//				attList.add(att);
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			JDBCTemplate.close(rset);
//			JDBCTemplate.close(pstmt);
//			
//		}
//		
//		return attList;
//	}

	public Attachment selectAttachmentDetail(Connection conn, int bno) {
		ResultSet rset = null;
		String sql = prop.getProperty("selectAttachmentDetail");
		PreparedStatement pstmt = null;
		Attachment att = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				att = new Attachment();
				att.setOriginName("ORIGIN_NAME");
				att.setChangeName(rset.getString("CHANGE_NAME"));
				att.setFilePath(rset.getString("FILE_PATH"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
			
		}
		
		return att;
	}

	public ArrayList<Attachment> selectLocationFoodImg(Connection conn, ArrayList<Integer> locationBoard_no) {
		ResultSet rset = null;
		String sql = prop.getProperty("selectLocationFoodImg");
		PreparedStatement pstmt = null;
		ArrayList<Attachment> list = new ArrayList<>();
		Attachment att = null;
		try {
			for(int i = 0; i < locationBoard_no.size(); i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, locationBoard_no.get(i));
				rset = pstmt.executeQuery();
				if(rset.next()) {
					att = new Attachment();
					att.setChangeName(rset.getString("CHANGE_NAME"));
					att.setFilePath(rset.getString("FILE_PATH"));
					list.add(att);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	public int foodUpdateImg(Connection conn, int bno, Attachment att) {
		int result = 0;
		String sql = prop.getProperty("foodUpdateImg");
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, att.getOriginName());
			pstmt.setString(2, att.getChangeName());
			pstmt.setString(3, att.getFilePath());
			pstmt.setInt(4, bno);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int deleteFoodImg(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteFoodImg");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(conn);
		}
		
		return result;
	}
	
	/***
	 * 
	 * @return int
	 * @apiNote Board와 Attachment 두개를 INSERT ALL로 저장
	 */
	public int foodToInsert(Connection conn, Board b, Attachment att, FoodTogether ft) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("foodToInsert");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,    b.getUn());
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setString(4, ft.getMainAdress());
			pstmt.setString(5, ft.getSubAddress());
			pstmt.setInt(6,    ft.getPerson());
			pstmt.setString(7, ft.getEndTime());
			pstmt.setString(8, att.getOriginName());
			pstmt.setString(9, att.getChangeName());
			pstmt.setString(10,att.getFilePath());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}

		return result;
	}

	public ArrayList<HashMap<String, String>> selectFoodTogether(Connection conn) {
		ResultSet rset = null;
		String sql = prop.getProperty("selectFoodTogether");
		ArrayList<HashMap<String, String>> list = new ArrayList<>();
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while(rset.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("changeName", rset.getString("CHANGE_NAME"));
				map.put("boarTitle",  rset.getString("BOARD_TITLE"));
				map.put("person", 	  rset.getString("PERSON"));
				map.put("endTime",    rset.getString("END_TIME"));
				map.put("userId",     rset.getString("USERID"));
				map.put("filePath",   rset.getString("FILE_PATH"));
				map.put("boardNo",    rset.getString("BOARD_NO"));
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return list;
	}

	public HashMap<String, String> foodTogetherDetail(Connection conn, int boardNo) {
		ResultSet rset = null;
		String sql = prop.getProperty("foodTogetherDetail");
		HashMap<String, String> map = new HashMap<>();
		// controller에서 비어있는지로 확인할꺼기 때문이다.
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				// Detail view에서 필요한 것들 : 재목, 내용, 작성자 아이디, 작성자번호, 바뀐사진이름, 사진저장위치, 주소(main, sub),참여인원,종료시간
				map.put("title",      rset.getString("BOARD_TITLE"));
				map.put("content",    rset.getString("BOARD_CONTENT"));
				map.put("userId",     rset.getString("USERID"));
				map.put("userNo",     rset.getString("USERNO"));
				map.put("changeName", rset.getString("CHANGE_NAME"));
				map.put("filePath",   rset.getString("FILE_PATH"));
				map.put("mainAddress",rset.getString("MAINADDRESS"));
				map.put("subAddress", rset.getString("SUBADDRESS"));
				map.put("person",     rset.getString("PERSON"));
				map.put("endTime",    rset.getString("END_TIME"));
				map.put("boardNo",    rset.getString("boardNo"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return map;
	}

	public int deleteTogether(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String[] str = {"board", "att"}; // 2개다 상태 값 바꿔주자..
		for(int i = 0; i < str.length; i++) {			
			String sql = prop.getProperty("deleteTogether" + str[i]);
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bno);
				result = pstmt.executeUpdate();
				if(result < 0) return 0;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(pstmt);
			}
		}
		
		return result;
	}
}
