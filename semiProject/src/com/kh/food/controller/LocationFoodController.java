package com.kh.food.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class LocationFoodController
 */
@WebServlet("/locationFood.bo")
public class LocationFoodController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LocationFoodController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String location = request.getParameter("location");
		String dong = (location.split(" ")[2]).substring(0,(location.split(" ")[2]).indexOf("동"));
		ArrayList<Board> list = new FoodService().locationFood(dong);
		ArrayList<Integer> bnoArr = new ArrayList<>();
		for(Board b : list) {
			bnoArr.add(b.getBoardNo());
		}
		
		ArrayList<Attachment> attList = new FoodService().selectLocationFoodImg(bnoArr);
		
		ArrayList<Object> objList = new ArrayList<>();
		objList.add(list);
		objList.add(attList);
		
		response.setContentType("json/application; charset=UTF-8");
		Gson gson = new Gson();
		gson.toJson(objList, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
