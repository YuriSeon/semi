package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;

/**
 * Servlet implementation class BamDetailController
 */
@WebServlet("/bamdetail.bo")
public class BamDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//bamListView.jsp에서 넘어온 게시글번호로 게시글 상세출력
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		
		//1.조회수증가
		int result = new BamService().increaseCount(boardNo);
		
		if(result>0) {//조회수증가 성공
			//2.게시글 조회
			Board b = new BamService().selectBam(boardNo);
			//3.첨부파일 조회
			Attachment at = new BamService().selectAttachment(boardNo);
			
			//가져왔으면 보내기
			request.setAttribute("b", b);
			request.setAttribute("at", at);
			request.getRequestDispatcher("views/bam/bamDetailView.jsp").forward(request, response);
		}else {//조회수증가 실패
			request.setAttribute("errorMsg", "게시글 조회 실패");
			
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
