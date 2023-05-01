package com.kh.board.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Attachment;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BamImageUploadController
 */
@WebServlet("/bamUploadFile.bo")
public class BamImageUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamImageUploadController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//서머노트 이미지 업로드용인데 어려움
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			System.out.println("들어왔다");
			//최대 크기 지정
			int maxSize = 10 * 1024 * 1024;
			//전송할 파일 저장 위치
			String savePath = request.getSession().getServletContext().getRealPath("/resources/bam_files/");
			//파일 이름 변경
			MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8",new BamFileRenamePolicy());
			
			Attachment at = new Attachment();
			at.setOriginName(multiRequest.getOriginalFileName("file"));
			at.setChangeName(multiRequest.getFilesystemName("file"));
			at.setFilePath("/resources/bam_files");
			
			
			//BufferedImage image = ImageIO.read(at.getFilePath());
			System.out.println(at.getChangeName());
			System.out.println(at.getOriginName());
			
			
			response.getWriter().print(at.getFilePath());
		}
		
	}

}
