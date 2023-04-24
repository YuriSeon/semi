package com.kh.food.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.BMember;
import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;
import com.kh.food.model.vo.FoodBtnCheck;

/**
 * Servlet implementation class FoodRankDetailController
 */
@WebServlet("/foodRankingDetail.bo")
public class FoodRankDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodRankDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		Board b = new FoodService().selectDetail(bno);
		
		FoodBtnCheck fbc = new FoodService().useBtn(bno,((BMember)request.getSession().getAttribute("loginUser")).getUserNo());
		request.setAttribute("FoodRanking", b);
		request.setAttribute("FoodBtnCheck", fbc);
		request.getRequestDispatcher("views/food/foodRankDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
