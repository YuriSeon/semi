package com.kh.admin.userManage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class CheckSelectListController
 */
@WebServlet("/select.ck")
public class CheckSelectListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckSelectListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int select = Integer.parseInt(request.getParameter("select"));
		
		String search = request.getParameter("search");
		
		int listCount = new UserManageService().ckCount(select, search);
		
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
		
		ArrayList<BMember> list = new UserManageService().checkSelectList(pi, select, search);
		
		if(listCount!=0 && list.isEmpty()) { // 리스트의 수가 0이 아닌데 list가 비어있을 땐 조회실패
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
		} else { // 조회 성공
			
			request.setAttribute("list", list);
			
			request.setAttribute("pi", pi);
			
			request.setAttribute("select", select);
			
			request.setAttribute("search", search);
			
			request.getRequestDispatcher("/admin/views/userManage/checkListSearch.jsp").forward(request, response);
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	}

}
