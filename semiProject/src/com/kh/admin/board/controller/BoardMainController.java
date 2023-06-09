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
 * Servlet implementation class BoardMainController
 */

//게시판탭 클릭시 가장 먼저 나오는 화면으로 이동
@WebServlet("/main.abo")
public class BoardMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardMainController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 공지사항 타입 꺼내기
		int typeNo =1;
		
		// 게시글 페이징처리
		int listCount = new BoardService().boardCount(typeNo);
		
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
		
		// board main 페이지에 들어가면 가장 먼저 나올 공지사항 전체 조회
		ArrayList<Board> blist = new BoardService().boardList(pi, typeNo);
		
		int count = new BoardService().blurListCount(); // 관리가 필요한 게시글이 있는지 확인해 버튼 활성화 여부 위해서 조회
		
		if(listCount==0 || !blist.isEmpty()) { // 게시글리스트 총 수가 0이거나 list가 비어있지 않으면 조회 성공 
			
			
			request.setAttribute("blist", blist);
			
			request.setAttribute("pi", pi);
			
			request.setAttribute("count", count);
			
			request.getRequestDispatcher("admin/views/board/boardMain.jsp").forward(request, response);
			
		} else { // 반대의 경우 (count가 0이면서 list 비어있는 경우)
			
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
