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
 * Servlet implementation class NoticeInsertController
 */
@WebServlet("/insert.abo")
public class NoticeInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		request.getRequestDispatcher("admin/views/board/noticeInsert.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		int bType; // board type 확인 후 공지사항 여부 확인 할 변수 지정
		
		if(request.getParameter("bType").equals("4")) {
			
			bType = 1; // 4라면 공지사항이라는거니까 1로 초기화
		} else {
			bType = 0;
		}
		
		String category = request.getParameter("boardtype");
		
		String title = request.getParameter("insertTitle");
		
		String content = request.getParameter("content");
		
		// session에 있는 로그인유저에서 번호 가져와서 사용할건데 일단 확인용으로 직접 번호 넣어서 insert진행
		// int userNo = ((BMember)request.getSession().getAttribute("loginUser")).getUserNo();
		
		int userNo = 1; // 확인용
		
		//dao에서 BMEMBER table join 안하려고 userno 스트링으로 바꿔서 보냄
		Board b = new Board(String.valueOf(userNo),category, title, content, bType);
		
		int result = new BoardService().insertNotice(b);
		
		if(result>0) {
		
			request.getSession().setAttribute("alertMsg", "게시글 등록 성공");
			response.sendRedirect(request.getContextPath()+"/main.abo?currentPage=1&typeNo=1");
			
		} else {
			request.setAttribute("errorMsg", "게시물 등록 실패");
			request.getRequestDispatcher("view/common/errorPage.jsp").forward(request, response);
		}
				
	}

}
