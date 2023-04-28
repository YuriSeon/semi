package com.kh.admin.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Reply;

/**
 * Servlet implementation class BlurDetailController
 */
@WebServlet("/blurDetail.abo")
public class BlurDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlurDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		String status = "C"; // 블러처리된 게시글 상태값
		
		Board b = new BoardService().detailBoard(bno, status) ;
		
		Attachment a = new BoardService().selectAttachment(bno); 
		
		ArrayList<Reply> rList = new BoardService().selectReply(bno);
		
		if(b!=null) {
			if(a!=null) {
				request.setAttribute("a", a);
			}
			if(!rList.isEmpty()) {
				request.setAttribute("rList", rList);
			}
			request.setAttribute("b", b);
			request.getRequestDispatcher("admin/views/board/blurDetail.jsp").forward(request, response);
		} else {
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
