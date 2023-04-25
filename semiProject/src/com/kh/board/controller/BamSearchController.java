package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BamSearchController
 */
@WebServlet("/search.bo")
public class BamSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamSearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//대나무숲 페이지 만들기
		int listCount; //현재 총 게시글의 개수 
		int currentPage; //현재 페이지
		int pageLimit; //페이지 하단에 보여질 페이징바의 페이지 최대 개수
		int boardLimit; //한 페이지에서 보여질 게시글 최대 개수
				
		int maxPage; //가장 마지막 페이지가 몇인지 (총페이지의 개수)
		int startPage; //페이지 하단에 보여질 페이징바의 시작수
		int endPage; //페이지 하단에 보여질 페이징바의 끝 수 
				
		//어떤 걸로 검색할지 (제목(BOARD_TITLE),내용(BOARD_CONTENT))
		String category = request.getParameter("searchCategory");
		//검색 키워드
		String keyword = request.getParameter("keyword");
		
		listCount = new BamService().searchListCount(keyword);
	
		
				
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
				
		pageLimit =10;
				
		boardLimit= 10;
				
		maxPage =(int)Math.ceil((double)listCount/boardLimit);
				
		startPage = (currentPage-1)/pageLimit * pageLimit +1;
				
		endPage = startPage+pageLimit-1;
				
		if(endPage>maxPage) {
			endPage=maxPage;
		}
				
		PageInfo pi = new PageInfo(listCount,currentPage,startPage,endPage,boardLimit,pageLimit,maxPage);
				
		ArrayList<Board> list = new BamService().searchList(keyword,pi);
		
		if(currentPage==1) {//현재 페이지가 1이면 공지사항 가져옴
			ArrayList<Board> nlist = new BamService().selectNoticeList();
			nlist.addAll(list);
			request.setAttribute("list", nlist);
		}else {//1페이지가 아니면 공지사항 안가져옴
			request.setAttribute("list", list);
		}
		
		request.setAttribute("pi", pi);
		request.getRequestDispatcher("views/bam/bamListView.jsp").forward(request, response);
		
	
						
				
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
