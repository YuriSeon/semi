package com.kh.video.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.vo.Board;
import com.kh.video.model.service.VideoService;
import com.kh.video.model.vo.Video;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class InsInsertController
 */
@WebServlet("/insert.vd")
public class VideoInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VideoInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("views/video/VideoEnrollForm.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize  = 10* 1024 *1024;
			
			String savePath=request.getSession().getServletContext().getRealPath("/resources/video_files/");
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8"/*,new MyFileRenamePolicy()*/); // 쓰고 싶으면 만들어야함 
				
			Board b = new Board();
			Video vi = new Video();
			b.setBoardWriter(request.getParameter("userNo"));
			b.setBoardTitle(request.getParameter("title"));
			
			ArrayList<Video> list = new ArrayList<>();
			String key = "file1";
			if(multiRequest.getOriginalFileName(key) != null) {
			
				vi.setVideoOrigninName(multiRequest.getOriginalFileName(key));
				vi.setVideoChangeName(multiRequest.getFilesystemName(key));
				vi.setVideoPath("/resources/video_files/");
				
				int result = new VideoService().insertPhotoVideo(b,list);
			}
		}
	}
}


