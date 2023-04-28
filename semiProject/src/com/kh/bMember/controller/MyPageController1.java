package com.kh.bMember.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.service.BMemberService;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.PageInfo;
import com.kh.message.model.vo.Message;

/**
 * Servlet implementation class MyPageController1
 */
@WebServlet("/list.me")
public class MyPageController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPageController1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int listCount;
		int currentPage;
		int pageLimit;
		int boardLimit;
		
		int maxPage;
		int startPage;
		int endPage;
		
		BMember loginUser = (BMember)request.getSession().getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		listCount = new BMemberService().selectListCount(userNo);
		
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		pageLimit = 5;
		
		boardLimit = 6;
		
		maxPage = (int)Math.ceil((double)(listCount)/boardLimit);
		
		startPage = (currentPage-1)/pageLimit * pageLimit +1;
		
		endPage = startPage+pageLimit-1;
		
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount,currentPage,startPage,endPage,boardLimit,pageLimit,maxPage);
		ArrayList<Message> list = new BMemberService().selectList(pi,userNo);
		
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);
		request.getRequestDispatcher("views/member/myPage1.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
