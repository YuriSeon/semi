package com.kh.bMember.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.service.BMemberService;
import com.kh.bMember.model.vo.BMember;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login.me")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		System.out.println(userId);
		System.out.println(userPwd);
		BMember loginUser = new BMemberService().loginMember(userId,userPwd);
		
		if(loginUser != null) {
			
			if(loginUser.getPower().equals(("A"))) {//관리자페이지 이동
				request.getSession().setAttribute("loginUser", loginUser);
				request.getSession().setAttribute("alertMsg", "관리자 페이지로 이동합니다.");
				response.sendRedirect(request.getContextPath()+"/main.admin");
			} else if(loginUser.getStatus().contains("K")) {
				request.getSession().setAttribute("alertMsg", "강제탈퇴된 회원이라 커뮤니티 이용 및 재가입이 불가능합니다.");
				response.sendRedirect(request.getContextPath());
			} else if(loginUser.getStatus().equals("N")) {
				request.getSession().setAttribute("alertMsg", "탈퇴하신 회원입니다. 커뮤니티 이용을 원하시면 재가입을 해주세요.");
				response.sendRedirect(request.getContextPath());
			}else {//메인페이지 이동
				request.getSession().setAttribute("loginUser", loginUser);
				request.getSession().setAttribute("alertMsg", "로그인 성공");
				response.sendRedirect(request.getContextPath()+"/Main.co");
			}
		}else {
			request.setAttribute("errorMsg", "로그인 실패하였습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);

		}
	}

}
