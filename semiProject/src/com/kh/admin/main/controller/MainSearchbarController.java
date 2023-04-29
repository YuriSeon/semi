package com.kh.admin.main.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.board.model.service.BoardService;
import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.bMember.model.vo.BMember;
import com.kh.board.model.vo.Board;

/**
 * Servlet implementation class MainSearchbarController
 */
@WebServlet("/mainSearch.menu")
public class MainSearchbarController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainSearchbarController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String search = request.getParameter("search");
		
		ArrayList<BMember> mList = new UserManageService().mainSearchUser(search);
		
		ArrayList<Board> bList = new BoardService().mainSearchBoard(search);
		
		request.setAttribute("mList", mList);
		
		request.setAttribute("bList", bList);
		
		request.setAttribute("search", search);
		
		request.getRequestDispatcher("admin/views/common/mainSearchResult.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
