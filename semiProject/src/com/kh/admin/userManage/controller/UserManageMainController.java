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
import com.kh.admin.userManage.model.vo.User;
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
		
		String select = "recently"; // 메인페이지 시작시에는 최근 상태값 변한 순서로 조회해서 보여주기 위해서 고정값 넣음
		
		String status = "Y"; // 현재 사용자에 대한 정보 조회라서 고정값

		int listCount = new UserManageService().listCount(status);

		int currentPage = Integer.parseInt(request.getParameter("currentPage"));

		int boardLimit = 7;
		
		int pageLimit = 7;
		
		int startPage = (currentPage-1)/pageLimit *pageLimit +1;
		
		int endPage = startPage +pageLimit -1;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
		
		ArrayList<User> list = new UserManageService().selectUserList(pi, select);
		
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
		
		int listCount = new UserManageService().listCount(status);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		int boardLimit = 7;
		
		int pageLimit = 7;
		
		int startPage = (currentPage-1)/pageLimit *pageLimit +1;
		
		int endPage = startPage +pageLimit -1;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);

		ArrayList<User> list = new ArrayList<>();

		if (sort.equals("asc")) { // 오름차순 정렬
			
			list = new UserManageService().selectUserList(pi, select);
			
		} else {
			
			Collections.reverse(list = new UserManageService().selectUserList(pi, select));
		}

		response.setContentType("json/application; charset=UTF-8");

		new Gson().toJson(list, response.getWriter());

	}

}
