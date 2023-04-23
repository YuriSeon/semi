package com.kh.food.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.bMember.model.vo.BMember;
import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;
import com.kh.food.model.vo.FoodBtnCheck;

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
		int userno = Integer.parseInt(request.getParameter("gestNo"));
		
		int num = new FoodService().UpdateBtn(str, bno, userno);
		if(num > 0) {
			// 조회해오기
			FoodBtnCheck fbc = new FoodService().useBtn(Integer.parseInt(bno),((BMember)request.getSession().getAttribute("loginUser")).getUserNo());
			Board btnselect = new FoodService().selectDetail(Integer.parseInt(bno));
			Object[] data = {fbc, btnselect};
			response.setContentType("json/application; charset=UTF-8");
			Gson gson = new Gson();
			gson.toJson(data, response.getWriter());
		}else {
			System.out.println("에러 발생");
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
