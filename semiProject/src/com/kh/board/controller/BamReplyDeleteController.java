package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BamService;

/**
 * Servlet implementation class BamReplyDeleteController
 */
@WebServlet("/deletereply.bo")
public class BamReplyDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamReplyDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//댓글 삭제 컨트롤
		//댓글 번호 가져옴
		int replyNo = Integer.parseInt(request.getParameter("replyNo"));
		//보드 번호
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		
		int result =new BamService().deleteReply(replyNo);
		
		if(result>0) {//댓글 삭제 성공
			request.setAttribute("alertMsg", "댓글 삭제 완료");
			response.sendRedirect(request.getContextPath()+"/bamdetail.bo?bno="+boardNo);
		}else {//댓글 삭제 실패
			request.setAttribute("errorMsg", "댓글 삭제 실패");
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
