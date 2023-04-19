package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
import com.oreilly.servlet.MultipartRequest;
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
		
		request.getRequestDispatcher("views/bam/bamInsertView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//게시글 작성한거 인서트하는데 첨부파일도 포함될수 있어서 멀티로 보냄
		if(ServletFileUpload.isMultipartContent(request)) {
			
			//최대 크기 지정
			int maxSize = 10 * 1024 * 1024;
			//전송할 파일 저장 위치
			String savePath = request.getSession().getServletContext().getRealPath("/resources/bam_files/");
			//파일 이름 변경
			MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8",new BamFileRenamePolicy());
			
			//insert할 변수들
			String category = multiRequest.getParameter("category");
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			String userNo = multiRequest.getParameter("userNo");
			
			Board b = new Board();
			b.setBoardType(category); //대나무숲 카테고리 지만 보드타입에 우선 넣어둠
			b.setBoardTitle(title); //게시글 제목
			b.setBoardContent(content); //게시글 내용
			b.setBoardWriter(userNo); //작성자 회원번호
			
			Attachment at = null; //첨부파일이 없을때
			
			if(multiRequest.getOriginalFileName("upfile")!=null) {
				//첨부파일이 있을때
				
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upfile"));
				at.setChangeName(multiRequest.getFilesystemName("upfile"));
				at.setFilePath("/resources/bam_files");
			}
			int result =new BamService().insertBam(b,at);
			
			if(result>0) {
				
				request.getSession().setAttribute("alertMsg", "게시글 작성 완료");
				response.sendRedirect(request.getContextPath()+"/bamlist.bo?currentPage=1");
			}else {
				if(at!=null) {//
					new File(savePath+at.getChangeName()).delete();
				}else {
					request.setAttribute("errorMsg", "게시글 작성 실패");
					request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
				}
			}
			
			
			
			
//			
			
			
		}
		
	}

}
