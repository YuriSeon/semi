package com.kh.message.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.BMember;
import com.kh.message.model.service.MessageService;
import com.kh.message.model.vo.Message;
	//메시지 인서트용
/**
 * Servlet implementation class MessageInsertController
 */
@WebServlet("/insertMsg.dm")
public class MessageInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageInsertController() {
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
		//메시지 내용
		String msgContent=request.getParameter("msgContent");
		//유저 번호
		BMember loginUser = (BMember)request.getSession().getAttribute("loginUser");
		String userNo = Integer.toString(loginUser.getUserNo());
		//받는 유저닉네임
		String acceptNick = request.getParameter("acceptNick");
		//닉네임으로 받는 유저 번호 조회
		String acceptUserNo= Integer.toString(new MessageService().selectUserNo(acceptNick));
		
		
		if(userNo!=acceptUserNo) {//보내는 사람이랑 받는 받는사람이 같지 않아야 보냄
			
		Message msg = new Message();
		msg.setUserWriter(userNo);
		msg.setAcceptUser(acceptUserNo);
		msg.setMsgContent(msgContent);
		
		
		int result = new MessageService().insertMessage(msg);
		
		response.getWriter().print(result);
		
		}else {
			
		}
		
	}

}
