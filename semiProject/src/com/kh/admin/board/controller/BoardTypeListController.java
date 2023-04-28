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
 * Servlet implementation class BoardTypeListController
 */
@WebServlet("/typeList.abo")
public class BoardTypeListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardTypeListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int bType = Integer.parseInt(request.getParameter("bType"));
		
		int listCount = new BoardService().boardTypeCount(bType);
		
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
		
		ArrayList<Board> blist = new BoardService().boardTypeList(pi, bType);
		
		if(blist.isEmpty()) {
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		} else {
			request.setAttribute("blist", blist);
			request.setAttribute("pi", pi);
			request.getRequestDispatcher("admin/views/board/boardMain.jsp").forward(request, response);
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
