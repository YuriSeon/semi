package com.kh.admin.userManage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class CheckListMainController
 */
@WebServlet("/main.ck")
public class CheckListMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckListMainController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String status = "Y"; // 가입자 중 활동중인 사람 전체를 조회할거라서 고정값으로 넣음
		
		int option = Integer.parseInt(request.getParameter("option"));
		
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
		
		ArrayList<BMember> list = new UserManageService().checkListRecent(pi, option);

		if(list.isEmpty()) {
			request.setAttribute("errorMsg", "회원 조회 실패");
			request.getRequestDispatcher("views/common/error.jsp").forward(request, response);
			
		} else {
			
			if(request.getParameter("check")==null) {
				
				request.setAttribute("list", list);
				request.setAttribute("pi", pi);
				request.getRequestDispatcher("admin/views/userManage/checkListMain.jsp").forward(request, response);
				
			} else {
				response.setContentType("json/application; charset=UTF8");
				new Gson().toJson(list, response.getWriter());
			}
			
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
