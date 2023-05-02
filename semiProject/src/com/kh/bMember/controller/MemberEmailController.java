package com.kh.bMember.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.MailTest;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

/**
 * Servlet implementation class MemberEmailController
 */
@WebServlet("/sendEmail.me")
public class MemberEmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEmailController() {
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

		String recipient = request.getParameter("email");
		MailTest mailTest = new MailTest();
		String code = mailTest.getCode();
		String subject = "학교 인증용 메일입니다.";
		String content = "브레이크타임 인증 메일입니다.";


		 try {
			mailTest.sendMail(recipient, subject, content,code);
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().println(code);
			
		} catch (javax.mail.MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}

}
