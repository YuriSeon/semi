package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.bMember.model.vo.BMember;
import com.kh.board.model.BadWord;
import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Reply;

/**
 * Servlet implementation class BamReplyController
 */
@WebServlet("/bamreply.bo")
public class BamReplyInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamReplyInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//댓글 리스트 불러오기
		
		//불러올 게시글 번호
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		ArrayList<Reply> rlist = new BamService().selectReplyList(bno);
		
		response.setContentType("json/aplication; charset=UTF-8");
		new Gson().toJson(rlist,response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//댓글 작성 컨트롤(insert)
	
		//댓글 내용
		String replyContent = request.getParameter("con");
		//댓글 작성된 게시글 번호
		int bno = Integer.parseInt(request.getParameter("bno"));
		//공지사항 판별
		int tno = Integer.parseInt(request.getParameter("btype"));
		//댓글 작성자 번호 
		String userNo = Integer.toString(((BMember)request.getSession().getAttribute("loginUser")).getUserNo());
		
		//욕설 필터링(필터링횟수 업데이트를 위해서 (String)유저번호(Board b 에 담아서)가 있어야함 !!)
		//제목과 내용에 욕이 있는지 검사하고옴
		String arr[] = new BadWord().badWord(replyContent);
		replyContent = arr[0]; //필터링 한 내용
		int count = Integer.parseInt(arr[1]);
		
		Reply r = new Reply();
		r.setBoardNo(bno);
		r.setReplyContent(replyContent);
		r.setReplyWriter(userNo);
		
		int result = new BamService().insertReply(r,tno,count);
		
		
		response.getWriter().print(result);
	}

}
