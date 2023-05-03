package com.kh.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.bMember.model.vo.BMember;
import com.kh.board.model.BadWord;
import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BamUpadteController
 */
@WebServlet("/bamupdate.bo")
public class BamUpadteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamUpadteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//글번호로 게시글 조회해서 전달
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		
	    Board b = new BamService().selectBam(boardNo);
	    Attachment at = new BamService().selectAttachment(boardNo);
	    
	    
		request.setAttribute("b", b);
		request.setAttribute("at", at);
		
		
		request.getRequestDispatcher("views/bam/bamUpdateForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 수정
		request.setCharacterEncoding("UTF-8");
		
		if(ServletFileUpload.isMultipartContent(request)) {
			//첨부파일 크기제한
			int maxsize = 10 * 1024 * 1024;
			
			//저장 경로
			String savePath = request.getSession().getServletContext().getRealPath("/resources/bam_files");
			
			MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxsize,"UTF-8",new BamFileRenamePolicy());
			
			//수정 정보들
			String title = multiRequest.getParameter("title");
			String content = multiRequest.getParameter("content");
			String category =multiRequest.getParameter("category");
			int boardNo = Integer.parseInt(multiRequest.getParameter("boardNo"));
			BMember loginUser = (BMember)request.getSession().getAttribute("loginUser");
			String userNo = Integer.toString(loginUser.getUserNo());
			
			//욕설 필터링(필터링횟수 업데이트를 위해서 (String)유저번호(Board b 에 담아서)가 있어야함 !!)
			//제목과 내용에 욕이 있는지 검사하고옴
			String arr[] = new BadWord().badWord(title, content);
			title=arr[0];	//필터링 한 제목
			content = arr[1]; //필터링 한 내용
			int count = Integer.parseInt(arr[2]); //욕설이 필터링 되었는지 count 0이면 욕없거나 필터에 없는 욕
			
			
			
			
			Board b = new Board();
			
			b.setBoardNo(boardNo);
			b.setBoardTitle(title);
			b.setBoardContent(content);
			b.setBoardType(category);
			b.setBoardWriter(userNo);
			
			Attachment at = null;
			
			if(multiRequest.getOriginalFileName("reUpfile")!=null) {
				//새로운 첨부파일이 있는경우
				at = new Attachment();
				
				at.setOriginName(multiRequest.getOriginalFileName("reUpfile"));
				at.setChangeName(multiRequest.getFilesystemName("reUpfile"));
				at.setFilePath("/resources/bam_files");
				
				if(multiRequest.getParameter("fileNo")!=null) {//기존 첨부파일이 있었던 경우
					
					at.setFileNo(Integer.parseInt(multiRequest.getParameter("fileNo")));
					
					//기존 첨부파일 삭제
					new File(savePath+"/"+multiRequest.getParameter("originFileName")).delete();
				}else {//기존 첨부파일이 없었던 경우
					at.setBoardNo(boardNo);
				}
			}
			int result = new BamService().updateBam(b,at,count);
		
			if(result>0) {
				request.setAttribute("alertMsg", "수정완료");
				response.sendRedirect(request.getContextPath()+"/bamdetail.bo?bno="+boardNo);
			}else {
				request.setAttribute("errorMsg", "게시글 수정 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
			
			
			
		}
		
	}

}
