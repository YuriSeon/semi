package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MultipartDataSource;

/**
 * Servlet implementation class BamInsertController
 */
@WebServlet("/baminsert.bo")
public class BamInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//카테고리 불러와서 대나무숲 게시글 작성페이지로 넘어가기
		ArrayList<BamCategory> clist = new BamService().categoryList();
		
		request.setAttribute("clist", clist);
		request.getRequestDispatcher("views/bam/bamInsertView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 작성한거 인서트하는데 첨부파일도 포함될수 있어서 멀티로 보냄
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//최대 크기 지정
			int maxSize = 10 * 1024 * 1024;
			//전송할 파일 저장 위치
			String savePath = request.getSession().getServletContext().getRealPath("/resources/bam_files/");
			//파일 이름 변경
			MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8",new BamFileRenamePolicy());
			
			//insert할 변수들
			//카테고리 어떻게 하지?
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			String userNo = multiRequest.getParameter("userNo");
			
			Board b = new Board(카테고리?,title,content,userNo);
			
			
		}
		doGet(request, response);
	}

}
