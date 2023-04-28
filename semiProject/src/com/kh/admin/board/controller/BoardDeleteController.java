package com.kh.admin.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;

/**
 * Servlet implementation class BoardDeleteController
 */
@WebServlet("/delete.abo")
public class BoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 첨부파일이랑 댓글 상태 변경같이 해야함 
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		int result = new BoardService().deleteBoard(bno);
		
		if(result>0) {
			Attachment a = new BoardService().selectAttachment(bno);
			
			if(a!=null) {
				new File(a.getFilePath()+a.getChangeName()).delete();
			}
			
			result = new BoardService().deleteReply(bno);

			if(result>0) {
				request.getSession().setAttribute("alertMsg", "삭제되었습니다.");
				response.sendRedirect(request.getContextPath()+"/main.abo?typeNo=1&currentPage=1");
			}
		}
		//게시글 조회 실패 or 댓글 있을때 삭제 실패시 
		if(result==0) {
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
