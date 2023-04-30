package com.kh.admin.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BoardSelectListController
 */
@WebServlet("/selectList.abo")
public class BoardSelectListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardSelectListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int category = Integer.parseInt(request.getParameter("category"));
		
		String searchContent = request.getParameter("search");
		
		int listCount = new BoardService().boardSelectCount(searchContent,category);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		int pageLimit = 7;
		
		int boardLimit = 7;
		
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		int startPage = (currentPage-1)/pageLimit *pageLimit +1;
		
		int endPage = startPage + pageLimit -1 ;
		
		if(endPage>maxPage) {
			
			endPage = maxPage;
		}
		
		PageInfo pi = new PageInfo(listCount, currentPage, startPage, endPage, boardLimit, pageLimit, maxPage);
		
		Board b = new Board();
		
		b.setBoardType(String.valueOf(category));
		
		b.setBoardContent(searchContent);
		
		ArrayList<Board> list = new BoardService().boardselectList(pi, b);
		
		request.setAttribute("list", list);
		
		request.setAttribute("currentPage", currentPage);
		
		request.setAttribute("pi", pi);
		
		request.getRequestDispatcher("admin/views/board/boardsearch.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
