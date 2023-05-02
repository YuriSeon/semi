package com.kh.food.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.board.model.vo.Attachment;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class Chfood
 */
@WebServlet("/chfood.bo")
public class Chfood extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Chfood() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 그림이랑 메뉴 보여주고 땡긴다고 하면 네이버에서 가게 이름, 주소 
		ArrayList<Attachment> list = new FoodService().selectAllImg();
		
		request.setAttribute("Imglist", list);
		Gson gson = new Gson();
		
		response.setContentType("json/application; charset=UTF-8"); 
		gson.toJson(list, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
