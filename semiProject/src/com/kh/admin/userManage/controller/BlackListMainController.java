package com.kh.admin.userManage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.admin.userManage.model.vo.BlackList;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BlackListMainController
 */

// blackList 메인 페이지
@WebServlet("/main.bl")
public class BlackListMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlackListMainController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String status = request.getParameter("status");
		
		int listCount = new UserManageService().listCount(status);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		int boardLimit = 10;
		
		int pageLimit = 10;
		
		int startPage = (currentPage-1)/pageLimit *pageLimit +1;
		
		int endPage = startPage+ pageLimit -1;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
		
		ArrayList<BlackList> list = new UserManageService().selectAllBlackList(pi);

		request.setAttribute("pi", pi);
		
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("admin/views/userManage/blackListMain.jsp").forward(request, response);
	
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String input = (request.getParameter("input"));
		
		String option = request.getParameter("search_box");
		
		String status = "KA";

		int listCount = new UserManageService().listCount(status);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		int pageLimit = 10;
				
		int boardLimit = 10;
				
		int startPage = (currentPage-1)/pageLimit *pageLimit +1;
				
		int endPage = startPage + pageLimit -1;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
		
		
		ArrayList<BlackList> list = new UserManageService().selectList(input, option, pi);
		
		request.setAttribute("list", list);
		
		request.setAttribute("pi", pi);
	
		
		request.getRequestDispatcher("admin/views/userManage/blackListMain.jsp").forward(request, response);
	}

}
