package com.kh.food.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
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
				list.add(new Board(
							rset.getInt("BOARD_NO"),
							rset.getString("BOARD_TITLE"),
							rset.getString("FOOD_NAME"), // F_CATEGORY TABLE
							rset.getInt("GOOD"),
							rset.getDate("CREATE_DATE"),
							rset.getString("USERID"), // BMEMBER TABLE
							rset.getString("POINT") // BMEMBER TALBE
						));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return list;
	}

}
