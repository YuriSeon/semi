package com.kh.video.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.video.model.service.VideoService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;


/**
 * Servlet implementation class VideoListController
 */
@WebServlet("/list.vd")
public class VideoListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VideoListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//페이징 처리
		int listCount;	//현재 총 게시글의 개수
		int currentPage; //현재페이지
		int pageLimit; //페이지 하단에 보여질 페이징바의 페이지 최대 개수
		int boardLimit; //한 페이지에서 보여질 게시글 최대 개수
		
		int maxPage; //가장 마지막 페이지가 몇인지(총페이지의 개수)
		int startPage; //페이지 하단에 보여질 페이징바의 시작수
		int endPage; //페이지 하단에 보여질 페이징바의 끝 수
		
		//listCount : 총 게시글 개수 구하기
		listCount = new VideoService().selectListCount();
	
		//currentPage : 현재페이지
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
		//pageLimit : 페이지 하단에 보여질 페이징바의 페이지 최대 개수(목록 단위)
		pageLimit = 10;
		//boardLimit : 한 페이지에 보여질 게시글 개수 (게시글 단위)
		boardLimit = 10;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
	
		startPage = (currentPage-1)/pageLimit * pageLimit +1;
	
		endPage = startPage +pageLimit-1;
		
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		
		//페이지 정보들을 하나의 공간에 담아보내기
		PageInfo pi = new PageInfo(listCount,currentPage,pageLimit,boardLimit,maxPage,startPage,endPage);
	
		//현재 사용자가 요청한 페이지에 (currentPage)에 보여질 게시글 리스트 조회 
		ArrayList<Board> list = new VideoService().selectList(pi);
	
		request.setAttribute("list", list);
		request.setAttribute("pi", pi);
		request.getRequestDispatcher("views/video/VideoListView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
