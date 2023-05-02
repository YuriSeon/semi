package com.kh.bMember.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import com.kh.bMember.model.service.BMemberService;

/**
 * Servlet implementation class BMemberSearchController
 */
@WebServlet("/friendList.me")
public class BMemberSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BMemberSearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> list = new BMemberService().friendArr();
<<<<<<< HEAD

=======
		
>>>>>>> b6a934874e8e8cd81f364c89657c98c72e759221
		response.setContentType("json/aplication; charset=UTF-8");
		new Gson().toJson(list,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
		String userNick = request.getParameter("userNick");
		
		String searchNick = new BMemberService().searchNick(userNick);
		
		response.setContentType("text/plain; charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		out.print(searchNick);
		out.flush();
	}
}
