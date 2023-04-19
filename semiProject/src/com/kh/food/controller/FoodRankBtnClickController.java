package com.kh.food.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodRankBtnClickController
 */
@WebServlet(urlPatterns = {"/goodbtn", "/badbtn", "/reportbtn"})
public class FoodRankBtnClickController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodRankBtnClickController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String str = request.getServletPath();
		String bno = request.getParameter("bno");
		int num = new FoodService().UpdateBtn(str, bno);
		// 현재 추천수 비추천수 신고가 들어온다.
		response.getWriter().print(num+1); // 가져온거 + 1해야 눌렀을때 올라간다.
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
