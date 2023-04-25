package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BamService;

/**
 * Servlet implementation class BamReportController
 */
@WebServlet("/bamreport.bo")
public class BamReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamReportController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 신고
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		//신고하는 유저
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int result = new BamService().reportBam(boardNo,userNo);
		
		
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "신고 완료");
			response.sendRedirect(request.getContextPath()+"/bamdetail.bo?bno="+boardNo);
		}else {
			request.getSession().setAttribute("alertMsg", "이미 신고하셨습니다.");
			response.sendRedirect(request.getContextPath()+"/bamdetail.bo?bno="+boardNo);
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
