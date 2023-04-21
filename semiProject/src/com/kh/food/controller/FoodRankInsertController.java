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

/**
 * Servlet implementation class FoodRankInsertController
 */
@WebServlet("/rankInsert.bo")
public class FoodRankInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FoodRankInsertController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("views/food/foodRankInsert.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 내용 입력 받기
		request.setCharacterEncoding("UTF-8");

		String title = request.getParameter("Btitle"); // 제목
		String newFoodName = "";
		switch(Integer.parseInt(request.getParameter("foodselect"))) {
		
		case 1: newFoodName = "떡볶이";
			break;
		case 2: newFoodName = "김밥";
			break;
		case 3: newFoodName = "치킨";
			break;
		case 4: newFoodName = "피자";
			break;
		case 5: newFoodName = "파스타";
			break;
		case 0:
			newFoodName = request.getParameter("newfood");
			break;
		}

		String content = request.getParameter("content"); // 내용
		String address1 = request.getParameter("saveAddress"); // 지번
		String address2 = request.getParameter("addressDetail"); // 상세주소
		String userno = String.valueOf(((BMember)request.getSession().getAttribute("loginUser")).getUserNo()); // 로그인 유저 넘버 가져오기
		
		
		Board b = new Board();
		b.setBoardTitle(title);
		b.setBoardContent(content);
		b.setAbbress(address1 + " " + address2);
		b.setBoardWriter(userno);
		int num = new FoodService().foodRankInsert(b, newFoodName);
		if(num > 0) {
			response.sendRedirect(request.getContextPath() + "/foodRanking.bo");
		}else {
			System.out.println("FoodRankInsertController에서 오류 터졌어요");
		}
	}

}
