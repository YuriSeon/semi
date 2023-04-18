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
		int listCount;	
		int currentPage; 
		int pageLimit; 
		int boardLimit; 
		
		int maxPage; 
		int startPage; 
		int endPage; 
		
	
		listCount = new VideoService().selectListCount();
	
		
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
		
		pageLimit = 10;
	
		boardLimit = 10;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
	
		startPage = (currentPage-1)/pageLimit * pageLimit +1;
	
		endPage = startPage +pageLimit-1;
		
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		
		
		PageInfo pi = new PageInfo(listCount,currentPage,startPage,endPage,boardLimit,pageLimit,maxPage);
	
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
