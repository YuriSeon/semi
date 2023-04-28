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
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class ImportantListController
 */
@WebServlet("/important.ck")
public class ImportantListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImportantListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int listCount = new UserManageService().importantCount();

		int currentPage = Integer.parseInt(request.getParameter("currentPage"));

		int boardLimit = 10;
		
		int pageLimit = 10;
		
		int startPage = (currentPage-1)/pageLimit *pageLimit +1;
		
		int endPage = startPage +pageLimit -1;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
		
		ArrayList<User> list = new UserManageService().importantList(pi);
		
		request.setAttribute("list", list);
		
		request.setAttribute("pi", pi);
		
		request.setAttribute("currentPage", currentPage);
		
		request.getRequestDispatcher("admin/views/userManage/checkImportant.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int result = new UserManageService().yellowCard(userNo);
		
		if(result>0) {
			
			int listCount = new UserManageService().importantCount();

			int currentPage = Integer.parseInt(request.getParameter("currentPage"));

			int boardLimit = 10;
			
			int pageLimit = 10;
			
			int startPage = (currentPage-1)/pageLimit *pageLimit +1;
			
			int endPage = startPage +pageLimit -1;
			
			int maxPage = (int)Math.ceil((double)listCount/boardLimit);
			
			if(endPage>maxPage) {
				
				endPage = maxPage;
			}
			
			PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
			
			ArrayList<User> list = new UserManageService().importantList(pi);
			
			response.setContentType("json/application; charset=UTF-8");
			
			new Gson().toJson(list, response.getWriter());
			
		} else {
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	
	}

}
