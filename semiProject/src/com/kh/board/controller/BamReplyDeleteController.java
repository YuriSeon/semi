package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Reply;

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
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		//댓글 번호 가져옴
		int replyNo = Integer.parseInt(request.getParameter("replyNo"));
		//로그인 되어있는 회원 번호
		int userNo =Integer.parseInt(request.getParameter("userNo")) ;
		//댓글 정보 가져옴
		Reply r = new BamService().selectReply(replyNo);
		
		int result = 0;
		
		if(userNo==(Integer.parseInt(r.getReplyWriter()))||userNo==1) {//댓글 작성자랑 로그인유저가 같거나 관리자인 경우
			result =new BamService().deleteReply(replyNo,boardNo);
		}
		
		response.getWriter().print(result);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
