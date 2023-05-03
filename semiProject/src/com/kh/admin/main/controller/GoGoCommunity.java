package com.kh.admin.main.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.service.BMemberService;
import com.kh.bMember.model.vo.BMember;

/**
 * Servlet implementation class GoGoCommunity
 */
@WebServlet("/com.go")
public class GoGoCommunity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoGoCommunity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userId = "admin"; 
		
		String userPwd = "1234";
		
		BMember loginUser = new BMemberService().loginMember(userId,userPwd);
		System.out.println(loginUser);
		request.getSession().setAttribute("loginUser", loginUser);
		
		response.sendRedirect(request.getContextPath()+"/Main.co");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
