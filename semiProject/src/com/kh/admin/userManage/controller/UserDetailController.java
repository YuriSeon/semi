package com.kh.admin.userManage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.admin.userManage.model.vo.User;
import com.kh.admin.userManage.model.vo.UserCondition;
import com.kh.admin.userManage.model.vo.UserManage;
import com.kh.bMember.model.vo.BMember;

/**
 * Servlet implementation class UserDetailController
 */
@WebServlet("/update.um")
public class UserDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		ArrayList<User> list = new UserManageService().detailInfo(userNo);
		
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("admin/views/userManage/userDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int point = Integer.parseInt(request.getParameter("point"));
		
		String FoodBoard = request.getParameter("foodBoard");
		
		int block = Integer.parseInt(request.getParameter("block"));
		
		int dmBlock = Integer.parseInt(request.getParameter("dmBlock"));
		
		int falseBlock = Integer.parseInt(request.getParameter("falseBlock"));
		
		int yellow = Integer.parseInt(request.getParameter("yellow"));
		
		int boardF = Integer.parseInt(request.getParameter("boardF"));
		
		int replyF = Integer.parseInt(request.getParameter("replyF"));
		
		UserCondition uc = new UserCondition(userNo, block, dmBlock, falseBlock, yellow, boardF, replyF);
		
		BMember b = new BMember();
		
		b.setUserNo(userNo);
		
		b.setPoint(point);
		
		UserManage um = new UserManage();
		
		um.setUserNo(userNo);
		
		um.setFoodBStatus(FoodBoard);
		
		ArrayList<User> list = new UserManageService().userUpdate(uc, b, um);
		
		response.setContentType("json/application; charset=UTF-8");
		
		new Gson().toJson(list, response.getWriter());
	}

}
