package com.kh.food.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("views/food/foodRankInsert.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 내용 입력 받기
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("Btitle"); // 제목
		String content = request.getParameter("content");  // 내용
		String address1 = request.getParameter("address"); // 도로명 주소
		String address2 = request.getParameter("addressDetail"); // 상세주소
		// 도로명주소 + " " + 상세주소 해서 보여줘야한다.
		request.setAttribute("title", title);
		request.setAttribute("content", content);
		request.setAttribute("address1", address1);
		request.setAttribute("address2", address2);
		
		// 원래는 sendRedirct로 해야한다. (
		request.getRequestDispatcher("views/food/foodRankDetail.jsp").forward(request, response);
	}

}
