package com.kh.food.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodRankController
 */
@WebServlet("/foodRanking.bo")
public class FoodRankController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodRankController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Board> list = new FoodService().selectFoodRanking();
		request.setAttribute("list", list);
		int cp = 0;
		try {			
			cp = Integer.parseInt(request.getParameter("cp"));
		}catch(Exception e) {
			cp = 0;
		}
		request.setAttribute("cp", cp);
		request.getRequestDispatcher("views/food/foodRankBoard.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
