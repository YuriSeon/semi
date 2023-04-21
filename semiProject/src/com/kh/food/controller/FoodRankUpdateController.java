package com.kh.food.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodRankUpdateController
 */
@WebServlet("/foodRankUpdate.bo")
public class FoodRankUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodRankUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("targetBoardNo"));
		String title = request.getParameter("Btitle"); // 제목
		System.out.println(title);
		String newFoodName = request.getParameter("newfood");
		String content = request.getParameter("content"); // 내용
		
		String address1 = request.getParameter("saveAddress"); // 도로명 주소
		String address2 = request.getParameter("addressDetail"); // 상세주소
		
		String fullAddress = address1 + (address2.equals("")?"":" "+address2);
		
		Board b = new Board();
		b.setBoardNo(bno);
		b.setBoardTitle(title);
		b.setBoardContent(content);
		b.setAbbress(fullAddress);
//		if(foodCategoryNo == 0) {
			b.setFoodName(newFoodName);
//		}else {
//			b.setFoodName(String.valueOf(foodCategoryNo));
//		}	
		int result = new FoodService().UpdateFoodBoard(b); // 최종적으로 Dao에서 Board에 수정한 결과 값을 리턴해준다.
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/foodRanking.bo");
		}else {
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		request.setAttribute("boardNo", request.getParameter("bno"));
		request.setAttribute("foodName", request.getParameter("foodCate"));
		request.setAttribute("title", request.getParameter("Btitle"));
		request.setAttribute("content", request.getParameter("content"));
		request.setAttribute("address1", request.getParameter("address1"));
		
		request.getRequestDispatcher("views/food/foodRankUpdate.jsp").forward(request, response);
	}

}
