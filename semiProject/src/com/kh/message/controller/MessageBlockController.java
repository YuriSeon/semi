package com.kh.message.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.BMember;
import com.kh.message.model.service.MessageService;
import com.kh.message.model.vo.MessageBlock;



/**
 * Servlet implementation class MessageBlockController
 */
@WebServlet("/msgblock.dm")
public class MessageBlockController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageBlockController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//유저 차단하기 컨트롤
		
		//로그인한 유저 번호
		String userNo = Integer.toString(((BMember)request.getSession().getAttribute("loginUser")).getUserNo());
		
		//차단할 유저 닉네임 받기
		String userNick = request.getParameter("userNick");
		//닉네임으로 회원번호 찾기
		String blockUser = Integer.toString(new MessageService().selectUserNo(userNick));
		
		//차단메모
		String blockContent = request.getParameter("blockContent");
		
		
		MessageBlock mb = new MessageBlock(userNo,blockUser,blockContent);
		
		//차단 등록 하고 옴
		int result = new MessageService().insertBlock(mb);
		
		if(result>0){//메시지 차단 등록 성공
			request.getSession().setAttribute("alertMsg", "차단 등록 완료");
			//여기 지금은 대나무숲 리스트로 보내지만 차단관리 페이지만들면 거기로 보내거나 원래 있던 페이지로 가야할듯
			response.sendRedirect(request.getContextPath()+"/bamlist.bo?currentPage=1");
		}else {//메시지 차단 등록 실패
			System.out.println("차단 실패");
			request.getSession().setAttribute("alertMsg", "이미 차단 되어있습니다.");
			response.sendRedirect(request.getContextPath()+"/bamlist.bo?currentPage=1");
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
