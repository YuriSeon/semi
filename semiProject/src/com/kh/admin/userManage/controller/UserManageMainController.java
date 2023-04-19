package com.kh.admin.userManage.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class UserManageMainController
 */
@WebServlet("/main.um")
public class UserManageMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserManageMainController() {
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
		
		int endPage = startPage +pageLimit -1;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
		
		ArrayList<Object> list = new UserManageService().selectUserList(pi);
		
		request.setAttribute("list", list);
		
		request.setAttribute("pi", pi);

		request.getRequestDispatcher("admin/views/userManage/userManageMain.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String status = request.getParameter("status");
		
		String select = request.getParameter("select");
		
		String sort = request.getParameter("sort");
		System.out.println(select +" + "+ sort);
		int listCount = new UserManageService().listCount(status);
		
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
		
		ArrayList<Object> list = new ArrayList<>();
		
		//리스트 가져오기
		switch(select) {
		
		case "recently" :
				if(sort.equals("asc")) { // 오름차순 정렬
					// 맛집 게시물 랭킹순
					list = new UserManageService().selectUserList(pi);
				} else {
					Collections.reverse(list = new UserManageService().selectUserList(pi));
				}
				break;
				
		case "foodRank" : 
				if(sort.equals("asc")) { // 오름차순 정렬
					// 맛집 게시물 랭킹순
					list = new UserManageService().selectSortFR(pi);
				} else {
					Collections.reverse(list = new UserManageService().selectSortFR(pi));
				}
				break;
		
		case "total" : 
				if(sort.equals("asc")) { // 오름차순 정렬
					// 맛집 게시물 랭킹순
					list = new UserManageService().selectSortAct(pi);
				} else {
					Collections.reverse(list = new UserManageService().selectSortAct(pi));
					for(Object o : list) {
						
						System.out.println(o);
					}
				}
				break;
				
		}
	
		response.setContentType("json/application; charset=UTF-8");
		
		new Gson().toJson(list, response.getWriter());
		
	}

}
