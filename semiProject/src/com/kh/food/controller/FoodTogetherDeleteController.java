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
 * Servlet implementation class FoodTogetherDeleteController
 */
@WebServlet("/deleteTogether.bo")
public class FoodTogetherDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodTogetherDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 삭제
		int bno = Integer.parseInt(request.getParameter("bno"));
		int result = new FoodService().deleteTogether(bno);
		
		if(result > 0) {
			File f = new File(request.getSession().getServletContext().getRealPath("/resources/food_files/") + request.getParameter("changeName"));
			f.delete();
			response.sendRedirect(request.getContextPath() + "/foodTogether.bo");
		}else {
			request.getRequestDispatcher("views/common/errorPage.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}
