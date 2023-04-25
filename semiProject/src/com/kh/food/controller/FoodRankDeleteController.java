package com.kh.food.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodRankDeleteController
 */
@WebServlet("/foodRankDelete.bo")
public class FoodRankDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodRankDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		int result = new FoodService().deleteFoodRank(bno);
		if(result > 0) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/food_files/");
			String deleteName = request.getParameter("imgname");
			result = new FoodService().deleteFoodImg(bno);
			if(result > 0) {				
				File f = new File(savePath + deleteName);
				f.delete();
			}
		}
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/foodRanking.bo");
		}else {
			request.getRequestDispatcher("views/common/error.page").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
