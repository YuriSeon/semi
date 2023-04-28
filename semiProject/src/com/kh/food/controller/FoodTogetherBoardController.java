package com.kh.food.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.BMember;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodTogetherBoardController
 */
@WebServlet("/foodTogether.bo")
public class FoodTogetherBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodTogetherBoardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<HashMap<String, String>> list = new FoodService().selectFoodTogether();
		int loginUserno = ((BMember)request.getSession().getAttribute("loginUser")).getUserNo();
		int check = new FoodService().toCheck(loginUserno);
		request.setAttribute("list", list);
		request.setAttribute("check", check);
		
		request.getRequestDispatcher("views/food/foodTogether.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
