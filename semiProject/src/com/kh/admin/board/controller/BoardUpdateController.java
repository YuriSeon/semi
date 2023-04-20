package com.kh.admin.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.board.model.service.BoardService;
import com.kh.board.model.vo.Board;

/**
 * Servlet implementation class BoardUpdateController
 */
@WebServlet("/update.abo")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		Board b = new BoardService().selectBoard(bno);
		
		if(b!=null) {

			request.setAttribute("b", b);
			
			request.getRequestDispatcher("admin/views/board/boardUpdate.jsp").forward(request, response);
			
		} else {
			
			request.setAttribute("errorPage", "조회 실패");
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("updateTitle");
		
		String content = request.getParameter("content");
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		Board b = new Board();
	
		b.setBoardTitle(title);
		
		b.setBoardContent(content);
		
		b.setBoardNo(bno);
		
		int result = new BoardService().updateBoard(b);
		
		if(result>0) {
			
			request.getSession().setAttribute("alertMsg", "게시물 수정 성공");
			
			response.sendRedirect(request.getContextPath()+"/admin/views/board/boardMain.jsp?");
		} else {
			
			request.setAttribute("errorMsg", "게시물 수정 실패");
			
			request.getRequestDispatcher("views/common/errorPage.jap").forward(request, response);
		}
		
		
	}

}
