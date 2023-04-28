package com.kh.food.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.BMember;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodTogetherDetailController
 */
@WebServlet("/foodtogetherdetail.bo")
public class FoodTogetherDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodTogetherDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시판에서 글 클릭했을 때 이쪽으로 QueryString : bno
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		HashMap<String, String> map = new FoodService().foodTogetherDetail(boardNo);
		int loginUserno = ((BMember)request.getSession().getAttribute("loginUser")).getUserNo();
		int check = new FoodService().toCheck(loginUserno);
		
		if(map.isEmpty()) {
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);;
		}else {
			request.setAttribute("map", map);
			request.setAttribute("check", check);
			request.getRequestDispatcher("views/food/foodTogetherDetail.jsp").forward(request, response);;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
